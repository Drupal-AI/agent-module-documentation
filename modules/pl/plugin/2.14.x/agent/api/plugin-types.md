# Plugin type registry & manager API

## Service: `plugin.plugin_type_manager`

`Drupal\plugin\PluginType\PluginTypeManagerInterface` (impl `PluginTypeManager`,
args `@service_container`, `@module_handler`).

```php
$ptm = \Drupal::service('plugin.plugin_type_manager');
$ptm->getPluginTypes();          // PluginTypeInterface[] keyed by id
$ptm->hasPluginType('block');    // bool
$type = $ptm->getPluginType('block');
```

### PluginTypeInterface

| Method | Returns |
|---|---|
| `getId()` | plugin type id (e.g. `block`, `condition`, `views_style`). |
| `getLabel()` / `getDescription()` | human strings. |
| `getProvider()` | machine name of the module that provides the type (`core`, `views`, ...). |
| `getPluginManagerServiceName()` | the service id of the plugin manager. |
| `getPluginManager()` | the actual `PluginManagerInterface` — call `getDefinitions()` etc. on it. |
| `ensureTypedPluginDefinition($def)` | wrap a raw array/definition into a typed `PluginDefinitionInterface`. |
| `getOperationsProvider()` | provider for admin operation links. |
| `isFieldType()` | whether a `plugin:<id>` field type is derived for it. |

## Registered types (shipped)

`plugin.plugin_type.yml` (in the module) registers the module's own `plugin_selector` plus a
large set of core/contrib types: `entity_reference_selector`, `field_type`, `field_widget`,
`field_formatter`, `archiver`, `action`, `menu_link`/`menu_local_action`/`menu_local_task`,
`display_variant`, `queue_worker`, `mail`, `condition`, `element`, aggregator/block/ckeditor/
editor/filter/image_effect/language/migrate/rest/search/tour types, and every Views plugin type
(`views_style`, `views_field`, `views_filter`, `views_argument`, ...). Each entry names a
`plugin_manager_service_id` and a `plugin_definition_decorator_class`.

## Admin UI & routes

- `plugin.plugin_type.list` — `/admin/structure/plugin` — lists all plugin types (the `configure` route).
- `plugin.plugin_type.detail` — `/admin/structure/plugin/{plugin_type}/detail`.
- `plugin.plugin.list` — `/admin/structure/plugin/{plugin_type}` — plugins of one type.
- `plugin.plugin.detail` — `/admin/structure/plugin/{plugin_type}/plugin/{plugin_id}`.

All require the `plugin.overview.view` permission.

## ParamConverters (for your own routes)

Tagged converters resolve route params:
- `plugin.paramconverter.plugin_type` — `{plugin_type}` with option `plugin.plugin_type: {}` → a `PluginTypeInterface`.
- `plugin.paramconverter.plugin_definition` — a typed plugin definition.
- `plugin.paramconverter.plugin_instance` — an instantiated plugin.

## Typed plugin definitions

`src/PluginDefinition/` provides `PluginDefinitionInterface` plus decorators
(`ArrayPluginDefinitionDecorator`, `BlockPluginDefinitionDecorator`, `FilterPluginDefinitionDecorator`,
`LinkPluginDefinitionDecorator`, ...) and mix-in traits/interfaces for label, description, category,
hierarchy, context, deriver, and config-dependency metadata. Use `ensureTypedPluginDefinition()`
to normalise a manager's raw definitions into these objects.

## Default plugin resolver

`plugin.default_plugin_resolver` (`EventBasedDefaultPluginResolver`) dispatches
`ResolveDefaultPlugin` (see `Drupal\plugin\Event\PluginEvents`) so subscribers can pick a
type's default plugin.
