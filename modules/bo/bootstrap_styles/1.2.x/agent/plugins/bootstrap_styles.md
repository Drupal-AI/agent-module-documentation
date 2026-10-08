# Plugin types — Style & StylesGroup

Two annotation-based plugin types, each with its own manager service.

| Plugin type | Manager service (class) | Subdir | Interface / base | Annotation |
|---|---|---|---|---|
| **Style** (a single control) | `plugin.manager.bootstrap_styles` (`Style\StyleManager`) | `Plugin/BootstrapStyles/Style` | `StylePluginInterface` / `StylePluginBase` | `@Style` |
| **StylesGroup** (a group tab) | `plugin.manager.bootstrap_styles_group` (`StylesGroup\StylesGroupManager`) | `Plugin/BootstrapStyles/StylesGroup` | `StylesGroupPluginInterface` / `StylesGroupPluginBase` | `@StylesGroup` |

Both managers `alterInfo('bootstrap_styles_info')`. Built-in groups: `background`, `spacing`,
`border`, `shadow`, `typography`, `animation`. Built-in styles include `background_color`,
`background_media`, `padding`, `margin`, `border`, `box_shadow`, `text_color`,
`text_alignment`, `scroll_effects`. A `Style` is bound to a group via `group_id`.

## Add a Style plugin

```php
namespace Drupal\my_module\Plugin\BootstrapStyles\Style;

use Drupal\bootstrap_styles\Style\StylePluginBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * @Style(
 *   id = "opacity",
 *   title = @Translation("Opacity"),
 *   group_id = "typography",
 *   weight = 5
 * )
 */
class Opacity extends StylePluginBase {

  // Edit the option classes on the settings form (writes to bootstrap_styles.settings).
  public function buildConfigurationForm(array $form, FormStateInterface $form_state) { /* … */ return $form; }
  public function submitConfigurationForm(array &$form, FormStateInterface $form_state) { /* $this->config()->set(...)->save(); */ }

  // The control shown in the Layout Builder style form.
  public function buildStyleFormElements(array &$form, FormStateInterface $form_state, $storage) {
    $form['opacity'] = [
      '#type' => 'radios',
      '#options' => $this->getStyleOptions('opacity_classes'), // key|label list from config
      '#default_value' => $storage['opacity']['class'] ?? NULL,
    ];
    return $form;
  }

  // Persist the chosen value into the per-element storage array.
  public function submitStyleFormElements(array $group_elements) {
    return ['opacity' => ['class' => $group_elements['opacity']]];
  }

  // On render, attach the class to the element build (or its theme wrapper).
  public function build(array $build, array $storage, $theme_wrapper = NULL) {
    if (!empty($storage['opacity']['class']) && $storage['opacity']['class'] !== '_none') {
      $build = $this->addClassesToBuild($build, [$storage['opacity']['class']], $theme_wrapper);
    }
    return $build;
  }
}
```

`StylePluginBase` helpers: `config()` (editable `bootstrap_styles.settings`),
`getStyleOptions($name)`, `getStyleOptionClassByIndex()`, `getStyleOptionIndexByClass()`,
`getStyleOptionsCount()`, `getSvgIconMarkup()`, `addClassesToBuild()`, `getTitle()`.

## Add a StylesGroup plugin

```php
namespace Drupal\my_module\Plugin\BootstrapStyles\StylesGroup;

use Drupal\bootstrap_styles\StylesGroup\StylesGroupPluginBase;

/**
 * @StylesGroup(
 *   id = "effects",
 *   title = @Translation("Effects"),
 *   weight = 9,
 *   icon = "my_module/images/effects-icon.svg"
 * )
 */
class Effects extends StylesGroupPluginBase {}
```

Same lifecycle methods (`buildConfigurationForm`, `buildStyleFormElements`,
`submitStyleFormElements`, `build`) plus `getTitleWithIcon()` / `getIconPath()` (the `icon`
annotation is `module_name/path/to.svg`). Groups collect the styles whose `group_id` matches.
