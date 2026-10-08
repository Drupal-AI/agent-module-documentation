<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate-views handler plugins (the extension point)

The module's power is a family of plugin types that transform each part of a legacy view's
`display_options` into valid D10/11 Views config. This doc replaces reading the ~100 plugin
classes under `src/Plugin/migrate/views/`.

## The plugin types

21 managers, each `plugin.manager.migrate.views.<type>` (in `views_migration.services.yml`),
each with an annotation `@MigrateViews<Type>` and a namespace `Plugin\migrate\views\<type>`:

`access`, `area`, `argument`, `argument_default`, `argument_validator`, `base_table`,
`cache`, `display`, `exposed_form`, `field`, `field_formatter`, `handler_table`, `filter`,
`pager`, `relationship`, `query`, `row`, `sort`, `style`, `style_summary`, `text_format`.

Two manager base classes:
- **`MigrateViewsHandlerPluginManager`** — for per-handler types (field, filter, sort,
  argument, relationship, area, field_formatter, handler_table, style_summary, text_format).
  Plugins receive a `SourceHandlerInfoProvider`.
- **`MigrateViewsPluginPluginManager`** — for per-display "plugin" types (display, style, row,
  pager, query, exposed_form, access, cache, argument_default, argument_validator).

## How a plugin is selected

For each handler/plugin in the source view the manager builds an id from the source plugin id
and the core version and loads the matching plugin, **falling back to `d7_default`** (the
default plugin every type ships, annotated `core = {7}`). Example annotation:

```php
/**
 * @MigrateViewsField(
 *   id = "d7_default",
 *   core = {7},
 * )
 */
class DefaultField extends MigrateViewsHandlerPluginBase { ... }
```

## What a plugin does

Handler plugins extend `MigrateViewsHandlerPluginBase` and implement
**`alterHandlerConfig(array &$handler_config)`**; display-level plugins extend
`MigrateViewsPluginPluginBase`. Inside they rewrite the config for the new site — e.g.
`DefaultField::alterHandlerConfig()` fixes tokenized text, remaps the `table` via the
`handler_table` plugin, converts field-formatter settings, and calls
`configurePluginId($handler_config, 'field')`. Helpers available on the base include table
remapping (`getViewsHandlerTableMigratePlugin`), token fixing (`alterTokenizedSettings`) and
plugin-id resolution (`configurePluginId`).

## Add a custom handler plugin

To control how a specific legacy handler migrates (e.g. a contrib field), add a class to your
module at `src/Plugin/migrate/views/<type>/d7/YourPlugin.php`:

```php
namespace Drupal\my_module\Plugin\migrate\views\field\d7;

use Drupal\views_migration\Plugin\migrate\views\MigrateViewsHandlerPluginBase;

/**
 * @MigrateViewsField(
 *   id = "d7_my_field_plugin",   // match the source handler's plugin id, or a table/field key
 *   core = {7},
 * )
 */
class MyFieldPlugin extends MigrateViewsHandlerPluginBase {
  public function alterHandlerConfig(array &$handler_config) {
    // mutate $handler_config into valid D10/11 Views field config
  }
}
```

Clear caches (`drush cr`) so the annotation is discovered. The manager will pick your plugin
over `d7_default` when its id matches the handler being migrated. There is **no** hook or YAML
— extension is purely these annotated plugin classes.
