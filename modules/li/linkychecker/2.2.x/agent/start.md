<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Linkychecker — agent index

**Checks content links for broken/dead URLs** (detect 404s so editors can fix them). Requires PHP 8.1; Drush
commands; provides permissions. Version **2.2.2**. Core `>=10`.

Admin/content-audit — makes outbound HTTP requests to check links (run on a schedule/Drush); broken-link
report is admin-oriented. No access role beyond permission.
