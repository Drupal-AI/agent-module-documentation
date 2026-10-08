<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Conversion paths

Three independent entry points plus a field-config alter. All routing lives under
`/admin/config/media/`, but note the differing permissions.

## 1. Site-wide batch

- Route `image_webp_converter.batch_form` → `/admin/config/media/image-webp-converter`,
  permission `convert images to webp`. Form `ImageWebpBatchForm` → `ImageBatchConverter::startBatch()`.
- Loads **every** managed file with `filemime` in `image/jpeg`, `image/png` (`accessCheck(FALSE)`),
  chunks of 30, `batch_set()`.
- Per file (`processImage()`): `WebPConvert::convert($realpath, $webpRealpath, $options)` where the webp
  URI is `preg_replace('/\.(jpg|jpeg|png)$/i', '.webp', $uri)`. On success it **repoints the same file
  entity** (`setFileUri($webp_uri)`, `filename` = basename, DB update `filemime` = `image/webp`).
- `updateContentReferences()` walks `file.usage` records: for `editor` usage it regex-replaces the old
  file URL with the new one in `text_with_summary` bodies; for image fields it re-sets the field item.
  `updateFileMetadata()` also renames any `media` whose `field_media_image` points at the file.
- Destructive and irreversible: the original bytes are overwritten in place (the source file path and the
  webp path are both derived from the same URI stem).

## 2. Per-node (hook-driven, in `.module`)

- Gated by config `per_node_conversion`. `hook_form_alter` adds a `webp_conversion` checkbox to forms
  matching `node_*_form` / `node_*_edit_form`.
- `hook_node_presave()` stores the checkbox state in key-value `image_webp_converter`.
- `hook_entity_presave()` (fires for **any** entity, filters to `node`) checks
  `\Drupal::request()->get('webp_conversion')` directly from the request — **not** the form value and
  **not** gated on `per_node_conversion` — then converts, for that node:
  - **image fields** — converts the file, creates a *new* File entity for the webp, deletes the old file,
    re-points the field item (preserving `alt`).
  - **text/text_long/text_with_summary** — regex-matches `<img src>`, and for paths beginning
    `/sites/default/files/` maps to `public://…`, converts, updates the existing file entity + `filemime`,
    and rewrites the body HTML.
  - **entity_reference → media** — converts the referenced media's image field and renames the media.
- Shared helper `image_webp_converter_convert_to_webp($uri)` builds the destination as
  `$scheme://{basename(dirname(uri))}/{filename}.webp` — note it flattens to a single directory segment
  (`basename($directory)`), so deeply nested source paths can land in an unexpected directory.

## 3. Upload-and-download tool

- Route `image_webp_converter.form` → `/admin/config/media/image-webp-uploader`,
  **permission `access content`**. Form `UploadWebpConverter`.
- `managed_file` restricted to `jpg jpeg png`, uploaded to `public://converted_images/`, marked temporary,
  converted with library defaults, and a `<a href=… download>` link to the public webp URL is shown.

## 4. Field-extension alter

- `hook_form_field_config_edit_form_alter` / `_submit` append `webp` to a field's
  `settings.file_extensions` so uploaded/converted `.webp` files pass field validation. Applies to any
  field-config edit form exposing `file_extensions`.
