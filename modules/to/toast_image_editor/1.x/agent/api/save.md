<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Save pipeline — how an edited image is written back

Two entry points feed the same `ImageProcessorService::saveEditedImage()`. Both require the
`use toast image editor` permission **and** `update` access on the specific media entity.

## Where the editor is injected

`MediaFormAlterService::alterMediaForm()` (called from `hook_form_media_form_alter`) runs only when
`ImageProcessorService::canEditMedia($media)` is TRUE (media source plugin id is `image`, source
field present and non-empty, file exists and is readable) **and** the current user has
`use toast image editor`. It adds:

- a `toast_image_editor` fieldset with an `#id="toast-image-editor"` placeholder div,
- a hidden field **`toast_image_editor_data`** (`#type => 'hidden'`),
- library `toast_image_editor/toast-image-editor-integration`,
- `drupalSettings.toastImageEditor` = `{ width, height, theme, mediaId, saveUrl, enabledTools,
  imageUrl }`. `saveUrl` = `Url::fromRoute('toast_image_editor.media_save', ['media' => id])`;
  `imageUrl` = `ImageProcessorService::getImageUrl()` (relative file URL + `?v=<changedTime>`
  cache-buster, made absolute from the current request host).

The JS (`js/toast-image-editor.js`, vendored Toast UI) instantiates the editor from `imageUrl`,
captures the edit as a base64 **data URL**, and delivers it via one of the two paths below.

## Path A — media form submit (presave hook)

Submitting the media edit form carries the data URL in the hidden `toast_image_editor_data` field.
`MediaPresaveService::processMediaPresave()` (from `hook_media_presave`):

1. Returns early unless `canEditMedia($entity)` and a current request exist.
2. Reads `toast_image_editor_data` from `$request->request` (also tolerates
   `toast_image_editor_data[0][value]` and scans all params whose key contains
   `toast_image_editor_data`).
3. Returns early unless the value **starts with `data:image/`**.
4. Re-checks `use toast image editor` permission, then `$entity->access('update', $currentUser)` —
   logs a warning and returns FALSE if either fails.
5. Calls `saveEditedImage()`, surfacing the result via `messenger`.

This path rides the media form, which carries Drupal's form CSRF token.

## Path B — the JSON save route

`ImageEditorController::save(Request $request, MediaInterface $media)` at
`POST /media/{media}/save-image` (`toast_image_editor.media_save`):

1. Route requirements already enforce `_permission: 'use toast image editor'` and
   `_entity_access: 'media.update'`; `media` is a bound `entity:media` (numeric id only).
2. Controller re-checks `currentUser()->hasPermission('use toast image editor')` **and**
   `$media->access('update')` → 403 JSON otherwise.
3. Checks `canEditMedia($media)` → 400 if the media type cannot be edited.
4. Reads `imageData` from `$request->request` → 400 if empty.
5. Calls `saveEditedImage($media, $imageData)`; returns JSON `{success, message, redirect}` (redirect =
   `$media->toUrl()`), or 500 on failure.

## The write itself — `ImageProcessorService::saveEditedImage()`

- Resolves the media type → source field → **existing** `FileInterface` from the media's source field.
  The write target is **`$fileEntity->getFileUri()`** — the media's own current source file, never a
  request-supplied path or fid.
- Strips a leading `data:image/\w+;base64,` prefix, estimates the decoded size and **aborts if it
  would exceed 50% of PHP `memory_limit`** (`convertToBytes()` parses `K`/`M`/`G`).
- `base64_decode($base64Data, TRUE)` (strict); empty/invalid → error return.
- `setNewRevision()` + revision log "Image edited with Toast Image Editor".
- `fileSystem->saveData($decodedData, $uri, FileExists::Replace)` overwrites the file in place; then
  `$fileEntity->setSize(strlen($decodedData))`, `setChangedTime(requestTime)`, `save()`.
- `clearImageStyleCache($uri)` flushes every image style derivative for that URI.
- The media entity itself is **not** saved here (avoids recursion) — the caller (form/presave) saves
  it, which is what commits the new revision.

Because the target URI is the media's own source file, saving cannot change the file's extension or
location: an image media stays the same `.png`/`.jpg` file. The edit is preserved as a prior revision.
