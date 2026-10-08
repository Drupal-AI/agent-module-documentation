<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The GD processor plugin

`src/Plugin/ImageAPIOptimizeProcessor/GD.php` — extends
`ConfigurableImageAPIOptimizeProcessorBase` (from the parent `imageapi_optimize` module).

```
@ImageAPIOptimizeProcessor(
  id = "imageapi_optimize_gd",
  label = "GD",
  description = "Adjust quality of JPEG and WebP Images with GD."
)
```

This module does **not** define a new plugin *type*; it implements the
`ImageAPIOptimizeProcessor` type that `imageapi_optimize` provides.

## defaultConfiguration()
```php
['quality' => 75, 'file_types' => ['image/jpeg']]
```

## Config form (buildConfigurationForm)
- `quality` — number, required, min 1, max 100.
- `file_types` — checkboxes, required, options `['image/jpeg' => 'JPEG', 'image/webp' => 'WebP']`.

`submitConfigurationForm()` stores `quality` and `array_filter(file_types)` (drops unchecked).

## applyToImage($image_uri) — what it does per derivative
1. Bail out (return FALSE) unless `function_exists('imagegd2')` — logs a notice if GD is absent.
2. Bail out unless the file's MIME (`getMimeType($image_uri)`) is in `configuration['file_types']`.
3. Load the image via `\Drupal::service('image.factory')->get($image_uri, 'gd')`; return FALSE if not valid.
4. Pick the PHP save function from the toolkit type:
   `'image' . image_type_to_extension($type, FALSE)` → `imagejpeg` or `imagewebp`.
5. Resolve the real path with `file_system->realpath()` and call
   `$function($gdImage, $destination, $this->configuration['quality'])`, overwriting the derivative in place.

Effect: the derivative is re-encoded at the given quality. Non-JPEG/WebP files are untouched.
Only image-style **derivatives** are processed (the pipeline runs during derivative creation),
never the original uploaded file.

To implement your own processor, see the parent module's `ImageAPIOptimizeProcessorInterface` /
`ConfigurableImageAPIOptimizeProcessorBase`; this class is a minimal, faithful example.
