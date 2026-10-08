<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Module Manager — agent index

**Downloads and installs Drupal.org modules from the web UI** (download release ZIP → Composer validate → enable).
Gated by core's `administer modules`. Version **1.0.4**. Core `^10||^11`.

**Code-execution-capable** — installing a module adds executable code and **bypasses controlled deployment**; an
`administer modules` compromise → arbitrary code. Keep the permission to fully-trusted admins, prefer Composer
deployment, consider `disable_web_install` on hardened/production sites. Use deliberately, ideally non-prod.
