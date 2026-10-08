<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Flush Single Image Styles regenerates or deletes the image-style derivatives of **one** source image, instead of the all-or-nothing choice core offers between flushing an entire image style and flushing nothing.

---

Drupal generates a derivative per image style on first request and keeps it until that style is flushed. When a single file is replaced in place, a crop is corrected, or one derivative was generated wrongly, only that file's derivatives are stale — yet core's only remedy is "flush this image style", which discards every derivative for every image using it and forces the whole site to regenerate them. On an image-heavy site that is an expensive way to fix one photo. This module targets the file. Its `flush_single_image` service discovers which styles currently have a cached derivative for a given source URI (`getStylePaths()`, including sibling `.webp` variants) and either unlinks each derivative so core lazily rebuilds it, or regenerates it immediately (`flush()` / `flushStyle()` with `ACTION_UNLINK` / `ACTION_REGENERATE`). The same service is reachable from an interactive admin form at `/admin/config/media/image-styles/flush-single` (with a "Check Styles" preview), a `flush_single_image` (alias `fsi`) Drush command, a configurable media bulk **action** (`flush_single_image_action`), a `flush_single_image` **migrate** process plugin for import pipelines, and a widget added to media edit forms. Access is split: `administer flush_single_image` (restricted) for the path-driven admin surfaces, and `flush media image` (plus entity update access) for editors flushing a media image's own derivatives.

---

- Regenerate every derivative for one replaced image.
- Delete a single wrongly generated thumbnail.
- Avoid flushing an entire image style for one file.
- Let editors refresh an image they just replaced.
- Flush image derivatives as a bulk action on media.
- Script derivative flushing from Drush in a deploy.
- Preview which styles are cached before flushing (Check Styles).
- Correct a crop without a site-wide image-style flush.
- Reduce load caused by mass derivative regeneration.
- Fix an image that looks stale after an in-place replacement.
- Clear derivatives after an editorial image edit.
- Flush a logo's derivatives after a rebrand.
- Rebuild a broken derivative immediately (Regenerate).
- Avoid a full image-style rebuild for one file.
- Support a daily third-party import that reuses filenames.
- Flush derivatives during a data migration (migrate plugin).
- Flush a media image's derivatives from its edit form.
- Refresh a WebP derivative selectively.
- Give editors a self-service image-refresh tool.
- Call the flush service from custom code.
- Choose which media types the module treats as images.
- Reduce support tickets about stale cached images.
