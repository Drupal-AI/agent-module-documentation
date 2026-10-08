<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `masonry.service` (`MasonryService`)

```php
/** @var \Drupal\masonry\Services\MasonryService $masonry */
$masonry = \Drupal::service('masonry.service');
```

Constructor args: `@module_handler`, `@theme.manager`, `@language_manager`, `@config.factory`.

## `getMasonryDefaultOptions(): array`

| Option | Default | Meaning |
|---|---|---|
| `layoutColumnWidth` | `''` | Column width: `''` (size of first item), `500px`, `30%`, or a CSS selector (`.grid-sizer`). |
| `gutterWidth` | `'0'` | Same unit rules as above. |
| `isLayoutResizable` | `TRUE` | Re-layout on container resize. |
| `isLayoutAnimated` | `TRUE` | Animate repositioning. |
| `layoutAnimationDuration` | `500` | ms. |
| `isLayoutFitsWidth` | `FALSE` | Masonry `fitWidth` (centring). |
| `isLayoutRtlMode` | *current language direction* | Right-to-left. |
| `isLayoutImagesLoadedFirst` | `TRUE` | Wait for imagesLoaded before laying out. |
| `isLayoutImagesLazyLoaded` | `FALSE` | Install the lazysizes `MutationObserver`. |
| `imageLazyloadSelector` | `'lazyload'` | lazysizes "to load" class. |
| `imageLazyloadedSelector` | `'lazyloaded'` | lazysizes "loaded" class. |
| `stampSelector` | `''` | CSS selector of stamped elements. |
| `isItemsWidthForce` | `TRUE` | Force item width to the column width (only meaningful with a numeric `layoutColumnWidth`). |
| `isItemsPositionInPercent` | `FALSE` | Masonry `percentPosition`. |
| `extraOptions` | `[]` | Passed straight through to the JS as `extra_options`. |

When the **`lazy`** module is installed, `imageLazyloadSelector` / `imageLazyloadedSelector` are
read from `lazy.settings` (`lazysizes.lazyClass` / `lazysizes.loadedClass`) instead of the
hard-coded defaults.

`hook_masonry_default_options_alter()` is **not** invoked here — see
[../hooks/alters.md](../hooks/alters.md).

## `applyMasonryDisplay(array &$form, string $container, string $item_selector, array $options = [], array $masonry_ids = ['masonry_default']): void`

Does nothing when `$container` is empty. Otherwise:

1. `$options += getMasonryDefaultOptions()`.
2. Splits `layoutColumnWidth` / `gutterWidth` into a value plus a unit
   (`px`, `%`, or `css` when it is a selector), stripping spaces.
3. Builds the JS payload under the container selector, renaming the options:

```php
$masonry['masonry'][$container] = [
  'masonry_ids'      => $masonry_ids,
  'item_selector'    => $item_selector,
  'column_width'     => …, 'column_width_units' => 'px'|'%'|'css',
  'gutter_width'     => …, 'gutter_width_units' => 'px'|'%'|'css',
  'resizable'        => (bool) isLayoutResizable,
  'animated'         => (bool) isLayoutAnimated,
  'animation_duration' => (int) layoutAnimationDuration,
  'fit_width'        => (bool) isLayoutFitsWidth,
  'rtl'              => (bool) isLayoutRtlMode,
  'images_first'     => (bool) isLayoutImagesLoadedFirst,
  'images_lazyload'  => (bool) isLayoutImagesLazyLoaded,
  'lazyload_selector'   => imageLazyloadSelector,
  'lazyloaded_selector' => imageLazyloadedSelector,
  'stamp'            => stampSelector,
  'force_width'      => (bool) isItemsWidthForce,
  'percent_position' => (bool) isItemsPositionInPercent,
  'extra_options'    => extraOptions,
];
```

4. Runs `hook_masonry_script_alter($masonry, $context)` through **both** the module handler and the
   theme manager, with `$context = ['container' => …, 'item_selector' => …, 'options' => …]`.
5. `$form['#attached']['library'][] = 'masonry/masonry.layout';` and merges `$masonry` into
   `$form['#attached']['drupalSettings']`.

`$form` is any render array — it does not have to be a form.

### Minimal usage

```php
$build = [
  '#theme' => 'item_list',
  '#items' => $items,
  '#attributes' => ['class' => ['my-grid']],
];
\Drupal::service('masonry.service')->applyMasonryDisplay(
  $build,
  '.my-grid',              // container selector
  '.my-grid > li',         // item selector
  ['layoutColumnWidth' => '250px', 'gutterWidth' => '10px', 'isLayoutFitsWidth' => TRUE],
  ['my_module_grid']       // ids so alter hooks can recognise this display
);
return $build;
```

## `buildSettingsForm(array $default_values = []): array`

Returns a form fragment with one element per option (`layoutColumnWidth`, `gutterWidth`,
`stampSelector`, `isLayoutResizable`, `isLayoutAnimated`, `layoutAnimationDuration`,
`isLayoutFitsWidth`, `isLayoutImagesLoadedFirst`, `isLayoutImagesLazyLoaded`,
`isItemsWidthForce`, `isItemsPositionInPercent`), runs
`hook_masonry_options_form_alter($form, $default_values)` for modules **and** themes, and appends
`$this->validateSettingsForm` to `$form['#validate']`.

`$default_values` defaults to `getMasonryDefaultOptions()` when empty.

```php
$form['style_options'] = \Drupal::service('masonry.service')->buildSettingsForm($saved_values);
```

`validateSettingsForm()` reads `$form_state->getValue(['style_options', 'layoutColumnWidth'])` and
`['style_options', 'gutterWidth']` and errors with "The unit seems to be missing on this field."
when the value `is_numeric()`. **That path is hard-coded** — if you embed the fragment somewhere
other than a `style_options` key the validator silently validates nothing.

## `isMasonryInstalled(): ?string` / `isImagesloadedInstalled(): ?string`

Return the library path or NULL. Resolution order: the core
`library.libraries_directory_file_finder` service, then the contrib **libraries** module's
`libraries.manager`, then the literal `libraries/…` path relative to the docroot.

## Client behaviour (`js/masonry.js`)

`Drupal.behaviors.masonry` iterates `drupalSettings.masonry`, and per container either initialises
(`addClass('masonry').addClass('masonry-layout').masonry(options)` plus a window-resize
`bindResize`) or re-lays out an existing instance (`reloadItems` + `layout`). When
`images_lazyload` is on it attaches a `MutationObserver` to `img.<lazyload_selector>` elements and
re-lays out when they gain the `<lazyloaded_selector>` class.
