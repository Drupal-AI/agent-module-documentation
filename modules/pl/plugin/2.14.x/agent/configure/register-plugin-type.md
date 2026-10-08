# Register your plugin manager as a discoverable plugin type

Add a `MODULE.plugin_type.yml` in your module root. Top-level keys are plugin type ids; values
are definitions consumed by `Drupal\plugin\PluginType\PluginType` (unless you supply a custom
`class`).

```yaml
# my_module.plugin_type.yml
my_thing:
  label: My thing
  description: Does a thing.                 # optional
  plugin_manager_service_id: plugin.manager.my_module.my_thing   # required
  plugin_definition_decorator_class: \Drupal\plugin\PluginDefinition\ArrayPluginDefinitionDecorator
  # field_type: false            # optional; set false to NOT derive a plugin:<id> field type
  # operations_provider_class: \Drupal\...   # optional
  # plugin_configuration_schema_id: my_module.[plugin_id]   # optional
```

## Definition keys (default `PluginType` class)

| Key | Required | Meaning |
|---|---|---|
| `label` | yes | human-readable label. |
| `plugin_manager_service_id` | yes | service id of the plugin type's manager. |
| `description` | no | human description. |
| `class` | no | FQN of a `PluginTypeInterface`; empty → default `PluginType`. |
| `plugin_definition_decorator_class` | no | FQN of a `PluginDefinitionDecoratorInterface` when the manager's definitions are plain arrays. |
| `operations_provider_class` | no | `PluginTypeOperationsProviderInterface`; defaults to `DefaultPluginTypeOperationsProvider`. |
| `field_type` | no | boolean; defaults TRUE (a `plugin:<id>` field type is derived). Set FALSE to opt out. |
| `plugin_configuration_schema_id` | no | config schema id; supports `[plugin_type_id]` and `[plugin_id]` tokens; defaults to `plugin.plugin_configuration.[plugin_type_id].[plugin_id]`. |

## Config schema for configurable plugins

Provide a schema named `plugin.plugin_configuration.<plugin_type_id>.<plugin_id>` (or `*` for
all plugins of the type). A catch-all `plugin.plugin_configuration.*: {type: ignore}` exists as
fallback.

## Verify

After adding the file and clearing caches, the type appears at `/admin/structure/plugin` and:

```php
\Drupal::service('plugin.plugin_type_manager')->hasPluginType('my_thing'); // TRUE
```
