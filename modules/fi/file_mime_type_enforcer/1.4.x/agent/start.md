<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File MIME Type Enforcer — agent index

**Enforces matching MIME types between Drupal's extension-based guesser and Symfony fileinfo (content-based) on
uploads**, with configurable mappings. Depends on core `file`, `system`. Version **1.4.0**. Core `^10||^11`.

**Security-positive** upload hardening — blocks MIME-spoofed uploads (a `.png` that is really HTML/SVG/script →
stored XSS/disguised executables). Configure allowed mappings; combine with core upload restrictions. No access
role.
