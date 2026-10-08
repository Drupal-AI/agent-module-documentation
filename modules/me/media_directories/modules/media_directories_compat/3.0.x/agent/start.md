<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Directories Compatibility — agent index

One text filter that converts legacy `entity_embed`-style `<drupal-entity>` media embeds into
core `<drupal-media>` at render time. No settings page, no permissions, no services, no
config object — only a per-format filter setting.

- **Enable it, order it, configure `inline_display_modes`, and the exact conversion rules** →
  [plugins/legacy-embed-filter.md](plugins/legacy-embed-filter.md)

Key facts:
- Filter plugin id **`media_directories_legacy_embed`**, title *"Legacy entity embed
  compatibility"*, `TYPE_TRANSFORM_REVERSIBLE`, **weight 80**.
- Must run **before** core's `media_embed` ("Embed media") filter — it *produces*
  `<drupal-media>` tags.
- Only setting: **`inline_display_modes`** (sequence of view-mode ids). Schema
  `filter_settings.media_directories_legacy_embed`. Matching embeds become `<a href>`
  download links instead of media renders.
- Consumed (dropped) attributes: `data-entity-embed-display`,
  `data-entity-embed-display-settings`, `data-embed-button`
  (`LegacyEntityEmbed::CONSUMED_ATTRIBUTES`). Everything else is copied over.
- Only `<drupal-entity data-entity-type="media" data-entity-uuid="…">` is matched; other
  entity types are ignored.
