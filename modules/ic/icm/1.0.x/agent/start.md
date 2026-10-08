<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Compare Viewer (icm) — agent index

**A field formatter that renders 2+ image-field images as an interactive before/after comparison slider.**

- **Version:** 1.0.x
- **Core:** ^8.9 || ^9 || ^10 || ^11
- **Depends on:** `image`, `jquery_ui`
- **Formatter:** `icm_field_formatter` (`IcmFieldFormatter` extends `ImageFormatterBase`) — settings: `image_style`, `effects` (horizontal/vertical/45deg), `icm_link_image_to` (nothing/content/file)
- **Theme/library:** `icm` theme hook + `templates/icm.html.twig`; attaches `icm/icm`
- **Routes / permissions / services / config entities:** none

**Security:** Display formatter only — no routes, permissions, services, or writable config. **Supply-chain caveat:** `icm.libraries.yml` loads JS/CSS from an *unpinned* third-party CDN (`cdn.jsdelivr.net/gh/ninjadrupal/icm/...` = repo default branch), an integrity/availability risk; vendor or pin for production. Twig outputs Drupal-generated image URIs/node paths (autoescaped), not raw user input. No anonymous or mutating endpoints.

See [configure/formatter.md](configure/formatter.md)
