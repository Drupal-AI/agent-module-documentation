<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Yoast SEO Localizer (yoast_seo_i18n) — agent index

**Translates the yoast_seo (Real-Time SEO) content-analysis widget into the site language via Drupal locale.**

- **Version:** 1.0.1 → dir 1.0.x
- **Core:** ^10 || ^11 || ^12
- **Dependencies:** yoast_seo, locale
- **Interface:** no routes/permissions/services — locale string registration + translated JS
- **Use:** enable on a multilingual site with yoast_seo, install target languages, import translations
- **Security:** No HTTP surface, no configuration, no external calls. No security findings.
