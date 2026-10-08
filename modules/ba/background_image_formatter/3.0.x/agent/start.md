<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Background Image Formatter — agent index

Two **field formatters** that render an image as a CSS `background-image` instead of an
`<img>`. Configured entirely on a field's **Manage display** — **no configure route**
(`configure: null`), no settings form, no permissions, no Drush. Depends on core `image`.

- **The two formatters, their settings, and how to select them / read the config** →
  [configure/formatter.md](configure/formatter.md)
- **The `background_image_formatter_inline` theme hook and its suggestions** →
  [theming/template.md](theming/template.md)

Key facts:

- `background_image_formatter` — for **image** fields (extends core `ImageFormatter`).
- `background_media_image_formatter` — for **entity_reference → media** fields (reads the
  media `thumbnail`; extends `EntityReferenceEntityFormatter`).
- Shared settings: `image_style`, `background_image_output_type` (`inline`|`css`),
  `background_image_selector`, `background_image_link` (bool), `background_image_link_custom`
  (tokens supported when Token is enabled).
- Config lives in `core.entity_view_display.<entity>.<bundle>.<mode>` →
  `content.<field>.type` + `content.<field>.settings`.
