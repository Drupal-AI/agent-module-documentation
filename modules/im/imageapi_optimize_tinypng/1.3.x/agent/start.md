# Image Optimize - TinyPNG — agent index

Adds a single `tinypng` processor plugin to the ImageAPI Optimize (Image Optimize) pipeline system,
compressing JPEG/PNG derivatives via the hosted TinyPNG/Tinify service. No config page of its own
(`configure` null) — configured inside an Image Optimize pipeline. No permissions, no Drush.
Requires the `imageapi_optimize` module and the `tinify/tinify` PHP library.

- **Add and configure the TinyPNG processor (API key) on a pipeline** →
  [configure/processor.md](configure/processor.md)

Key facts:
- Plugin: `\Drupal\imageapi_optimize_tinypng\Plugin\ImageAPIOptimizeProcessor\TinyPng`
  (`@ImageAPIOptimizeProcessor(id = "tinypng")`), extends `ConfigurableImageAPIOptimizeProcessorBase`.
- Only setting: `api_key` (schema `imageapi_optimize.processor.tinypng`, default `NULL`, required on
  the form). Validated live with `\Tinify\validate()` on submit.
- `applyToImage($uri)` reads the derivative, `\Tinify\fromBuffer()->toBuffer()` sends it to TinyPNG,
  result written back over the same URI. Failures are caught and logged to the `imageapi_optimize`
  channel; returns FALSE.
- `hook_requirements` errors if `\Tinify\Tinify` is absent — `composer require drupal/imageapi_optimize_tinypng`
  pulls in `tinify/tinify`.
- Each derivative optimized = one metered TinyPNG API call (uploads the image bytes to the service).
- The API key lives in the pipeline processor config; overridable via settings.php — keep production
  keys out of committed config exports.
