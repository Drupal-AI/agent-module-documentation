<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `BsSlider` plugin type

Each concrete slider/gallery is a `BsSlider` plugin. Library submodules ship these; you can add
your own.

## Discovery

- Manager: `Plugin/BsSliderManager` (service `plugin.manager.bs_slider`, `parent:
  default_plugin_manager`). Subdir `Plugin/BsSlider`, interface
  `Plugin\BsSliderInterface`, annotation `Annotation\BsSlider`, alter hook
  `bs_slider_bs_slider_info`, cache key `bs_slider_bs_slider_plugins`.
- Annotation `@BsSlider` (`src/Annotation/BsSlider.php`): `id`, `label`, `description`.
- Place classes in `modules/<yourmod>/src/Plugin/BsSlider/`.

## Base class `BsSliderBase` (`src/Plugin/BsSliderBase.php`)

Implements `BsSliderInterface`, `ContainerFactoryPluginInterface`, and (via interface)
`ConfigurableInterface` + `PluginFormInterface`. Provides:

- `setConfiguration()` merges incoming options over `defaultConfiguration()` (subclass supplies).
- `buildConfigurationForm()/validate/submit` — no-ops by default; override to add option widgets
  under `$form['options']` (the entity form supplies the `options` fieldset, `#tree = TRUE`).
- `buildPluginOptionsForm($form, $form_state, $plugin_option)` — returns extra form elements for
  **formatters/behaviors** (e.g. a per-field "view mode" select), receiving a
  `BsSliderPluginOptionInterface` (the formatter/behavior) so the plugin can read/return its
  option values. Default `[]`.
- `preprocess(&$variables)` — no-op; override to populate template variables and `attributes`.
- `buildSliderArray($items, $bs_slider)` → `['#theme' => 'bs_slider', '#id' => Html::getUniqueId(),
  '#items' => …, '#settings' => ['bs_slider' => id], '#cache' => ['tags' => entity cache tags]]`.
- `view(&$build, $bs_slider, $options=[])` — default carousel-style implementation: iterates
  `Element::children($build)`, unwraps Views `content`, optionally re-keys view mode, then replaces
  `$build` with `buildSliderArray()`. Override for galleries/thumbs (they build multiple item sets).

## Interface `BsSliderInterface`

`buildPluginOptionsForm()`, `getDescription()`, `preprocess(&$vars)`,
`view(&$build, BsSliderConfigurationInterface $bs_slider, array $options = [])`.

## `BsSliderPluginOptionInterface` (`src/BsSliderPluginOptionInterface.php`)

Implemented by the **consumers** (formatters, paragraph behavior), not the slider plugins:
`getPluginOptionValue($name)` and `getPluginOptions($name)` (e.g. `target_field_view_modes`
returns available view modes for the referenced entity type). A slider plugin's
`buildPluginOptionsForm()` calls these to build its per-consumer form (usually a view-mode select).

## Minimal example

```php
namespace Drupal\my_module\Plugin\BsSlider;

use Drupal\bs_slider\Plugin\BsSliderBase;

/**
 * @BsSlider(
 *   id = "my_slider",
 *   label = @Translation("My Slider"),
 *   description = @Translation("…"),
 * )
 */
class MySlider extends BsSliderBase {
  public function defaultConfiguration() { return ['autoplay' => FALSE]; }
  public function preprocess(array &$variables) {
    parent::preprocess($variables);
    $variables['items'] = $variables['element']['#items'];
    $variables['attributes']['data-autoplay'] = $this->getConfiguration()['autoplay'] ? '1' : '0';
  }
}
```

Add a matching `bs_slider.options.my_slider` config schema and, if you want custom markup, a
`bs_slider__my_slider.html.twig` (extend `bs-slider.html.twig`) plus a `hook_theme()` entry with
`'base hook' => 'bs_slider'`.

## Consumption path

A formatter / Views style / paragraph behavior loads the optionset, calls
`$manager->getPlugin($id)`, then `$plugin->view($build, $optionset, $options)`. The render array's
`#theme => bs_slider` triggers `template_preprocess_bs_slider()`, which calls the plugin's
`preprocess()` before the (suggested) template renders. Options set here are also emitted by
library submodules into a `data-bs-slider-options` attribute for their JS to read.
