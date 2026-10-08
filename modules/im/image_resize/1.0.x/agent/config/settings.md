<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & config object

## Install & enable

```bash
composer require drupal/image_resize
drush en image_resize -y
```

Hard deps are core `file` and `image` only. For the `quality` override and WebP/AVIF conversion,
also install and set the **ImageMagick** toolkit (`drupal/imagemagick`) as the site's default image
toolkit; without it the quality field is disabled and the toolkit's default quality is used.

## Route & access

- Route `image_resize.settings` → **`/admin/config/media/image-resizer`**
  (`image_resize.routing.yml`), `_form: Form\ImageResizerSettingsForm`,
  requirement **`_permission: 'administer site configuration'`**.
- Menu link `image_resize.settings` under `system.admin_config_media`
  (*Configuration → Media*), from `image_resize.links.menu.yml`.

## Config object `image_resize.settings`

Written by `ImageResizerSettingsForm::submitForm()`; read by the queue worker and the event
subscriber. Schema `config/schema/image_resize.schema.yml`, install defaults
`config/install/image_resize.settings.yml`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `mimetypes` | sequence(string) | `[]` | Image MIME types to process (e.g. `image/jpeg`). Only files of these types are enqueued/resized. |
| `resize_type` | string | `max` | `max` (image must fit **inside** width×height), `min` (image must be **at least** width×height), or empty = do not resize. |
| `width` | integer | `null` | Bounding-box width in px. |
| `height` | integer | `null` | Bounding-box height in px. |
| `min_filesize` | string | `null` | Only enqueue/process files larger than this (e.g. `512`, `80 KB`, `50 MB`; parsed with `Bytes::toNumber`). Validated by `FileItem::validateMaxFilesize`. |
| `quality` | integer | `80` | Encode quality override — **ImageMagick toolkit only** (applied via the event subscriber). Field disabled for other toolkits. |
| `extension` | string | `''` | Enforce/convert to this image type (any extension the default toolkit's `getSupportedExtensions()` reports, e.g. `webp`, `avif`). Empty = keep existing type. |
| `size_threshold` | integer | `50` | Pixel slack: images are only resized when they exceed the bounding box by more than this. (Used at the SizeCalculator/worker layer to avoid resizing near-limit images.) |

Note: an image is *converted* if either a resize is needed **or** `extension` differs from the
file's current extension (see [../queue/worker.md](../queue/worker.md)).

## Form behaviour (`ImageResizerSettingsForm`)

- **Selection fieldset** — a `tableselect` of image MIME types built from an
  `entityQueryAggregate('file')` grouped by `filemime` (count + summed size via `ByteSizeMarkup`).
  When `min_filesize` is set, extra columns show the count/size of files above that size.
- **Resize fieldset** — `resize_type` select (min/max/none), `width`, `height`, `size_threshold`,
  `extension` select (populated from the default toolkit's supported extensions), and `quality`
  (disabled unless the default toolkit is `ImagemagickToolkit`).
- **Queue fieldset** (shown once `mimetypes` is non-empty) — displays
  `queue->numberOfItems()` for queue `image_resize` and a **"Requeue existing images"** submit
  (`::requeueSubmit`).

## Requeue batch

`requeueSubmit()` starts a Batch (`BatchBuilder`, op `requeueBatch`, finish `finishRequeueBatch`).
`requeueBatch()` runs an `entityQuery('file')` filtered by `filemime IN mimetypes` (and
`filesize > min_filesize` when set), sorted by size desc, and pushes ids onto queue `image_resize`
in pages of 100. Saving settings does **not** re-process existing files — requeue does. The queue
is then drained by cron or `drush queue:run image_resize`.
