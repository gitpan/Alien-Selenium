package My::Build;

use strict;
use base qw(Module::Build);
use Config;
use Alien::Selenium;
use File::Path ();
use File::Copy ();
use File::Basename;
use File::Spec;

sub ACTION_build {
    my $self = shift;

    $self->SUPER::ACTION_build;
    $self->fetch_selenium;
    $self->extract_selenium;
    $self->install_selenium;
}

sub selenium_archive {
    return join '', 'selenium-', Alien::Selenium->version, '.zip';
}

sub selenium_url {
    return 'http://gforge.public.thoughtworks.org/download.php/51/' 
      . $_[0]->selenium_archive;
}

sub selenium_directory {
    return join '', 'selenium-', Alien::Selenium->version;
}

sub fetch_selenium {
    my $self = shift;

    return if -f $self->selenium_archive;
    require File::Fetch;

    print "Fetching Selenium...\n";

    my $path = File::Fetch->new
      ( uri => $self->selenium_url )->fetch;
    die 'Unable to fetch archive' unless $path;
}

sub extract_selenium {
    my $self = shift;

    return if -d $self->selenium_directory;
    my $archive = $self->selenium_archive;

    print "Extracting Selenium...\n";

    eval { require Archive::Zip };
    if( $@ ) {
        die <<EOT
Please either install Archive::Zip or manually extract
the Selenium distribution inside the build directory.
EOT
    }

    my $zip = Archive::Zip->new( $archive );
    $zip->extractTree == Archive::Zip::AZ_OK() or die 'Error extracting file';
}

sub install_selenium {
    my $self = shift;

    print "Installing Selenium...\n";

    File::Path::mkpath( 'blib/lib/Alien/Selenium/javascript' )
        or die "mkpath: $!, $@" unless -d 'blib/lib/Alien/Selenium/javascript';

    my $final = 'blib/lib/Alien/Selenium/javascript';
    my @files = grep { -f $_ }
                glob( $self->selenium_directory . '/selenium/*' );

    foreach my $file ( @files ) {
        my $dest = File::Spec->catfile
                       ( $final, File::Basename::basename( $file ) );
        print $file, ' => ', $dest, "\n";
        File::Copy::copy( $file, $dest ) or die "copy: $!, $@";
    }
}

1;
