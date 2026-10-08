<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Manager service and alter hook

## `easy_responsive_images.manager`

Service class `EasyResponsiveImagesManager` (interface `EasyResponsiveImagesManagerInterface`).
It reads the generated `responsive_*` image styles and returns derivative URL sets. Public
methods:

| Method | Returns |
|---|---|
| `getAspectRatios(): array` | Configured aspect ratios keyed by group (e.g. `['16_9' => '16:9']`), derived from the `responsive_<w>_<h>_<width>w` styles that exist. |
| `getImagesByAspectRatio(string $uri, string $aspect_ratio): array` | Sorted list of `['url','width','height','srcset_url']` for that ratio group. |
| `getImagesByScale(string $uri): array` | Sorted list of `['url','width','srcset_url']` for the flexible-height `responsive_<width>w` styles. |

Each URL is passed through best-format negotiation: Avif (if `avif` installed) then WebP (if
`imageapi_optimize_webp`/`webp` installed), otherwise the plain derivative. The field formatter
consumes these methods; call them directly to build custom responsive markup in a controller or
preprocess.

```php
$mgr = \Drupal::service('easy_responsive_images.manager');
$srcset = $mgr->getImagesByScale($file->getFileUri());       // scale ladder
$ratios = $mgr->getAspectRatios();                            // ['16_9' => '16:9', ...]
```

## `hook_easy_responsive_images_image_style_alter(ImageStyleInterface $entity)`

Invoked (`$module_handler->alter('easy_responsive_images_image_style', $style)`) for **every**
style as it is generated/updated on form save — use it to add effects to all generated styles.
Because it also runs on updates, check for the effect before adding it. Example (add WebP
conversion):

```php
function mymodule_easy_responsive_images_image_style_alter(\Drupal\image\ImageStyleInterface $entity): void {
  foreach ($entity->getEffects() as $effect) {
    if ($effect->getPluginId() === 'image_convert') {
      return;
    }
  }
  $entity->addImageEffect(['id' => 'image_convert', 'data' => ['extension' => 'webp']]);
}
```

Declared in `easy_responsive_images.api.php`. There is no plugin type and no Drush; this hook and
the manager service are the extension surface.
