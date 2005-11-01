Alien::Selenium automatically downloads and installs the Selenium
web testing framework.

Copyright (c) 2005 Mattia Barbon.
This package is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

Please notice that Selenium comes with its own license.

To install:

    perl Build.PL
    perl Build # fetch and unpack Selenium
    perl Build test
    perl Build install

If fetching the Selenium distribution fails for any reason,
putting the manually-downloaded archive inside the build
directory should suffice to proceed.
