# Plugin type: `plugin_selector` (plugin selectors)

The one plugin type the module **defines itself**. A plugin selector is a reusable component
that lets a user select and configure a plugin (of any plugin type) inside a form.

## Manager & discovery

- Manager service: `plugin.manager.plugin.plugin_selector`
  (`Drupal\plugin\Plugin\Plugin\PluginSelector\PluginSelectorManager`).
- Plugins live at `Drupal\<module>\Plugin\PluginSelector\<Name>` and are annotated with
  `@PluginSelector` (`Drupal\plugin\Annotation\PluginSelector`).
- Interface: `Drupal\plugin\Plugin\Plugin\PluginSelector\PluginSelectorInterface`.

```php
$manager = \Drupal::service('plugin.manager.plugin.plugin_selector');
$selector = $manager->createInstance('plugin_radios');   // or 'plugin_select_list'
```

## Shipped selectors

| Plugin id | Class | UI |
|---|---|---|
| `plugin_radios` | `Radios` (extends `AdvancedPluginSelectorBase`) | radio buttons + inline plugin config. |
| `plugin_select_list` | `SelectList` (extends `AdvancedPluginSelectorBase`) | `<select>` dropdown + plugin config. |

Bases: `PluginSelectorBase` → `AdvancedPluginSelectorBase`.

## Using a selector in a form

1. Instantiate the selector from the manager.
2. Give it the target plugin type's plugin definitions / manager and a label.
3. `buildSelectorForm()` to embed it, `validateSelectorForm()` / `submitSelectorForm()` to process,
   then `getSelectedPlugin()` to get the configured plugin instance.

(See `PluginSelectorInterface` for the exact method set — set/get selected plugin, collect
plugin configuration, required flag, etc.)

## Configuration schema

A configurable selector needs a schema of type
`plugin.plugin_configuration.plugin_selector.<plugin_id>`. Shipped base schemas
(`config/schema/plugin.schema.yml`):
`plugin.plugin_configuration.plugin_selector.plugin_selector_base` (keys
`collect_plugin_configuration`, `keep_previously_selected_plugins`, `label`, `description`,
`required`), extended by `advanced_plugin_selector_base` (`always_show_selection_elements`) and
by `plugin_radios` / `plugin_select_list`.

## Altering selectors

Implement `hook_plugin_selector_alter(array &$definitions)` to remove or re-class selector
plugins (see [hooks/hooks.md](../hooks/hooks.md)).
