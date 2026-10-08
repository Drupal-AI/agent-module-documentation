# ViewsStripingType plugin type

The module defines one plugin type, `ViewsStripingType`, whose plugins decide which CSS classes go
on which rows. The display extender (`views_striping`) picks one by id and delegates to it.

## The manager

- Service id: `plugin.manager.views_striping_type` (defined in `views_striping.services.yml`,
  `parent: default_plugin_manager`).
- Class: `Drupal\views_striping\ViewsStripingTypeManager` (extends `DefaultPluginManager`).
- Plugin subdirectory: `Plugin/ViewsStripingType`.
- Interface each plugin must implement: `Drupal\views_striping\Plugin\ViewsStripingType\ViewsStripingTypeInterface`.
- Annotation class: `Drupal\views_striping\Annotation\ViewsStripingType` — fields: `id`, `label`,
  `description` (`label`/`description` are `@Translation`).
- Alter hook: `hook_views_striping_type_info_alter` (info id `views_striping_type_info`); cache
  bin key `views_striping_type_plugins`.

A `views_striping.plugin_type.yml` is also shipped. It is only consumed by the optional contrib
**Plugin** module (`drupal/plugin`); the plugin type works without it via the service above. Plugin
is **not** a dependency.

## The interface

`ViewsStripingTypeInterface` declares three methods (base class
`ViewsStripingTypeBase extends PluginBase` gives the first two no-op defaults):

| Method | Purpose |
| --- | --- |
| `defineOptions()` | Extra extender option defaults this type needs (e.g. `['striping_field' => ['default' => '']]`). Default: `[]`. |
| `buildOptionsForm(DisplayExtenderPluginBase $extender)` | Form elements for those options, shown only when this type's radio is selected (the extender wraps them in a `#states`-gated container). Default: `[]`. |
| `preprocessViewRows(DisplayExtenderPluginBase $extender, &$rows)` | Adds classes to `$rows` (the preprocessor's `rows` variable). Read stored option values from `$extender->options[...]`. |

## Built-in plugins

| id | Class | Options | Behaviour |
| --- | --- | --- | --- |
| `alternating` | `…\Plugin\ViewsStripingType\Alternating` | none | `addClass($index % 2 ? 'even' : 'odd')` per row. |
| `field_value` | `…\Plugin\ViewsStripingType\FieldValue` | `striping_field` (a field handler id) | Flips `odd`↔`even` whenever `$row['columns'][$field]['content']` differs from the previous row. |

## Add your own striping type

Drop a class in `your_module/src/Plugin/ViewsStripingType/`, extend `ViewsStripingTypeBase`, and
implement `preprocessViewRows()`:

```php
namespace Drupal\your_module\Plugin\ViewsStripingType;

use Drupal\views\Plugin\views\display_extender\DisplayExtenderPluginBase;
use Drupal\views_striping\Plugin\ViewsStripingType\ViewsStripingTypeBase;

/**
 * @ViewsStripingType(
 *   id = "every_third",
 *   label = @Translation("Every third row"),
 *   description = @Translation("Adds a class to every third row"),
 * )
 */
class EveryThird extends ViewsStripingTypeBase {

  public function preprocessViewRows(DisplayExtenderPluginBase $extender, &$rows) {
    foreach ($rows as $index => &$row) {
      if ($index % 3 === 0) {
        $row['attributes']->addClass('third');
      }
    }
  }

}
```

Override `defineOptions()` + `buildOptionsForm()` too if the type needs its own settings (see
`FieldValue`); read those values back from `$extender->options[...]` inside `preprocessViewRows()`.
Clear caches so the manager discovers the new plugin — it then appears as another radio in the
table Format settings automatically.

To retarget an existing definition without subclassing, implement the alter hook:

```php
function mymodule_views_striping_type_info_alter(array &$info) {
  $info['alternating']['class'] = \Drupal\mymodule\MyAlternating::class;
}
```
