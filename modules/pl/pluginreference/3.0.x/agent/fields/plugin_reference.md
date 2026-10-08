# Field type: `plugin_reference`

An entity-reference-style field that stores a **plugin ID** (a string, not an entity) plus
optional plugin configuration. Class `PluginReferenceItem`
(`src/Plugin/Field/FieldType/PluginReferenceItem.php`).

## Attribute / defaults

```
#[FieldType(
  id: 'plugin_reference',
  category: 'plugin_reference',
  default_widget: 'plugin_reference_select',
  default_formatter: 'plugin_reference_id',
  list_class: PluginReferenceFieldItemList,
)]
```

- Columns / properties: `plugin_id` (varchar 255, indexed, required, main property) and
  `configuration` (map; DB column is a serialized `big` blob).
- Storage setting: `target_type` (default `''`) — the plugin type ID whose manager is
  `plugin.manager.<target_type>`.
- Field settings: `handler` (default `default`) and `handler_settings` (array) — the
  selection handler and its config, resolved through the `PluginReferenceSelection` manager.

## Configure a field

### 1. Storage: choose the plugin type (`target_type`)
`storageSettingsForm()` renders a required select of plugin-type options from
`PluginTypeHelper::getPluginTypeOptions()` (all `plugin.manager.*` services, grouped by
provider). Disabled once the field has data. `PluginReferenceItem` also implements
`getPreconfiguredOptions()`, so each discoverable plugin type appears as its own
"Plugin reference: <Type>" entry in the Field UI "Add field" list; the raw
`plugin_reference` entry is relabelled "Other…" by
`pluginreference_form_field_ui_field_storage_add_form_alter()`.

### 2. Field: choose the selection handler (`handler` + `handler_settings`)
`fieldSettingsForm()` lists the selection groups that support this `target_type`
(`PluginReferenceSelectionManager::getSelectionGroups()`), then embeds the chosen handler's
`buildConfigurationForm()` (e.g. `default` exposes sort key/direction; `filtered` exposes
include/exclude filters). Validation is delegated to the handler's
`validateConfigurationForm()`.

### Set via PHP

```php
// Storage setting: reference block plugins.
FieldStorageConfig::create([
  'field_name'  => 'field_block',
  'entity_type' => 'node',
  'type'        => 'plugin_reference',
  'settings'    => ['target_type' => 'block'],
])->save();

// Field instance: default handler, sorted by label.
FieldConfig::create([
  'field_name'  => 'field_block',
  'entity_type' => 'node',
  'bundle'      => 'page',
  'settings'    => [
    'handler'          => 'default:block',
    'handler_settings' => ['sort' => ['key' => 'label', 'direction' => 'ASC']],
  ],
])->save();

// Set a value: plugin id + (optional) plugin configuration.
$node->field_block->setValue(['plugin_id' => 'system_powered_by_block', 'configuration' => []]);
// setValue() also accepts a plugin instance or a bare plugin-id string.
```

## Widgets

| Widget ID | Label | Settings (config-schema keys) |
|---|---|---|
| `plugin_reference_select` (default) | Select list | `provider_grouping` (bool), `configuration_form` (`full`/`hidden`) |
| `plugin_reference_autocomplete` | Autocomplete | `match_operator` (`STARTS_WITH`/`CONTAINS`), `match_limit` (int), `configuration_form` |
| `plugin_reference_options_buttons` | Check boxes / radio buttons | `configuration_form` |

When `configuration_form` is `full` and the referenced plugin implements
`PluginFormInterface`, the widget embeds that plugin's own configuration form (AJAX-rebuilt
when the selected plugin changes) and stores the result in the item's `configuration`
column. `hidden` skips it. Option labels are sanitised with `FieldFilteredMarkup`; the
autocomplete widget is backed by the `plugin_autocomplete` form element (see
[../api/services.md](../api/services.md)).

## Formatters

| Formatter ID | Label | Output |
|---|---|---|
| `plugin_reference_id` (default) | Plugin ID | the stored `plugin_id` string |
| `plugin_reference_label` | Label | the plugin definition's `label` (or `$plugin->label()` when the class defines one) |

Both skip items whose `plugin_id` is not in the target manager's definitions, honour a
plugin `access()` method when present, and add the plugin as a cacheable dependency when it
exposes `getCacheContexts()` (via `PluginTypeHelper::hasPluginAccessControl()` /
`isPluginCacheable()`).

## Validation

The item list adds the `ValidPluginReference` constraint
(`ValidPluginReferenceConstraintValidator`): each `plugin_id` must be returned by the
selection handler's `validateReferenceablePlugins()`. Non-referenceable vs non-existent
plugins get distinct messages; a previously-referenced plugin the current user cannot access
is skipped. The item removes the core `AllowedValuesConstraint` in favour of this one.
`isEmpty()` treats a value as empty when the plugin ID is missing or its definition no longer
exists (the "soft" reference — a removed module leaves a dangling ID that renders as empty).

## Config schema (`config/schema/pluginreference.schema.yml`)

- `field.storage_settings.plugin_reference`: `target_type`.
- `field.field_settings.plugin_reference`: `handler`, `handler_settings`
  (typed dynamically as `plugin_reference_selection.[%parent.handler]`).
- `field.value.plugin_reference`: `plugin_id`, `configuration`.
- `field.widget.settings.plugin_reference_autocomplete` / `_select` / `_options_buttons`
  as in the widgets table above.
- Selection-handler settings: base `plugin_reference_selection` (`target_type`),
  `plugin_reference_selection.default` (`sort.key`, `sort.direction`),
  `plugin_reference_selection.filtered` (`filter.key`, `filter.negate`,
  `filter.target_values`).

## Dependencies & updates

`calculateDependencies()`/`calculateStorageDependencies()` add module dependencies on the
plugin-type provider, on modules providing default-value plugins, and on the selection
handler's provider; `onDependencyRemoval()` drops removed default values and falls back to
`default:<target_type>` when the handler's module is uninstalled. Install/update hooks
`pluginreference_update_9001..9003` migrate the `_value` column to `plugin_id`, add its index,
and add the `configuration` blob column; post-update functions backfill widget/field settings.
