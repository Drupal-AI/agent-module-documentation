# API: reading the reference & discovering plugin types

## Read the referenced plugin(s) in code

`PluginReferenceItem::referencedPlugin(): ?PluginBase`
(`src/Plugin/Field/FieldType/PluginReferenceItem.php`) — instantiates the stored plugin via
the target manager's `createInstance($plugin_id, $configuration)`, or returns `NULL` when the
item is empty (empty ID, missing manager, or the ID is no longer a defined plugin). It always
checks the ID against the target manager's definitions before instantiating.

`PluginReferenceFieldItemList::referencedPlugins(): PluginBase[]` — all instantiated plugins
keyed by field delta (skips deltas whose plugin no longer exists).

```php
foreach ($node->field_block->referencedPlugins() as $delta => $plugin) {
  // $plugin is a fully-instantiated plugin (with its stored configuration).
}
// Or a single item:
$plugin = $node->field_block->first()?->referencedPlugin();
```

## `PluginTypeHelper` — `plugin_reference.plugin_type_helper`

Class `PluginTypeHelper` implements `PluginTypeHelperInterface`
(args: `@service_container`, `@extension.list.module`). Discovers plugin *types* by scanning
every service ID that begins with `plugin.manager.`.

| Method | Returns |
|---|---|
| `getPluginTypeIds()` | All plugin type IDs (service ID minus the `plugin.manager.` prefix). |
| `pluginTypeExists($id)` | Whether that plugin type exists. |
| `getPluginManager($id)` | The `PluginManagerInterface` service, or `NULL` (verifies the service exists and is a manager). |
| `getPluginDefinitions($id)` | All definitions of a plugin type. |
| `getPluginTypeOptions()` | Options for a select, grouped by provider name. |
| `getPluginTypeProvider($id)` / `getPluginTypeProviderName($id)` | Providing module (system name / human name). |
| `getPluginLabel($def)` | `label` ?? `admin_label` ?? `id`. |
| `hasPluginAccessControl($def)` / `isPluginCacheable($def)` / `isPluginConfigurable($def)` | Whether the plugin class defines `access()` / `getCacheContexts()` / `buildConfigurationForm()`. |

## Selection manager — `plugin.manager.plugin_reference_selection`

`PluginReferenceSelectionManagerInterface` (see
[../plugins/selection_handlers.md](../plugins/selection_handlers.md)):
`getSelectionHandler(FieldDefinitionInterface $field, ?EntityInterface $entity = NULL)`,
`getSelectionGroups($target_type)`, `getInstance(array $options)` (requires a `target_type`
key), `getPluginId($target_type, $base_plugin_id)`.

## Autocomplete route & form element

- Route `pluginreference.plugin_autocomplete` →
  `/pluginreference/autocomplete/{target_type}/{selection_handler}/{selection_settings_key}`,
  controller `PluginReferenceAutocompleteController::handleAutocomplete`, gated by the
  `pluginreference autocomplete view results` permission. Selection settings are stored in the
  `plugin_autocomplete` key/value bin and passed as an HMAC key
  (`Crypt::hmacBase64(..., Settings::getHashSalt())`, verified with `hash_equals`); the `q`
  query string is matched against the handler's referenceable labels/IDs and returned as JSON.
- Form element `plugin_autocomplete` (`src/Element/PluginAutocomplete.php`, extends
  `Textfield`) — properties `#target_type`, `#selection_handler`, `#selection_settings`,
  `#validate_reference`. Used by the `plugin_reference_autocomplete` widget; `#default_value`
  accepts a plugin ID string, a plugin instance, or a definition array.

## Hooks this module implements

- `hook_help` — help text on `help.page.pluginreference`.
- `hook_form_field_ui_field_storage_add_form_alter` — relabels the raw `plugin_reference`
  storage-type option to "Other…" (per-type entries come from the field type's
  `getPreconfiguredOptions()`).
