<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `style_option` plugin type

Style Options defines a plugin type for the individual style controls.

- Manager service: `plugin.manager.style_options` (`StyleOptionPluginManager`, extends
  `DefaultPluginManager`).
- Discovery dir: `src/Plugin/StyleOption/`.
- Annotation: `@StyleOption` (`Drupal\style_options\Annotation\StyleOption`, fields `id`, `label`).
  (An unused `@StyleOptionPlugin` annotation class also exists.)
- Interface / base: `Contracts\StyleOptionPluginInterface` / `Plugin\StyleOptionPluginBase`.
- Alter hook: `hook_style_options_alter()` (the manager calls `alterInfo('style_options')`).

## Shipped plugins

| id | class | purpose |
|---|---|---|
| `css_class` | `Plugin\StyleOption\CssClass` | textfield or select of CSS classes; `multiple` for multi-select; renders as image radios if `image_radios` is installed and options carry `image` |
| `background_color` | `Plugin\StyleOption\BackgroundColor` | Spectrum color picker; `method: css|inline`; `settings` passed to Spectrum |
| `background_image` | `Plugin\StyleOption\BackgroundImage` | image upload/reference applied as a background |
| `property` | `Plugin\StyleOption\Property` | generic single-value property control |

You reference these by their `id` in the `plugin:` key of a `[ext].style_options.yml` option.

## Writing a custom plugin

Add `src/Plugin/StyleOption/MyOption.php` in your module:

```php
namespace Drupal\my_module\Plugin\StyleOption;

use Drupal\Core\Form\FormStateInterface;
use Drupal\style_options\Plugin\StyleOptionPluginBase;

/**
 * @StyleOption(
 *   id = "my_option",
 *   label = @Translation("My option")
 * )
 */
class MyOption extends StyleOptionPluginBase {

  public function buildConfigurationForm(array $form, FormStateInterface $form_state): array {
    $id = $this->getPluginId();
    $form[$id] = [
      '#type' => 'textfield',
      '#title' => $this->getLabel(),
      '#default_value' => $this->getValue($id) ?? $this->getDefaultValue(),
    ];
    return $form;
  }

  // Optionally override build()/applied output to attach classes or inline styles.
}
```

Key base-class helpers (`StyleOptionPluginBase`): `getValue($key)` / `setValue()` / `getValues()`,
`getConfiguration($key)` / `hasConfiguration($name)`, `getLabel()`, `getDefaultValue()`,
`getOptionId()`, `formatValue($value)`. The plugin's per-instance configuration comes from the
matching entry in the `[ext].style_options.yml` `options:` section. Reference `my_option` from a
YAML option via `plugin: my_option`.
