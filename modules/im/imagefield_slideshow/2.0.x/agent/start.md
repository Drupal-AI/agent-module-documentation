<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Imagefield Slideshow — agent index

One field formatter, `imagefield_slideshow_field_formatter`, for multi-value **image**
fields. Renders images as a jQuery Cycle2 slideshow. No settings form, no configure route,
no permissions, no Drush, no plugins of a new type. All state is the formatter's `settings`
in an `entity_view_display` config entity.

- **Enable the formatter on a display, every setting key + allowed values, drush/config recipes** →
  [configure/formatter.md](configure/formatter.md)

Key facts:
- Formatter id: `imagefield_slideshow_field_formatter` (field type: `image`).
- Stored at `core.entity_view_display.<entity>.<bundle>.<mode>` →
  `content.<field>.{type, settings}`.
- Slideshow controls (prev/next, pagers) only activate when the field has **> 1** image.
- Effects: `none`, `fade`, `fadeout`, `scrollHorz`, `flipHorz`, `flipVert`, `shuffle`.
