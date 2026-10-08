<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ImageAPI Optimize WebP Responsive — agent index

Submodule of **ImageAPI Optimize WebP**. Adds `<source type="image/webp">` entries to core
Responsive Image (`<picture>`) output for image styles whose Image Optimize pipeline includes the
WebP Deriver. Requires `imageapi_optimize_webp`. No settings form, no `configure` route, no
permissions, no plugins, no Drush, no config schema.

- **The `preprocess_responsive_image` hook: how WebP sources are injected** →
  [api/mechanism.md](api/mechanism.md)

Key facts: it implements `template_preprocess_responsive_image()`; for each mapped image style whose
pipeline has a processor with plugin id `imageapi_optimize_webp`, it clones the `<source>` with the
`.webp` `srcset` and `type=image/webp`, prepends the WebP sources, and sets
`output_image_tag = FALSE`. The parent module (`imageapi_optimize_webp`) handles non-responsive
image formatters — see its docs one directory up.
