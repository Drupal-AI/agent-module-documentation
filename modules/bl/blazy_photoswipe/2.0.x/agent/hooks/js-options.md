# Customising PhotoSwipe options — `hook_blazy_photoswipe_js_options_alter()`

The options object handed to the PhotoSwipe JS library is assembled in
`blazy_photoswipe_blazy_attach_alter()` and exposed as
`drupalSettings.photoswipe.options`. Before it is attached, the module runs:

```php
blazy()->moduleHandler()->alter('blazy_photoswipe_js_options', $options);
```

So any module can implement `hook_blazy_photoswipe_js_options_alter(array &$options)` to add
or override PhotoSwipe options (both PS4 and PS5). This is the only hook the module invites.

```php
/**
 * Implements hook_blazy_photoswipe_js_options_alter().
 */
function MYMODULE_blazy_photoswipe_js_options_alter(array &$options) {
  // PhotoSwipe 5 option names — see https://photoswipe.com/options/
  $options['bgOpacity'] = 0.9;
  $options['loop'] = FALSE;
  $options['showHideAnimationType'] = 'fade';
}
```

## What is in `$options` before your alter

- For **PhotoSwipe 5**: the defaults from `_blazy_photoswipe_5_options()`
  (`showAnimationDuration`/`hideAnimationDuration` 333, `showHideAnimationType` `zoom`,
  `bgOpacity` 0.97, `spacing` 0.12, `allowPanToNext`, `maxZoomLevel` 2,
  `maxWidthToAnimate` 800, `modal`, `loop`, `preload [1,2]`, `pinchToClose`,
  `closeOnVerticalDrag`, `escKey`, `arrowKeys`), merged with any values from the optional
  `photoswipe` module's `photoswipe.settings:options`.
- For **PhotoSwipe 4**: whatever the `photoswipe` module's `photoswipe.settings:options`
  provides (empty if that module is absent).
- `$options['version']` is set to `5` or `4` — do not clobber it.

## Related hooks the module itself implements (context, not for you to call)

- `hook_blazy_lightboxes_alter()` — adds `photoswipe` to Blazy's Media switch list.
- `hook_blazy_attach_alter()` — attaches the library + drupalSettings when a display uses it.
- `hook_blazy_settings_alter()` — flags `is.richbox` / `is.encodedbox` so local video plays
  inside the lightbox.
- `hook_library_info_alter()` — for PS4, rewrites the `load` library to point at the real
  `/libraries/photoswipe/dist` JS/CSS files.
