<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Library Extend — agent index

API module that adds extra source "panes" (tabs) to core's Media Library. Defines the
`media_library_source` plugin type and a `media_library_pane` config entity, and decorates
`media_library.ui_builder` to render panes. Depends on core `media_library`. No permissions
of its own (pane admin uses core `administer site configuration`); no Drush. Ships two
example image source plugins (`lorem_picsum`, `configurable_lorem_picsum`).

- **Write a `MediaLibrarySource` plugin: annotation, `MediaLibrarySourceBase`, the methods
  (`getResults`/`getEntityId`/`buildForm`/`getCount`), source_types, plugin config form** →
  [plugins/source.md](plugins/source.md)
- **The `media_library_pane` config entity, the Panes admin UI, per-plugin config schema** →
  [configure/panes.md](configure/panes.md)
- **The `media_library_source_info` alter hook** → [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Manager: `plugin.manager.media_library_source`; plugins live in
  `Plugin/MediaLibrarySource/`, annotation `@MediaLibrarySource` (id, label, `source_types`).
- A pane is applicable to a field when a plugin's `source_types` intersects the media source
  plugin ids of the field's allowed media bundles (`getApplicablePlugins()`).
- Selection ids are `mle:<pane_id>:<item_id>`; `hook_form_alter` on
  `views_form_media_library_widget*` converts them to real media ids via `getEntityId()`.
- Templates: `media_library_pane`, `media_library_pane_content`, `media_library_result_preview`.
