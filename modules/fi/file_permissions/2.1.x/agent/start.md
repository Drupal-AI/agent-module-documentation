<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Permissions — agent index

**Drush commands to set local filesystem permissions/ownership** and ensure the protective `.htaccess` exists
in the public/private files directories. Drush commands. Version **2.1.3**. Core `^9||^10||^11`.

Developer/DevOps CLI (chmod/chown — run as an appropriate user). Mildly **security-positive** (correct
ownership + `.htaccess` hardens the file setup). No runtime access role.
