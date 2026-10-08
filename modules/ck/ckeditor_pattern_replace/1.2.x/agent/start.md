<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Pattern replace (ckeditor_pattern_replace) — agent index
**Text-format filter applying admin-defined `pattern|replacement` regex rules to field output via `preg_replace()`.**

- **Version:** 1.2.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Depends on:** `drupal:ckeditor`
- **Filter:** id `ckeditor_pattern_replace` (`TYPE_HTML_RESTRICTOR`) in `src/Plugin/Filter/CkeditorPatternReplace.php`; setting is one `/regex/|replacement` per line; runs `preg_replace()` in order.
- **Config:** per text format (Text formats and editors; requires `administer filters`).
- **Security:** Patterns are admin-supplied and trusted — restrict `administer filters`. `preg_replace` with admin patterns; the code-executing `/e` modifier was removed in PHP 7, so no code exec on modern PHP. No routes or anonymous endpoints.
