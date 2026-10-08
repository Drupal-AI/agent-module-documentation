<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Magnify Image Viewer (magnify) — agent index

**An image-field formatter that adds a hover magnifier (loupe zoom) with configurable loupe size and zoom level.**

- **Version:** 1.0.x
- **Core:** ^8.9 || ^9 || ^10 || ^11
- **Depends on:** `image`, `jquery_ui`
- **Formatter:** `magnify_field_formatter` (`MagnifyFieldFormatter` extends `ImageFormatterBase`) — settings: `image_style`, `size` (90–300), `zoom` (levels 1–5)
- **Theme/library:** `magnify` theme hook + `templates/magnify.html.twig`; attaches `magnify/magnify`
- **Routes / permissions / services / config entities:** none

**Security:** Display formatter only — no routes, permissions, services, or writable config. **Supply-chain note:** `magnify.libraries.yml` loads JS from a third-party CDN (`cdn.jsdelivr.net/gh/ninjadrupal/magnifyjs@1.0.0`) — pinned to `@1.0.0` (safer than an unpinned ref, but still external; vendor for production). Twig outputs autoescaped Drupal-generated image URIs. No anonymous or mutating endpoints.

See [configure/formatter.md](configure/formatter.md)
