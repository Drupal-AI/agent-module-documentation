<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `@ResponsiveMenus` plugin type (styles)

A "style" is a plugin discovered from `Plugin/ResponsiveMenus/`, managed by
`plugin.manager.responsive_menus` (`ResponsiveMenusPluginManager`, a `DefaultPluginManager`).
Annotation class `Drupal\responsive_menus\Annotation\ResponsiveMenus`; interface
`ResponsiveMenusPluginInterface`; base class `ResponsiveMenusPluginBase` (extends
`PluginSettingsBase`). Alter hook id: `responsive_menus_styles`.

## Annotation fields

```php
@ResponsiveMenus(
  id = "my_style",
  label = @Translation("My Style"),
  library = "my_module/my_style"   // the Drupal library attached when this style is active
)
```

## Interface methods to implement

- `defaultSettings()` (static) — default `style_settings` for this style.
- `settingsForm(array $form, FormStateInterface $form_state)` — form elements added under the
  style-settings fieldset on the admin form (read current values via `$this->getSetting('key')`).
- `getJsSettings()` — array pushed to `drupalSettings.responsive_menus` for the JS to consume.
- `getSelectorInfo()` — help text describing which selector to use.

`ResponsiveMenusPluginBase::getSettingArray($name)` is a helper that splits a selector string
(commas or newlines) into an array.

## Shipped plugins (`src/Plugin/ResponsiveMenus/`)

| Plugin id | Label | Library | Ships ready? |
|---|---|---|---|
| `responsive_menus_simple` | Simple expanding | `responsive_menus/responsive_menus_simple` | yes (default) |
| `mean_menu` | Mean Menu | `responsive_menus/mean_menu` | yes |
| `sidr` | Sidr | (external) | needs library download |
| `codrops_responsive_multi` | codrops Multi-level | (external) | needs library download |
| `google_nexus` | Google Nexus (codrops) | (external) | needs library download |
| `mlpm` | Multi-level Push Menu | (external) | needs library download |

## Minimal custom style

```php
// src/Plugin/ResponsiveMenus/MyStyle.php
namespace Drupal\my_module\Plugin\ResponsiveMenus;
use Drupal\responsive_menus\ResponsiveMenusPluginBase;

/** @ResponsiveMenus(id="my_style", label=@Translation("My Style"), library="my_module/my_style") */
class MyStyle extends ResponsiveMenusPluginBase {
  public static function defaultSettings() { return ['my_selectors' => '#main-menu', 'my_width' => 768]; }
  public function settingsForm(array $form, $form_state) {
    $form['my_selectors'] = ['#type'=>'textarea','#title'=>$this->t('Selectors'),'#default_value'=>$this->getSetting('my_selectors')];
    return $form;
  }
  public function getJsSettings() { return ['selectors'=>$this->getSettingArray('my_selectors'),'media_size'=>$this->getSetting('my_width')]; }
}
```

Then define the `my_module/my_style` library and select "My Style" on the settings form (its
plugin id becomes `responsive_menus.configuration:style`).
