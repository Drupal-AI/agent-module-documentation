<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Splide alter hooks

`splide.api.php` invites four hooks (all `@ingroup splide_api`). They fire in
`SplideManager::preRenderSplide()` / `SplideFormatter::buildSettings()`.

## `hook_splide_overridable_options_info_alter(&$options)`

Add **boolean** options to the "Override main optionset" checkboxes shown on Splide
formatter/Views forms (so one optionset can be reused with per-instance toggles).

```php
function my_module_splide_overridable_options_info_alter(&$options) {
  $options['waitForTransition'] = t('Wait for transition');
}
```

## `hook_splide_optionset_alter(Splide &$splide, array $settings)`

Modify the optionset entity (main + responsive settings) before render.

```php
function my_module_splide_optionset_alter(\Drupal\splide\Entity\Splide &$splide, array $settings) {
  if ($splide->id() === 'x_splide_nav') {
    $splide->setSetting('arrows', FALSE);
    foreach ($splide->getResponsiveOptions() as $key => $responsive) {
      if ($responsive['breakpoint'] == 481) {
        $values = $responsive['settings'] + ['perPage' => 1, 'padding' => '1em'];
        $splide->setResponsiveSettings($values, $key);
      }
    }
  }
}
```

## `hook_splide_options_alter(array &$options, array $settings, Splide $splide)`

Alternative to the optionset hook — change the raw JS `$options` array directly based on
`$settings` / the `$splide` entity.

## `hook_splide_settings_alter(array &$build, $items)`

Change the HTML/build settings before preprocess. Since Blazy 2.17 the settings live under
`$build['#settings']` (with a `blazies` metadata object); you can also use the ecosystem-wide
`hook_blazy_settings_alter()` instead to affect splide/gridstack/mason together.

```php
function my_module_splide_settings_alter(array &$build, $items) {
  $settings = &$build['#settings'];
  $blazies = $settings['blazies'];
  if (($id = $blazies->get('entity.id')) && $settings['optionset'] === 'x_splide_for') {
    $settings['skin'] = $id == 54 ? 'fullwidth' : $settings['skin'];
  }
}
```

Reference for all option keys: `config/install/splide.optionset.default.yml`.
