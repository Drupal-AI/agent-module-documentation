<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PDF Embed View — agent index

**Embed/display PDFs inline, in a modal, or a new tab**. Version **1.1.x** (1.1.1). Core `^9.3 || ^10 || 11`.

Three display plugins over one theme hook + one `display_mode` setting. Depends on core `field`, `media`. No config UI (`configure: null`), no permissions, no Drush, no config schema, no external libs (no pdf.js — native browser iframe).

- **Assign a display plugin** (file field formatter, media reference formatter, or Views field) and pick a display mode → [configure/formatters.md](configure/formatters.md)
- **Override the embed markup / theme hook** (`pdf_embed_view`, template, attached library) → [theming/template.md](theming/template.md)
