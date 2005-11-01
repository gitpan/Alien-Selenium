#!/usr/bin/perl -w

use strict;
use lib qw(lib inc);
use My::Build;

my $build = My::Build->new
  ( module_name      => 'Alien::Selenium',
    license          => 'perl',
    build_depends    => { 'Test::More'        => 0,
                          'Archive::Zip'      => 1.00,
                          },
    );
$build->create_build_script;
