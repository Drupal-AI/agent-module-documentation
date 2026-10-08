<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PHP Profiler — agent index

**Profiles Drupal with XHProf and uploads results to XHGui** (via `perftools/php-profiler`). Depends on `xhprof`.
Provides permissions. Version **1.0.x** (dev). Core `^9||^10||^11`.

Developer/diagnostic — captures **detailed, potentially sensitive** runtime data and **sends it to XHGui** (egress).
Keep to **development** only, use a trusted/access-controlled XHGui, gate the permission to developers, disable in
production (overhead). No content/access role.
