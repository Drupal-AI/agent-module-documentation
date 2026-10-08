<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How WebP derivatives are generated and served

Three integration points make the `.webp` files usable. All are automatic once the WebP Deriver
processor is in a pipeline assigned to a style.

## 1. Pipeline wrapper (generation placement)

`hook_entity_type_alter()` swaps the `imageapi_optimize_pipeline` entity class for
`Drupal\imageapi_optimize_webp\Entity\ImageAPIOptimizeWebPPipeline`. Its `applyToImage()` runs the
normal pipeline, then copies the temporary `<temp>.webp` produced by the WebP processor to the final
`<image_uri>.webp` (using `FileExists::Rename`), so the WebP lands next to the styled derivative.

## 2. Route controller override (delivery)

`RouteSubscriber` points `image.style_public` and `image.style_private` at
`Drupal\imageapi_optimize_webp\Controller\ImageStyleDownloadController::deliver()`:

- If the requested `file` ends in `.webp`, it derives the **source** image path (strips the
  trailing `.webp`), lets the parent controller generate the normal derivative, then — if the
  `<derivative>.webp` file exists — returns a `BinaryFileResponse` with `Content-Type: image/webp`
  for the `.webp` file instead.
- Non-`.webp` requests fall through to the core controller unchanged.

So a browser can request `…/styles/thumb/public/foo.jpg.webp` and receive the WebP, with the source
derivative generated on demand.

## 3. Flush cleanup

`hook_image_style_flush()` deletes the matching `<path>.webp` whenever the normal derivative for a
non-`.webp` path is flushed, so stale WebP files don't linger.

## Consuming the WebP

- This base module produces the `.webp` files and serves them when requested by that URL; your
  markup/theme (or a `<picture>`/`srcset`) must reference the `.webp` URL.
- For core **responsive image** fields, enable the `imageapi_optimize_webp_responsive` submodule,
  which injects `<source type="image/webp">` automatically.
