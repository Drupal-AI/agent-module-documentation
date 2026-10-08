<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Oomph Paragraph Bundles (oomph_paragraphs) — agent index

**Pre-configured component-style Paragraph bundles (Row, Hero, Accordion, Image, Video, WYSIWYG, Column group) for page building.**

- **Version:** 8.x-1.x (8.x-1.0-alpha12)
- **Core:** `^10 || ^11`  •  **Depends:** paragraphs, field_group, image, options, text
- **Service:** `oomph_paragraphs.paragraph_bundle_discovery` — scans `templates/` to register `paragraph__<bundle>` theme hooks.
- **Provides:** bundle config (fields + form/view displays) in `config/install`, and per-bundle Twig templates.
- **Surface:** no routes, permissions or runtime config UI — content model + theming only.

**Security:** No routes, permissions, controllers or mutating endpoints — the module only imports paragraph-bundle configuration and registers theme hooks. No attack surface.
