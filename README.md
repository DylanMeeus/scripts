cb-steam
========

Steam for Debian 7-based distributions.

Crunchbang forum threads:

http://crunchbang.org/forums/viewtopic.php?id=24711&p=1

http://crunchbang.org/forums/viewtopic.php?id=33349

Potential issues:

https://github.com/GhostSquad57/Steam-Installer-for-Wheezy/wiki

Note: LC_ALL=C is only supported by Steam as "fallback", which may cause some games to fail. This script correctly installs the US locale if not present.

If you get a checksum error, then Steam was likely updated. Open an issue or remove the offending sha1sum line.
