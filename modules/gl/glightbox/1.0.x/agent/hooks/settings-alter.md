<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Override GLightbox JS options

`glightbox.api.php` invites one hook, `hook_glightbox_settings_alter()`, letting you change any of
the options passed to the GLightbox JavaScript constructor before they are attached to the page.

```php
/**
 * Implements hook_glightbox_settings_alter().
 *
 * @param array $settings
 *   The GLightbox settings array (see the GLightbox library README for all keys:
 *   https://github.com/biati-digital/glightbox).
 */
function my_module_glightbox_settings_alter(array &$settings): void {
  // Disable automatic downscaling of images to width/height.
  $settings['scalePhotos'] = FALSE;

  // Conditionally tweak options for a specific page.
  if (\Drupal::service('path.current')->getPath() === '/node/42') {
    $settings['scalePhotos'] = TRUE;
  }
}
```

Use it for options that aren't exposed on the admin form, or to vary behavior per route/context.
The keys are the raw GLightbox library option names (e.g. `openEffect`, `slideEffect`, `zoomable`,
`loop`, `moreLength`, `plyr`), not the Drupal config keys.
