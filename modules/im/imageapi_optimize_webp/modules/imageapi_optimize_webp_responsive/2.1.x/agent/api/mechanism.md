<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mechanism: WebP sources in responsive images

Whole submodule is one procedural hook in `imageapi_optimize_webp_responsive.module`:
`template_preprocess_responsive_image(&$variables)` (plus a `hook_help`).

## What it does

1. If there are `$variables['sources']`, load the `ResponsiveImageStyle` for
   `$variables['responsive_image_style_id']` and all its mapped image styles
   (`ImageStyle::loadMultiple($entity->getImageStyleIds())`).
2. For each image style that `hasPipeline()`, check its pipeline's processors for one whose
   `getPluginId() == "imageapi_optimize_webp"` (cached in `$pipeline_webp_map`). Only styles whose
   pipeline includes the **WebP Deriver** qualify.
3. For qualifying styles, build a map from the styled derivative's relative URL to that URL + `.webp`
   (`$image_style_map`).
4. For each existing `<source>` (`srcset` or `data-srcset`), `strtr()` the srcset through that map; if
   anything changed, **clone** the source, set its `type` to `image/webp`, and collect it.
5. Prepend the cloned WebP sources to `$variables['sources']` and set
   `$variables['output_image_tag'] = FALSE` so the `<picture>` element (with WebP first) is used.

## Consequences / requirements

- WebP `<source>`s only appear for image styles whose Image Optimize **pipeline contains the WebP
  Deriver processor** (`imageapi_optimize_webp`). If none qualify, output is unchanged.
- No configuration: enable the submodule, ensure the responsive image style's image styles use a
  WebP pipeline, and the sources appear.
- The actual `.webp` files are generated/served by the parent `imageapi_optimize_webp` module (its
  route controller and pipeline wrapper).
