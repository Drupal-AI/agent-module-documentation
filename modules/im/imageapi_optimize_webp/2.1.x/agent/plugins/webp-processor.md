<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WebP Deriver processor: `imageapi_optimize_webp`

`Drupal\imageapi_optimize_webp\Plugin\ImageAPIOptimizeProcessor\WebP` (extends
`ConfigurableImageAPIOptimizeProcessorBase` from imageapi_optimize).

```php
@ImageAPIOptimizeProcessor(
  id = "imageapi_optimize_webp",
  label = @Translation("WebP Deriver"),
  description = @Translation("Clone image to WebP")
)
```

## What it does

`applyToImage($image_uri)`:

- Loads the image via the GD toolkit (`imageFactory->get($image_uri, 'gd')`).
- Writes a `.webp` copy next to it: `imagewebp($resource, $image_uri . '.webp', $this->configuration['quality'])`.
- Applies a one-byte fix when `filesize % 2 == 1` (works around occasional generation failures).
- Returns TRUE on success.

So for a styled derivative `…/styles/thumb/public/foo.jpg`, it produces `…/foo.jpg.webp`.

## Configuration

- `quality` — integer 1–100, **default 75** (`defaultConfiguration()`), exposed as a required
  "Image quality" number field in the processor's config form.

The processor is **configurable**: its settings are stored inside the pipeline entity's
`processors` list (each processor entry has `id`, `data` (its config, incl. `quality`), `weight`,
`uuid`).

## Requirements

- GD with WebP support (`imagewebp()` available).
- Add it to an `imageapi_optimize_pipeline` and assign that pipeline to image styles — see
  [configure/pipeline.md](../configure/pipeline.md).
