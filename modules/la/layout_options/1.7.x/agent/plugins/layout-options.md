# LayoutOption plugins

A **LayoutOption** renders one option's form element and applies its value to the layout/region
build. Options are referenced by id from the `plugin:` key of a definition in a
`*.layout_options.yml` file.

- Manager: `plugin.manager.layout_options`
  (`\Drupal\layout_options\LayoutOptionPluginManager`, a `default_plugin_manager` parent).
- Directory: `src/Plugin/LayoutOption/`. Annotation: `@LayoutOption`. Interface:
  `OptionInterface`. Base: `OptionBase` (rich helpers: `createTextElement`,
  `createSelectElement`, `createCheckboxElement`, `createRadiosElement`,
  `processAttributeOptionBuild`, `validateCssIdentifier`, …).

## Built-in option plugins

| id | Class | Control |
|---|---|---|
| `layout_options_id` | `IdAttributeOption` | Single id attribute on the layout/region |
| `layout_options_class_select` | `ClassAttributeSelect` | Select list of CSS classes |
| `layout_options_class_radios` | `ClassAttributeRadios` | Radio buttons of CSS classes |
| `layout_options_class_checkboxes` | `ClassAttributeCheckboxes` | Multi-value checkboxes of CSS classes |
| `layout_options_class_string` | `ClassAttributeString` | Free-text space-separated classes |

The class-based options add their value(s) to the element's `class` attribute; the id option
sets the `id`. All run CSS-identifier validation on user input.

## Implement a LayoutOption

```php
namespace Drupal\my_module\Plugin\LayoutOption;

use Drupal\layout_options\OptionBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * @LayoutOption(
 *   id = "my_module_data_attr",
 *   label = @Translation("Data attribute"),
 * )
 */
class DataAttrOption extends OptionBase {
  public function processFormOption(string $region, array $form, FormStateInterface $formState, $default): array {
    return $this->createTextElement($region, $form, $formState, $default);
  }
  public function processOptionBuild(array $regions, array $build, string $region, $value): array {
    $build[$region]['#attributes']['data-x'] = $value;
    return $build;
  }
}
```

Reference it from a definition with `plugin: my_module_data_attr`. Clear caches after adding.
Stored values use the config schema types `layout_options.single_valued_option` (string) and
`layout_options.multi_valued_option` (sequence).
