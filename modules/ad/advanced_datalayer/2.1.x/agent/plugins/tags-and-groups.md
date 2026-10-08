# Define datalayer tag & group plugins

Advanced Datalayer defines **two plugin types**. The base module ships none; you (or the
`example_advanced_datalayer` submodule) provide them.

## Tag plugins (`@AdvancedDatalayerTag`)

- Discovery: `src/Plugin/AdvancedDatalayer/Tag/`
- Manager: `plugin.manager.advanced_datalayer.tag`
  (`AdvancedDatalayerTagPluginManager`), alter hook `advanced_datalayer_tags`.
- Annotation: `\Drupal\advanced_datalayer\Annotation\AdvancedDatalayerTag`.
- Base classes: `DatalayerNameBase` (static-name tag) and `DatalayerDynamicNameBase` (dynamic
  name), both extending `PluginBase`.

Annotation properties:

| Property | Meaning |
|---|---|
| `id` | Machine name; also the key used in `advanced_datalayer_defaults.tags`. |
| `label` | Human label. |
| `description` | Help text. |
| `group` | Id of the group plugin this tag belongs to (e.g. `root`). |
| `global` | If TRUE the tag is editable on the main settings page and available on any page. |
| `show_empty` | If TRUE, include the tag in the dataLayer even when its value is empty. |
| `required` | If TRUE the tag is always present. |
| `translatable` | If TRUE the value is resolved in the current content language. |
| `weight` | Output ordering. |

Minimal example (from `example_advanced_datalayer`):

```php
namespace Drupal\mymodule\Plugin\AdvancedDatalayer\Tag;

use Drupal\advanced_datalayer\Plugin\AdvancedDatalayer\Tag\DatalayerNameBase;

/**
 * @AdvancedDatalayerTag(
 *   id = "page_Category",
 *   label = @Translation("Page category"),
 *   group = "page_Information",
 *   global = FALSE,
 *   required = FALSE,
 *   translatable = FALSE,
 *   show_empty = FALSE,
 *   weight = 20,
 * )
 */
class PageCategory extends DatalayerNameBase {}
```

The tag's runtime value comes from the `advanced_datalayer_defaults` config (or an entity
field), not from the plugin — the plugin declares metadata and behavior. `DatalayerNameBase`
provides `setValue()`, `value()`, `isTranslatable()`, etc., used by the manager.

## Group plugins (`@AdvancedDatalayerGroup`)

- Discovery: `src/Plugin/AdvancedDatalayer/Group/`
- Manager: `plugin.manager.advanced_datalayer.group`
  (`AdvancedDatalayerGroupPluginManager`).
- Annotation properties: `id`, `label`, `description`, `weight`.
- Base class: `GroupBase`. The core module ships `root` (id `root`, weight `-999`) — the
  top-level object. Groups nest tags into a structured dataLayer object.

```php
/**
 * @AdvancedDatalayerGroup(
 *   id = "page_Information",
 *   label = @Translation("Page information"),
 *   weight = 10,
 * )
 */
class PageInformation extends GroupBase {}
```

After adding plugins, clear caches so the managers rediscover them (`drush cr`). The example
submodule (`example_advanced_datalayer`) contains working tags — `event`, `site_Name`,
`site_Category`, `page_Name`, `page_Category`, `response_Code`, `ga_client_id` — and groups
`site_Information`, `page_Information`, plus the core `root`.
