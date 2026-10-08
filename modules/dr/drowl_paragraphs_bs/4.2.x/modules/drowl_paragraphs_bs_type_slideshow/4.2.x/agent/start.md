<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Paragraphs for Bootstrap Type: Slideshow (Media) (drowl_paragraphs_bs_type_slideshow) — agent index

Sub-module of **drowl_paragraphs_bs**. Installs the `slideshow` Paragraph type.

- **Field**: `field_slideshow_ref` (entity reference → `media`, target bundle `slideshow`, required).
  Shared `field_settings` (hidden).
- Displayed with core **`entity_reference_entity_view`** (`view_mode: default`) — the referenced DROWL
  Media slideshow entity renders itself; media access applies.
- Depends on core `media`, `media_library`, and **`drowl_media:drowl_media_types`** (provides the
  `slideshow` media type). No routes/permissions/services/schema, no template or `.module`.

See [paragraphs/slideshow.md](paragraphs/slideshow.md).
