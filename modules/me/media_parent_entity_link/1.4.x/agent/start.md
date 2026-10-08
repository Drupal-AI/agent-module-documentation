<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media - Parent Entity Link — agent index

Adds a **"Link to parent entity"** checkbox to the **image** field formatters on **media**
entities. When a media item is rendered inside a referencing entity and the box is ticked, its
image `#url` is set to the parent (referencing) entity's URL — overriding the formatter's own
link setting. No config page (`configure: null`), no permissions, no Drush, no plugins. State
is a third-party setting on the media bundle's `entity_view_display`.

- **Enable it on a media image formatter / where the setting is stored / constraints** →
  [configure/link-to-parent.md](configure/link-to-parent.md)
- **How it works (render hook, parent lookup, Layout Builder, cache context) + the alter hook** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Setting path: `core.entity_view_display.media.<bundle>.<view_mode>` →
  `content.<image_field>.third_party_settings.media_parent_entity_link.link_to_parent` (string `"1"`).
- The checkbox only appears for a **media** entity's field of type `image` whose formatter is in
  the supported list — default `['image', 'responsive_image']` (`InitialSettingsService::getFormatters()`).
- Extend the supported formatters with `hook_media_parent_entity_link_alter_formatters(&$formatters)`
  (e.g. add `'blazy'`).
- No effect when the media has no parent, or the parent is new / has no URL.
