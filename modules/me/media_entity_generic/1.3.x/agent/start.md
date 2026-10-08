<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Entity Generic — agent index

Provides **one** core-Media source plugin: **`generic`** ("Generic media"). Stores an arbitrary
`string` value as the source field; no metadata attributes; generic thumbnail. No settings form,
**no configure route**, no permissions, no Drush, no services. Originally an upgrade bridge from
contrib **Media Entity** 1.x's "Generic" provider to Media in core.

- **Create/inspect a media type that uses the Generic source (UI + API, source field wiring)** →
  [configure/generic-source.md](configure/generic-source.md)

Key facts:
- Plugin: `Drupal\media_entity_generic\Plugin\media\Source\Generic` extends `MediaSourceBase`,
  `@MediaSource(id = "generic", allowed_field_types = {"string"}, default_thumbnail_filename = "generic.png")`.
- A media type's source is stored on the `media_type` config entity as `source: generic` with
  `source_configuration.source_field: <field_name>`.
- `hook_requirements()` blocks install while contrib `media_entity` < 8.x-2 is enabled.
