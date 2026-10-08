<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Library panes (config entity)

A **pane** binds one `MediaLibrarySource` plugin to one media bundle and, optionally, stores
per-plugin configuration. Each pane becomes an extra tab in the Media Library when its media
bundle is allowed for the field being edited.

## Admin UI
- Route/collection: `entity.media_library_pane.collection` (this is the module's `configure`
  target) at **Configuration » Media » Media library » Panes**
  (`/admin/config/media/media-library/pane`).
- Add / edit / delete forms hang off that path; access is core's
  `administer site configuration` (the config entity's `admin_permission`).
- On the add/edit form you pick a **media bundle**, then a **source plugin** available for
  that bundle, then fill the plugin's configuration form.

## Config entity: `media_library_pane` (`MediaLibraryPane`)
`config_prefix: pane`; exported keys:

| Key | Meaning |
|---|---|
| `id`, `label`, `uuid` | identity |
| `bundle` | target media bundle id |
| `source_plugin` | the `MediaLibrarySource` plugin id |
| `source_plugin_configuration` | array of plugin config (shape depends on the plugin) |

Runtime accessors: `getTargetBundle()`, `getSourcePluginId()`,
`getSourcePluginConfiguration()`, `getPlugin()` (instantiates the plugin with its config and
sets the target bundle), `getSummary()` (delegates to the plugin).

## Config schema (`config/schema/pane.schema.yml`)
- `media_library_extend.pane.*` — the config entity; `source_plugin_configuration` uses a
  dynamic type `media_library_extend.source_plugin.[%parent.source_plugin]`.
- `media_library_extend.source_plugin.*` — empty base mapping; **every source plugin must
  add its own** `media_library_extend.source_plugin.<plugin_id>` mapping. Shipped examples:
  - `media_library_extend.source_plugin.lorem_picsum` → `items_per_page` (integer).
  - `media_library_extend.source_plugin.configurable_lorem_picsum` → `items_per_page`
    (integer), `grayscale` (boolean).

## How a pane reaches the widget
Core's `media_library.ui_builder` is decorated by `MediaLibraryExtendUiBuilder`, which adds a
tab per applicable pane. Applicability is computed in
`MediaLibrarySourceManager::getApplicablePlugins($allowed_types)`: a plugin's `source_types`
must intersect the media **source plugin ids** of the field's allowed media bundles.
