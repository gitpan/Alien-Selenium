package Alien::Selenium;

use strict;
use warnings;

use File::Copy ();
use File::Path ();

=head1 NAME

Alien::Selenium - installing and finding the Selenium Web test framework

=head1 SYNOPSIS

    use Alien::Selenium;

    my $version = Alien::Selenium->version;
    my $path    = Alien::Selenium->path;

    Alien::Selenium->install( $destination_directory );

=head1 DESCRIPTION

Please see L<Alien> for the manifesto of the Alien namespace.

=cut

use strict;

our $VERSION = '0.04';
our $SELENIUM_VERSION = '0.6.0';

sub version { $SELENIUM_VERSION }

sub path {
    my $base = $INC{'Alien/Selenium.pm'};

    $base =~ s{\.pm$}{/javascript};

    return $base;
}

sub install {
    my( $class, $dest_dir ) = @_;

    File::Path::mkpath $dest_dir;

    my $path = $class->path();
    foreach my $f ( grep { -f $_ }
                         glob "$path/*" ) {
        File::Copy::copy( $f, $dest_dir )
            or die "Can't copy $f to $dest_dir: $!";
    }
}

=head1 AUTHOR

Mattia Barbon <mbarbon@cpan.org>

=head1 LICENSE

Copyright (c) 2005-2006 Mattia Barbon <mbarbon@cpan.org>

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself

Please notice that Selenium comes with its own licence.

=cut

1;
