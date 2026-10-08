<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media entity slideshow — agent index

Provides a core Media **source plugin** `slideshow`: a media type whose slides are an ordered
`entity_reference` field (usually referencing other media). Requires `media`. No settings form, no
`configure` route, no permissions, no Drush. Config schema: `media.source.slideshow`
(extends `media.source.field_aware`).

- **The `slideshow` source plugin: metadata attributes, thumbnail, ItemsCount constraint** →
  [plugins/media-source.md](plugins/media-source.md)
- **Create a slideshow media type + its entity_reference source field (UI and config/drush)** →
  [configure/media-type.md](configure/media-type.md)

Key facts: source plugin id `slideshow`, `allowed_field_types = {entity_reference}`; metadata
attribute `length` = slide count; default name = "N slides, created on <date>"; thumbnail = first
slide's thumbnail; constraint `ItemsCount` requires ≥1 slide. The module supplies the media model —
render the carousel markup with your own theme/formatter.
