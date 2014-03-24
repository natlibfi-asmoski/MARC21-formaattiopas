#!/usr/bin/perl

# html2xml.pl -- simple script used to generate
# XML files from original MARC21 standard translation
# HTML files.
# Usage:
# $0 html_file > xml_file
#
# Copyright (c) National Library of Finland 2013-2014
# All Rights Reserved.
#
# Author: Leszek Manicki (leszek.z.manicki@helsinki.fi).
#
# Based strictly on similar script by Ere Maijala.

use strict;
use utf8;
use HTML::TreeBuilder;
use HTML::TagFilter;
use HTML::Entities;

binmode STDOUT, ':utf8';

use constant
{
  TYPE_LEADER_DIR => 0,
  TYPE_CONTROL => 1,
  TYPE_DATA => 2,
};

my $type = 'hold';

# MAIN
{
  print qq|<?xml version="1.0" encoding="utf-8"?>
<?xml-stylesheet type="text/xsl" href="marc21$type.xsl"?>

<fields>
|;

  my $root = HTML::TreeBuilder->new();
  $root->parse_file($ARGV[0]) || die("Could not open input file $ARGV[0]: $!");

  my $header_span = $root->find('span');
  my $span_content = $header_span->as_trimmed_text();
  if ( $span_content =~ /Päivitetty viimeksi ([0-3]?[0-9]\.[0-2]?[0-9]\.20[0-9][0-9])/) {
    my $modification_date = $1;
    printxml("  <modified>$modification_date</modified>\n");
  }
  my $main = $root->find('h2');

  my $title = $main->as_trimmed_text();

  if ($title =~ /Nimiö ja/)
  {
    printxml("  <leader-directory>\n");
    printxml("    <title>$title</title>\n");
    parse_fields($root, TYPE_LEADER_DIR);
    printxml("  </leader-directory>\n");
  }
  elsif ($title =~ /Kontrolliken/)
  {
    printxml("  <controlfields>\n");
    printxml("    <title>$title</title>\n");
    parse_fields($root, TYPE_CONTROL);
    printxml("  </controlfields>\n");
  }
  else
  {
    printxml("  <datafields>\n");
    printxml("    <title>$title</title>\n");
    parse_fields($root, TYPE_DATA);
    printxml("  </datafields>\n");
  }
  printxml("</fields>\n");
}

use constant
{
  POS_NONE => 0,
  POS_TITLE => 1,
  POS_FIELDS => 2,
  POS_POSITIONS => 3,
  POS_INDICATORS => 4,
  POS_SUBFIELDS => 5,
  POS_EXAMPLES => 6,
};

sub parse_fields($$)
{
  my ($main, $type) = @_;

  my $fieldname = 'datafield';
  $fieldname = 'controlfield' if ($type == TYPE_CONTROL);

  my $description_done = 0;
  my $description_paragraph = 1;
  my $field_open = 0;
  my $values_open = 0;
  my $leader = 0;

  my $tf = HTML::TagFilter->new(allow => {}, strip_comments => 1);

  my @content = $main->find('body')->content_list();
  my $pos = POS_NONE;

  for (my $i = 0; $i < scalar(@content); $i++)
  {
    my $field = @content[$i];
    my $tag = $field->tag();
    #print "tag: $tag, pos: $pos\n";

    if ($pos == POS_NONE)
    {
      $pos = POS_TITLE if ($tag eq 'h2');
    }
    elsif ($pos == POS_TITLE)
    {
      if ($tag eq 'p')
      {
        printxml('    <description>' . get_text($field) . "</description>\n") unless ($field->find('a') && $field->as_trimmed_text() =~ /-etusivulle/);
      } elsif ($tag eq 'h3') {
        $pos = POS_FIELDS;
      }
    }
    if ($pos == POS_FIELDS)
    {
      if ($tag eq 'h3')
      {
        if ($field_open)
        {
          close_field($type, $leader, $fieldname);
          $leader = 0;
          $field_open = 0;
        }

        my $data = $field->as_trimmed_text();

        if ( $type != TYPE_LEADER_DIR && $data !~ /^\d/) {
          next;
        }

        if ($type == TYPE_LEADER_DIR)
        {
          if ($data =~ /Nimi/i)
          {
            printxml("    <leader>\n");
            $leader = 1;
          }
          else
          {
            printxml("    <directory>\n");
            $leader = 0;
          }
        }
        else
        {
          my ($code, $name) = $data =~ /([\dX]*)(.*)/;
          my $repeatable = '';
          if ($name =~ s/ \(ET\)//)
          {
            $repeatable = 'N';
          }
          elsif ($name =~ s/ \(T\)//)
          {
            $repeatable = 'Y';
          }

          my $typestr = '';
          my $anchor = $field->find('a');
          $typestr = ' type="' . $anchor->attr('name') . '"' if (defined($anchor) && $anchor->attr('name') && $anchor->attr('name') ne $code);

          $name =~ s/^ - //;
          $name =~ s/^--//;
          $name = substr($name, 0, 1) . lcx(substr($name, 1, length($name)));
          printxml("    <$fieldname tag=\"$code\"$typestr repeatable=\"$repeatable\">\n");
          printxml("      <name>$name</name>\n");
        }
        $field_open = 1;
        $description_done = 0;
        $description_paragraph = 1;
      }
      elsif ($field_open)
      {
        if ($tag eq 'p' && !$description_done)
        {
          my $title = get_text($field);
          if ($title !~ /Sivun alkuun/i)
          {
            printxml("      <description paragraph=\"$description_paragraph\">$title</description>\n");
            ++$description_paragraph;
          }
          else
          {
            $description_done = 1;
            next;
          }
        }
        elsif ($tag eq 'h4')
        {
          $description_done = 1;
          my $data = $field->as_trimmed_text();
          if ($data =~ /Merkkipaik/)
          {
            $pos = POS_POSITIONS;
            printxml("      <positions>\n");
          }
          elsif ($data =~ /Indikaat/)
          {
            $pos = POS_INDICATORS;
            printxml("      <indicators>\n");
          }
          elsif ($data =~ /Osakent/)
          {
            $pos = POS_SUBFIELDS;
            printxml("      <subfields>\n");
          }
          elsif ($data =~ /Esimerk/)
          {
            $pos = POS_EXAMPLES;
            printxml("      <examples>\n");
          }
          next;
        }
      }
    }
    if ($pos == POS_POSITIONS)
    {
      if ($tag eq 'ul')
      {
        my @position_list = $field->content_list();
        foreach my $position (@position_list)
        {
          my $data = get_text($position);
          my ($pos, $name) = $data =~ /(.*?) -(.*)/;
          $pos = $tf->filter($pos);
          $name =~ s/^[\s-]//g;
          my $description = '';
          if ($name =~ /(.*?)<br \/>(.*)/)
          {
            $name = $1;
            $description = $2;
            $description =~ s/^\s*//;
          }
          printxml("        <position pos=\"$pos\">\n");
          printxml("          <name>$name</name>\n");
          printxml("          <description>$description</description>\n") if ($description);

          my $values = $position->find('ul');
          if (defined($values))
          {
            my @value_list = $values->content_list();
            foreach my $value (@value_list)
            {
              my $data = get_text($value);
              $data =~ s/^\s*//;
              if ($data =~ /(.*?) -(.*)/)
              {
                my ($code, $name) = ($1, $2);
                $code = $tf->filter($code);
                $name =~ s/^[\s-]//g;
                my $description = '';
                if ($name =~ /(.*?)<br \/>(.*)/)
                {
                  $name = $1;
                  $description = $2;
                }
                if (!$values_open)
                {
                  printxml("          <values>\n");
                  $values_open = 1;
                }
                printxml("            <value code=\"$code\">\n");
                printxml("              <name>$name</name>\n");
                printxml("              <description>$description</description>\n") if ($description);
                printxml("            </value>\n");
              }
              else
              {
                # Must be a description
                printxml("          <description>$data</description>\n");
              }
            }
            if ($values_open)
            {
              printxml("          </values>\n");
              $values_open = 0;
            }
          }

          printxml("        </position>\n");
        }
        printxml("      </positions>\n");
        $pos = POS_FIELDS;
      }
    }
    if ($pos == POS_INDICATORS)
    {
      if ($tag eq 'ul')
      {
        my @indicator_list = $field->content_list();
        foreach my $indicator (@indicator_list)
        {
          my $data = get_text($indicator);
          my ($num_text, $name) = $data =~ /(.*?) -(.*)/;
          $num_text = $tf->filter($num_text);
          my $num = ($num_text =~ /Toinen/) ? '2' : '1';
          $name =~ s/^[\s-]//g;
          printxml("        <indicator num=\"$num\">\n");
          printxml("          <description>$name</description>\n");

          my $values = $indicator->find('ul');
          if (defined($values))
          {
            my @value_list = $values->content_list();
            foreach my $value (@value_list)
            {
              my $data = get_text($value);
              $data =~ s/^\s*//;
              if ($data =~ /(.*?) -(.*)/)
              {
                my ($code, $name) = ($1, $2);
                $code = $tf->filter($code);
                $name =~ s/^[\s-]//g;
                if (!$values_open)
                {
                  printxml("          <values>\n");
                  $values_open = 1;
                }
                printxml("            <value code=\"$code\">\n");
                printxml("              <description>$name</description>\n");
                printxml("            </value>\n");
              }
              else
              {
                # Must be a description
                printxml("          <description>$data</description>\n");
              }
            }
            if ($values_open)
            {
              printxml("          </values>\n");
              $values_open = 0;
            }
          }

          printxml("        </indicator>\n");
        }
        printxml("      </indicators>\n");
        $pos = POS_FIELDS;
      }
    }
    if ($pos == POS_SUBFIELDS)
    {
      if ($tag eq 'ul')
      {
        my @subfield_list = $field->content_list();
        foreach my $subfield (@subfield_list)
        {
          my $data = get_text($subfield);
          my ($code, $name) = $data =~ /(.*?) -(.*)/;
          $code = $tf->filter($code);
          $code =~ s/^\$//;
          $code =~ s/^‡//;
          $name =~ s/^[\s-]//g;
          my $description = '';

          my $repeatable = '';
          if ($name =~ s/ \(ET\)(.*)//)
          {
            $repeatable = 'N';
            $description = $1;
          }
          elsif ($name =~ s/ \(T\)(.*)//)
          {
            $repeatable = 'Y';
            $description = $1;
          }
          elsif ($name =~ /(.*?)<br \/>(.*)/)
          {
            $name = $1;
            $description = $2;
            $description =~ s/^\s*//;
          }
          $description =~ s/^<br \/>//;
          $description =~ s/^[\s-]//g;

          printxml("        <subfield code=\"$code\" repeatable=\"$repeatable\">\n");
          printxml("          <name>$name</name>\n");
          printxml("          <description>$description</description>\n") if ($description);

          my $values = $subfield->find('ul');
          if (defined($values))
          {
            my @value_list = $values->content_list();
            foreach my $value (@value_list)
            {
              my $data = get_text($value);
              $data =~ s/^\s*//;
              if ($data =~ /(.*?) -(.*)/)
              {
                my ($code, $name) = ($1, $2);
                $code = $tf->filter($code);
                $name =~ s/^[\s-]//g;
                my $description = '';
                if ($name =~ /(.*?)<br \/>(.*)/)
                {
                  $name = $1;
                  $description = $2;
                }
                if (!$values_open)
                {
                  printxml("          <values>\n");
                  $values_open = 1;
                }
                printxml("            <value code=\"$code\">\n");
                printxml("              <name>$name</name>\n");
                printxml("              <description>$description</description>\n") if ($description);
                printxml("            </value>\n");
              }
              else
              {
                # Must be a description
                printxml("          <description>$data</description>\n");
              }
            }
            if ($values_open)
            {
              printxml("          </values>\n");
              $values_open = 0;
            }
          }

          printxml("        </subfield>\n");
        }
        printxml("      </subfields>\n");
        $pos = POS_FIELDS;
      }
    }
    if ($pos == POS_EXAMPLES)
    {
      if ($tag eq 'p')
      {
        my $data = get_text($field);
        if ($data =~ /Sivun alkuun/i)
        {
          printxml("      </examples>\n");
          $pos = POS_FIELDS;
          next;
        }
        printxml("        <example>\n");
        printxml("          <text>$data</text>\n");
        my $next = @content[$i + 1];
        if (defined($next) && $next->tag() eq 'blockquote')
        {
          my $para = $next->find('p');
          $data = get_text(defined($para) ? $para : $next);
          $data =~ s/^<(b|i)>//;
          $data =~ s/<\/(b|i)>\s*$//;
          printxml("          <description>$data</description>\n");
        }
        printxml("        </example>\n");
      }
    }
  }
  if ($field_open)
  {
    close_field($type, $leader, $fieldname);
    $field_open = 0;
    $leader = 0;
  }
}

sub close_field($$$)
{
  my ($type, $leader, $fieldname) = @_;

  if ($type == TYPE_LEADER_DIR)
  {
    if ($leader)
    {
      printxml("    </leader>\n");
    }
    else
    {
      printxml("    </directory>\n");
    }
  }
  else
  {
    printxml("    </$fieldname>\n");
  }
}

sub get_text($)
{
  my ($root) = @_;

  my $str = '';
  foreach my $node ($root->content_list())
  {
    if (ref($node))
    {
      my $tag = $node->tag();
      if ($tag =~ /^(b|strong|a|i|em|br)$/)
      {
        my $data;
        $data = $node->as_HTML('<>&');
        chomp($data);
        $str .= $data;
      }
    }
    else
    {
      $str .= HTML::Entities::encode($node, '<>&\xa0');
    }
  }
  return $str;
}

sub convert_href($)
{
  my ($href) = @_;

  if ($href =~ /^[0-9xX-]+\.htm$/ || $href =~ /^[0-9xX-]+\.htm\#/)
  {
    $href =~ s/\.htm/\.xml/;
  }
  return $href;
}

sub printxml($)
{
  my ($str) = @_;

  $str =~ s/&/&amp;/g;
  $str =~ s/<b>/<strong>/g;
  $str =~ s/<\/b>/<\/strong>/g;
  $str =~ s/<br>/<br\/>/g;
  $str =~ s/<i>/<em>/g;
  $str =~ s/<\/i>/<\/em>/g;
  $str =~ s/&nbsp;/ /g;
  $str =~ s/‡/&#8225;/g;

  $str =~ s/<a([^>]*)href="([^"]*)"/sprintf("<a${1}href=\"%s\"", convert_href($2))/ge;

  print $str;
}

sub lcx($)
{
  my ($str) = @_;

  $str = lc($str);
  $str =~ tr/ÅÄÖ/åäö/;

  return $str;
}
