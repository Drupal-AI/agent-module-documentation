<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Responsive Image Link Formatter — agent index

Submodule of **Image Link Formatter**. Adds an image field formatter
**`responsive_image_link_formatter`** ("Responsive image wrapped within link field") that renders a
responsive image (core `<picture>`/srcset) wrapped in a link from a **Link field** on the same
entity, paired by delta. Extends core `ResponsiveImageFormatter` + the parent's
`ImageLinkFormatterTrait`. No admin page (`configure: null`), no permission, no Drush, no config
schema. Requires **image_link_formatter** + **responsive_image**, and a configured **responsive
image style** to select.

- **Use the formatter, its settings, requirements, config location** →
  [configure/formatter.md](configure/formatter.md)

Key facts:
- Formatter id `responsive_image_link_formatter`, for `image` fields.
- Settings: core responsive-image settings (`responsive_image_style`, `image_link`); the link field
  is chosen in **"Link image to"** (`settings.image_link` = the link field machine name).
- Stored on `core.entity_view_display.<entity>.<bundle>.<mode>` →
  `content.<image_field>.type: responsive_image_link_formatter` + `settings.image_link`.
- Same delta-pairing and Link Attributes/Target behaviour as the parent; see the parent module's
  `extend/subclass.md` for extending the plugin (it uses the same trait).
