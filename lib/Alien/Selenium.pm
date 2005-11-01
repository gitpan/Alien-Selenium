package Alien::Selenium;

=head1 NAME

Alien::Selenium - installing and finding the Selenium Web test framework

=head1 SYNOPSIS

    use Alien::Selenium;

    my $version = Alien::Selenium->version;
    my $path    = Alien::Selenium->path;

=head1 DESCRIPTION

Please see L<Alien> for the manifesto of the Alien namespace.

=cut

use strict;

our $VERSION = '0.01';

sub version { '0.6.0' }

sub path {
    my $base = $INC{'Alien/Selenium.pm'};

    $base =~ s{\.pm$}{/javascript};

    return $base;
}

=head1 AUTHOR

Mattia Barbon <mbarbon@cpan.org>

=head1 LICENSE

Copyright (c) 2005 Mattia Barbon <mbarbon@cpan.org>

This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself

Please notice that Selenium comes with its own licence.

=cut

1;
