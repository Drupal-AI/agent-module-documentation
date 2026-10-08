<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Magnific Popup — agent index

A lightbox **field formatter**, not a settings page. Pick it on an entity's *Manage display*;
settings are stored per-component in `core.entity_view_display.<entity>.<bundle>.<mode>`.
No configure route, no plugins-of-its-own, no Drush, no permissions.

- **Formatter ids, settings keys, and configuring a field's display (UI + drush)** →
  [configure/formatter.md](configure/formatter.md)
- **Runtime rendering, the JS library, local vs legacy path, CSS hooks** →
  [api/library.md](api/library.md)

Key facts: `magnific_popup` formatter targets `image` fields;
`video_embed_field_magnific_popup` targets `video_embed_field` fields (needs the Video Embed
Field module). Settings: `thumbnail_image_style`, `popup_image_style`,
`gallery_type` (`all_items`|`first_item`|`separate_items`), `vertical_fit`. The library must
live at `web/libraries/magnific-popup`.
