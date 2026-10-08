<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DROWL Paragraphs for Bootstrap Type: Simple Map (drowl_paragraphs_bs_type_simple_map) — agent index

Sub-module of **drowl_paragraphs_bs**. Installs the `simple_map` Paragraph type — a **static image
map** (no maps API, no external requests).

- **Fields**: `field_image` (media image reference), `field_link`, `field_text`, `field_resp_imagestyle`,
  shared `field_settings`. (`field_image_zoomable`/`field_image_shape` are referenced by the template.)
- **Template** `paragraph--drowl-paragraphs-bs--simple-map.html.twig`: includes the base
  `inc/flexible_image.html.twig` for the image (responsive image style, PhotoSwipe zoom), shows the
  media's `field_image_caption` via `drupal_field(...)` (rendered/escaped), then the link and remaining
  content overlay.
- `.module`: attaches the `drowl_paragraphs_bs_type_simple_map/global` CSS library; registers the template.
- **No** maps API key, no getenv/Key/env config, no JS SDK, no server-side URL fetch. Libraries file ships
  CSS only.
- No routes/permissions/services/schema of its own.

See [paragraphs/simple-map.md](paragraphs/simple-map.md).
