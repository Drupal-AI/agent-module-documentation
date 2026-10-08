<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PDF thumbnails: the plugin, how it fires, and the settings that affect it

## The plugin

`Drupal\media_thumbnails_pdf\Plugin\MediaThumbnail\MediaThumbnailPDF`

```php
/**
 * @MediaThumbnail(
 *   id = "media_thumbnail_pdf",
 *   label = @Translation("Media Thumbnail PDF"),
 *   mime = { "application/pdf" }
 * )
 */
```

Extends the parent `media_thumbnails` module's `MediaThumbnailBase`. It has no settings form and
no annotation config — the id and the `application/pdf` mime are the whole declaration.

## How a thumbnail gets generated

1. On media save, `media_thumbnails`' `hook_media_presave()` calls
   `MediaThumbnailManager::createThumbnail($media)`.
2. The manager looks up the plugin for the **source file's mime type**; for `application/pdf`
   that is `media_thumbnail_pdf`.
3. The manager instantiates the plugin with the global settings and calls
   `createThumbnail($sourceUri)`, which:
   - copies the file to a temp path (Imagick can't read stream wrappers),
   - opens page `[0]` with Imagick (`COLORSPACE_SRGB`),
   - flattens transparency onto a **white** background,
   - scales down to the configured **width** if the image is wider,
   - converts to **JPG** and writes a **managed file** at `<source-uri>.jpg`.
4. That file becomes the media entity's `thumbnail`.

Updating a media entity regenerates the thumbnail; deleting it removes the generated file
(handled by the parent framework, which won't delete generic/shared thumbnails).

## Requirements

- The **`imagick`** PHP extension. `media_thumbnails_pdf_requirements()` (hook_requirements)
  reports a `REQUIREMENT_ERROR` at install/status if `imagick` is not loaded, and
  `createThumbnail()` logs a warning and returns NULL.
- A **Ghostscript** delegate for Imagick, so Imagick can rasterize PDF pages.

## Settings that affect it (owned by the parent `media_thumbnails`)

This module adds **no** configuration. The behavior is tuned by `media_thumbnails.settings`
(config route `media_thumbnails.settings`, class MediaThumbnails' settings form):

| Key | Default | Effect on the PDF plugin |
|---|---|---|
| `width` | `500` | Max thumbnail width; the rendered page is scaled down to this if wider. |
| `bgcolor_active` / `bgcolor_value` | `false` / `#eeeeee` | Global background handling in the framework (the PDF plugin itself flattens onto white). |
| `no_thumbnail_update` | `false` | If TRUE, don't recreate the thumbnail on media update. |
| `allow_thumbnail_edit` | `false` | Whether thumbnails may be edited. |

Read/set the width (scriptable):

```bash
drush cget media_thumbnails.settings width
drush cset media_thumbnails.settings width 250 -y
```

```php
// $config['width'] is passed to the plugin as $this->configuration['width'] (falls back to 500).
\Drupal::configFactory()->getEditable('media_thumbnails.settings')->set('width', 250)->save();
```

## Generate for an existing PDF (scriptable)

Saving a PDF media entity triggers generation; to force a fresh thumbnail, re-save the media or
use the manager:

```php
\Drupal::service('plugin.manager.media_thumbnail')->updateThumbnail($media); // delete + recreate
```
