<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin Reference (pluginreference) — agent index

Provides a `plugin_reference` field type: an entity-reference-style field that stores a
**plugin ID** (plus optional plugin configuration) instead of an entity ID. A field's
storage setting `target_type` names a plugin type (e.g. `block`) whose manager service is
`plugin.manager.<target_type>`; the field's `handler`/`handler_settings` pick a selection
handler that narrows which plugin IDs are referenceable — exactly mirroring core Entity
Reference. Depends only on core `field`. Core `^10.3 || ^11`.

No module settings page (fields are configured per-field via Field UI). Defines one
permission, one plugin type, config schema; no drush commands.

- **Add/configure the field, its widgets and formatters** → [fields/plugin_reference.md](fields/plugin_reference.md)
- **Restrict which plugins a field can target (selection handlers) or write your own** → [plugins/selection_handlers.md](plugins/selection_handlers.md)
- **Read the stored plugin in code, discover plugin types** → [api/services.md](api/services.md)
- **Autocomplete-endpoint permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Field type: `plugin_reference` (class `PluginReferenceItem`); columns `plugin_id`
  (varchar 255, indexed) + `configuration` (serialized big blob); main property `plugin_id`.
- Storage setting: `target_type` (the plugin type ID). Field settings: `handler`,
  `handler_settings`.
- Widgets: `plugin_reference_select` (default), `plugin_reference_autocomplete`,
  `plugin_reference_options_buttons`.
- Formatters: `plugin_reference_id` (default), `plugin_reference_label`.
- Plugin type: `PluginReferenceSelection` — manager service
  `plugin.manager.plugin_reference_selection` (class `PluginReferenceSelectionManager`),
  namespace `Plugin/PluginReferenceSelection`, attribute
  `Drupal\pluginreference\Attribute\PluginReferenceSelection`, alter hook
  `plugin_reference_selection`, fallback plugin `broken`. Built-in handlers: `default`
  (+ `default:<type>` derivatives), `filtered`, `default:block`, `filtered:block`.
- Helper service: `plugin_reference.plugin_type_helper` (class `PluginTypeHelper`) —
  discovers plugin managers by scanning service IDs prefixed `plugin.manager.`.
- Validation constraint: `ValidPluginReference`. Form element: `plugin_autocomplete`.
- Autocomplete route: `pluginreference.plugin_autocomplete` at
  `/pluginreference/autocomplete/{target_type}/{selection_handler}/{selection_settings_key}`,
  permission `pluginreference autocomplete view results`.
