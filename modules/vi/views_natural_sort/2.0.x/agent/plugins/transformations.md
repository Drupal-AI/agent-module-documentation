<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Transformation plugins

The transformation pipeline that turns a raw string into its sortable form is a plugin type.

## The plugin type

- Manager service: `plugin.manager.vns_transformation`
  (`IndexRecordContentTransformationManager`, extends `DefaultPluginManager`).
- Discovery dir: `src/Plugin/IndexRecordContentTransformation/`.
- Interface: `IndexRecordContentTransformationInterface` (one method: `transform($string): string`).
- Base class: `IndexRecordContentTransformationBase` (implements `ContainerFactoryPluginInterface`).
- Annotation: `@IndexRecordContentTransformation(id="…", label=@Translation("…"))`.
- Alter hook for definitions: `views_natural_sort_vns_transformation_info`.

## Shipped plugins (default pipeline order)

| id | what it does |
|---|---|
| `remove_beginning_words` | Strips configured leading words (`The, A, An, La, Le, Il`) from the start (`/^(word)\s+/iu`). Reads its word list from `configuration['settings']`. |
| `remove_words` | Removes configured filler words anywhere (`and, or, of`). |
| `remove_symbols` | Strips configured symbols (default `#"'\()[]`). |
| `numbers` | Encodes embedded numbers so they sort numerically (handles leading zeros, decimals, thousands separators, and negatives via 10's-complement). "Item 2" sorts before "Item 10". |
| `days_of_the_week` | Placeholder in this release (`transform()` returns the string unchanged); **disabled** by default. |

`ViewsNaturalSortService::getDefaultTransformations()` instantiates the enabled ones (per
`views_natural_sort.settings.transformation_settings.<id>.enabled`), passing that id's whole settings
array as plugin `configuration`. `IndexRecord::getTransformedContent()` then applies each in order and
truncates to 255 chars.

## Add your own transformation

```php
// src/Plugin/IndexRecordContentTransformation/UpperCase.php in your module
namespace Drupal\my_module\Plugin\IndexRecordContentTransformation;

use Drupal\views_natural_sort\Plugin\IndexRecordContentTransformationBase;

/**
 * @IndexRecordContentTransformation(
 *   id = "my_uppercase",
 *   label = @Translation("Uppercase")
 * )
 */
class UpperCase extends IndexRecordContentTransformationBase {
  public function transform($string) {
    return mb_strtoupper($string);
  }
}
```

Defining the plugin makes it discoverable, but the **default** pipeline only runs the five ids in
`getDefaultTransformations()`. To actually include a custom transformation (or reorder/limit them for
specific records), implement `hook_views_natural_sort_transformations_alter()` — see
[../hooks/hooks.md](../hooks/hooks.md) — and rebuild the index so stored `content` is regenerated.

## Config settings key

Each plugin's enabled flag and settings live under
`views_natural_sort.settings.transformation_settings.<id>` (`enabled` boolean + `settings`, whose
schema is `type: ignore` so plugins interpret their own settings shape).
