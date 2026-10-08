<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Colorbox Media Video — agent index

One field formatter, `colorbox_media_remote_video`, that turns a core **Remote Video**
(oEmbed) field into a thumbnail/text launcher opening the clip in a **Colorbox** modal, with
gallery grouping and captions. No settings page, no configure route (`configure: null`), no
permissions, no Drush, no plugin types. Depends on core `media` + contrib `colorbox`.

- **Enable & configure the formatter on a view display, all settings keys** →
  [configure/formatter.md](configure/formatter.md)
- **Theme hook, template, preprocess variables and the `data-colorbox-*` attributes** →
  [theming/template.md](theming/template.md)

Key facts: formatter id `colorbox_media_remote_video` (field types `link`, `string`,
`string_long`); config lives at `core.entity_view_display.<entity>.<bundle>.<mode>` →
`content.<field>.type = colorbox_media_remote_video` with settings `display`
(thumbnail|text|media_title), `link_text`, `image_style`, `colorbox_gallery`
(post|page|field_post|field_page|custom|none), `colorbox_gallery_custom`, `colorbox_caption`
(auto|title|alt|entity_title|custom|none), `colorbox_caption_custom` (schema
`field.formatter.settings.colorbox_media_remote_video`, which extends the oembed formatter
schema). Token replacement in the custom fields needs the `token` module.
