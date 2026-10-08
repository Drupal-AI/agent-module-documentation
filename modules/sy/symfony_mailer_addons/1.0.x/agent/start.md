<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Symfony Mailer Addons (symfony_mailer_addons) — agent index
**Add-ons for Symfony Mailer: multilingual email footer links + template-suggestion and legacy-body adjuster plugins.**

- **Version:** 1.0.x (1.0.0-beta1)
- **Core:** ^10 || ^11
- **Depends on:** symfony_mailer
- **Configure:** `/admin/config/system/mailer/email-footer-links` (`administer mail footer links`)
- **Template var:** `footer_links` (per-language).
- **Adjuster plugins:** Email Template Suggestion Adjuster; Legacy Body Format Email Adjuster (add to a mailer policy).

**Security:** single admin config route, permission-gated (`administer mail footer links`); no anonymous or mutating public endpoints.

See [configure/settings.md](configure/settings.md)
