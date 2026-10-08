# How WebP hooks into the image pipeline

No `*.api.php`; integration is via hooks + a route subscriber in `webp.module` / `src/`:

- **`template_preprocess_responsive_image()`** (`webp_preprocess_responsive_image()`) — for each
  `<source>` with `srcset` (or Blazy's `data-srcset`), clones it, swaps URLs to their `.webp`
  form via `Webp::getWebpSrcset()`, sets `type="image/webp"`, and prepends the WebP sources.
  Forces `output_image_tag = FALSE` so a `<picture>` with multiple sources is always emitted.
  Skips sources already in WebP.
- **`hook_entity_insert()` / `hook_entity_update()`** — `webp_flush_webp_derivatives()` deletes
  existing `.webp` derivatives for the entity's image fields so stale copies aren't served.
- **`webp.route_subscriber`** (`Routing\RouteSubscriber`) — reroutes image-style/file download
  routes to the module's `ImageStyleDownloadController` / `FileDownloadController`, which
  generate the WebP derivative on demand when the style derivative is requested.

Browser fallback is automatic: non-supporting browsers ignore the `image/webp` source and use
the original JPEG/PNG source in the same `<picture>`.
