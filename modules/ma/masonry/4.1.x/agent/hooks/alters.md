<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alter hooks (`masonry.api.php`)

Three hooks. All are invoked for **modules and themes** (the service calls both
`module_handler->alter()` and `theme.manager->alter()`), so a theme can implement them in its
`.theme` file with the same names.

## `hook_masonry_default_options_alter(array &$options)`

Add or change the default option values.

```php
function mymodule_masonry_default_options_alter(array &$options) {
  $options['masonry_animation_easing'] = 'swing';
  $options['layoutColumnWidth'] = '.grid-sizer';
}
```

> **Caveat:** `MasonryService::getMasonryDefaultOptions()` does **not** invoke this hook itself —
> the docblock in `masonry.api.php` documents the contract, but the alter is only reached through
> consumers that call it (e.g. the Masonry Views style plugin). If you need the defaults altered
> in your own code path, run `$this->moduleHandler->alter('masonry_default_options', $options)`
> yourself, or set the values in the `$options` you pass to `applyMasonryDisplay()`.

## `hook_masonry_options_form_alter(array &$form, array $default_values)`

Invoked by `MasonryService::buildSettingsForm()` (module alter then theme alter). Add UI for any
option you introduced.

```php
function mymodule_masonry_options_form_alter(array &$form, array $default_values) {
  $form['layoutAnimationEasing'] = [
    '#type' => 'select',
    '#title' => t('Animation easing'),
    '#options' => ['linear' => t('Linear'), 'swing' => t('Swing')],
    '#default_value' => $default_values['masonry_animation_easing'] ?? 'linear',
    '#states' => ['visible' => [
      'input.form-checkbox[name*="isLayoutResizable"]' => ['checked' => TRUE],
      'input.form-checkbox[name*="isLayoutAnimated"]' => ['checked' => TRUE],
    ]],
  ];
}
```

## `hook_masonry_script_alter(array &$masonry, array $context)`

Invoked by `applyMasonryDisplay()` just before the settings are attached — this is the reliable
place to change what the JavaScript receives.

`$masonry` is `['masonry' => [<container selector> => [...the snake_case payload...]]]`.
`$context` is `['container' => …, 'item_selector' => …, 'options' => …]`.

```php
function mymodule_masonry_script_alter(array &$masonry, array $context) {
  $container = $context['container'];
  $options = $context['options'];

  // Ship a custom option added via the options form.
  $masonry['masonry'][$container]['animation_easing'] = $options['layoutAnimationEasing'] ?? 'swing';

  // Any raw Masonry option the module does not expose:
  $masonry['masonry'][$container]['extra_options']['horizontalOrder'] = TRUE;

  // Only touch a specific display:
  if (in_array('my_module_grid', $masonry['masonry'][$container]['masonry_ids'], TRUE)) {
    $masonry['masonry'][$container]['fit_width'] = TRUE;
  }
}
```

`masonry_ids` (default `['masonry_default']`) exists precisely so an alter hook can tell one
display from another — pass your own ids as the 5th argument of `applyMasonryDisplay()`.

## Other hooks the module itself implements

- `masonry_libraries_info()` — metadata for the contrib **libraries** module (name, vendor/download
  URLs, version-detection regex, file lists) for `masonry` and `imagesloaded`.
- `masonry_library_info_alter()` — when `MasonryService::isMasonryInstalled()` /
  `isImagesloadedInstalled()` resolve a path outside the default `/libraries` location, the `js`
  key of the corresponding library definition is rewritten to that path.
- `masonry_requirements()` — status-report entries `masonry` and `imagesloaded`
  (`REQUIREMENT_ERROR` when the file is missing).
