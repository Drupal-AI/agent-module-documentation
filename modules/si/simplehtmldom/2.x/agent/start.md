<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simplehtmldom API (simplehtmldom) — agent index

**A dependency-only bridge exposing the PHP Simple HTML DOM Parser library to Drupal code.**

- **Version:** 2.x (dev-2.x; library `simplehtmldom/simplehtmldom` 2.0-RC2)
- **Core:** ^8.8 || ^9.0 || ^10.0 || ^11
- **API:** call `str_get_html()`, `file_get_html()` and DOM/selector helpers from custom code
- No routes, permissions, services or config.

**Security:** no endpoints of its own. Treat any remote HTML you fetch and parse as untrusted; sanitize before re-output. Nothing anonymous or mutating is added by this module.
