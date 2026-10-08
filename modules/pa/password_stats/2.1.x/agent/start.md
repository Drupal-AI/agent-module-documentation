<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Password Stats — agent index

**Provides stats about the algorithms used in stored password hashes** (find legacy/weak hashes to rehash). Version
**2.1.0**. Core `^10.1||^11`.

**Security-positive** audit — reads **hashed** pass values only (never plaintext), classifies by algorithm. Hashes
are sensitive: keep stats/Drush commands to trusted admins. No access role.
