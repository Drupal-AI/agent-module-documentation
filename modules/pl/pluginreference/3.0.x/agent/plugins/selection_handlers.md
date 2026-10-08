# Plugin type: `PluginReferenceSelection` (selection handlers)

Selection handlers decide **which plugin IDs a `plugin_reference` field may reference** and
provide the referenceable list to widgets/autocomplete — the plugin-world equivalent of
core's Entity Reference selection plugins.

## The plugin type

- Manager service: `plugin.manager.plugin_reference_selection`
  (class `PluginReferenceSelectionManager`, extends `DefaultPluginManager`).
- Discovery namespace: `Plugin/PluginReferenceSelection`.
- Interface: `Drupal\pluginreference\PluginReferenceSelectionInterface`
  (extends `PluginInspectionInterface`, `PluginFormInterface`, `ConfigurableInterface`,
  `DependentPluginInterface`).
- Base class: `Drupal\pluginreference\PluginReferenceSelectionBase`.
- Attribute: `Drupal\pluginreference\Attribute\PluginReferenceSelection`
  (legacy annotation `Drupal\pluginreference\Annotation\PluginReferenceSelection` also
  supported).
- Alter hook: `hook_plugin_reference_selection_alter` (alter info `plugin_reference_selection`).
- Cache bin key: `plugin_reference_selection_plugins`. Fallback plugin ID: `broken`
  (`FallbackPluginManagerInterface::getFallbackPluginId()` always returns `broken`).

### Attribute properties

| Property | Meaning |
|---|---|
| `id` | Plugin ID. Must equal `group`, or be prefixed `group:...` (e.g. `default`, `default:block`). |
| `label` | Human-readable name. |
| `plugin_types` | Array of `target_type` IDs this handler supports; empty = all types. |
| `group` | Selection group; lets a type-specific handler inherit another's group (e.g. group `default`). |
| `weight` | Best-match selection within a group (highest weight wins). |
| `deriver` | Optional deriver class. |

## Built-in handlers

| Plugin ID | Class | Notes |
|---|---|---|
| `default` (+ `default:<type>` derivatives) | `DefaultSelection` | Lists all definitions of the target type; sort by `id`/`label`, ASC/DESC. `DefaultSelectionDeriver` derives one per discovered plugin type. |
| `filtered` (+ `filtered:<type>`) | `FilteredSelection` | Adds an include/exclude filter on plugin `id` or `provider`. |
| `default:block` | `BlockSelection` | Like `default` but drops block plugins the current user cannot `access()`. |
| `filtered:block` | `BlockFilteredSelection` | `filtered` + block-access filtering + a `category` filter key. |
| `broken` | `Broken` | Fallback; returns no referenceable plugins. Hidden from the UI. |

## How selection is resolved

`PluginReferenceSelectionManager::getSelectionHandler($field_definition, $entity)` reads the
field's `handler` + `handler_settings` + storage `target_type`, then `getInstance()`:
a handler ID containing `:` is used directly, otherwise the best-weighted plugin in that
group for the target type is chosen via `getPluginId()`. `getSelectionGroups($target_type)`
returns handlers whose `plugin_types` is empty or contains the target type.

## Write a custom selection handler

Extend `DefaultSelection` (or `PluginReferenceSelectionBase`) and add the attribute. Override
`getReferenceablePlugins()` and/or `filterReferenceablePluginDefinitions()` to control the
list; override `buildConfigurationForm()`/`defaultConfiguration()` for settings (also add a
matching `plugin_reference_selection.<id>` config-schema entry).

```php
namespace Drupal\my_module\Plugin\PluginReferenceSelection;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\pluginreference\Attribute\PluginReferenceSelection;
use Drupal\pluginreference\Plugin\PluginReferenceSelection\DefaultSelection;

#[PluginReferenceSelection(
  id: 'default:my_type',
  label: new TranslatableMarkup('My type'),
  plugin_types: ['my_type'],
  group: 'default',
  weight: 5,
)]
class MyTypeSelection extends DefaultSelection {
  protected function filterReferenceablePluginDefinitions(array &$plugin_definitions): void {
    // Unset any definitions that must not be referenceable.
  }
}
```

Key interface methods a handler must satisfy: `getReferenceablePlugins($match, $match_operator, $limit)`
(nested/flat array of escaped labels keyed by plugin ID), `countReferenceablePlugins()`,
`validateReferenceablePlugins(array $ids)` (returns the subset that is valid — this is what
the field's `ValidPluginReference` constraint enforces), plus the `PluginFormInterface` /
`ConfigurableInterface` / `DependentPluginInterface` methods provided by the base class.
