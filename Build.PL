#!/usr/bin/perl -w

use strict;
use lib qw(lib inc);
use My::Build;

# new_from_context is broken: it does not restore
# @INC set in Build.PL before trying to load a base class not
# defined using ->subclass...
my $class = Module::Build->subclass
  ( class            => 'My::Build::new_from_context_is_broken',
    code             => <<'EOC' );
use lib qw(inc lib);
use My::Build;
@ISA = qw(My::Build);
EOC
my $build = $class->new
  ( module_name      => 'Alien::Selenium',
    license          => 'perl',
    build_depends    => { 'Test::More'        => 0,
                          'Archive::Zip'      => 1.00,
                          },
    );
$build->create_build_script;
