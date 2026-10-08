<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# inky_integration (inky_integration) — agent index
**Registers Twig Inky + CSS-inliner extensions for building responsive HTML emails.**

- **Version:** 1.0.1 → dir `1.0.x`
- **Core:** ^10 || ^11
- **Services:** `inky_integration.twig_extension` (`Twig\Extra\Inky\InkyExtension`), `inky_integration.cssinliner_extension` (`Twig\Extra\CssInliner\CssInlinerExtension`)
- **Ships:** `css/foundation-for-emails.css`, `templates/email-wrap.html.twig`; `.module` makes `email_wrap` available in the admin theme
- **Requires:** PHP `ext-xsl`; Composer `twig/inky-extra`, `twig/cssinliner-extra`, `twig/extra-bundle`

**Security:** pure Twig/templating helper — no routes, permissions, or endpoints, and (despite the README wording) **no external network/service calls**; nothing to TLS-verify or SSRF.
