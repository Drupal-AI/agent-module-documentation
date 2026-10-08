<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, controllers, and the media-library opener

Defined in `ckeditor_media_gallery.routing.yml` and `ckeditor_media_gallery.services.yml`. Both
routes are keyed on a `{filter_format}` config entity and gated by that format's `use` access.

## `ckeditor_media_gallery.dialog`

- Path: `/ckeditor-media-gallery/dialog/{filter_format}` — `_form:
  \Drupal\ckeditor_media_gallery\Form\GalleryDialogForm`.
- Access: `_entity_access: 'filter_format.use'`.
- Purpose: opened from the gallery widget toolbar. Reads current UUIDs and caption from the
  `uuids` / `caption` query params, renders a `#tabledrag` table (reorder + per-row "Remove"
  checkbox) plus a "Gallery heading" textfield (maxlength 255).
- Per row it calls `entityRepository->loadEntityByUuid('media', $uuid)` and **skips any media the
  user cannot `view`** (`!$media || !$media->access('view')`).
- Save is AJAX-only (`submitDialog`): reorders by weight, drops removed rows, and returns the new
  comma-joined UUID list + trimmed caption via `EditorDialogSave` + `CloseModalDialogCommand`.
  Being a standard Drupal `FormBase`, it carries a CSRF token automatically.

## `ckeditor_media_gallery.preview`

- Path: `/ckeditor-media-gallery/preview/{filter_format}`, **GET only** —
  `Controller/GalleryPreviewController::preview`.
- Access: `_entity_access: 'filter_format.use'` **AND** `_custom_access:
  …::formatUsesGalleryFilter` (checks the format has the gallery filter and it is enabled;
  adds the format as a cacheable dependency).
- Purpose: returns the server-rendered gallery fragment shown inside the CKEditor widget so the
  preview matches the front end. Reads `uuids`, `type`, `caption` from the query, pulls the
  format's gallery-filter `settings`, and calls `GalleryBuilder::build()`. Empty input returns an
  "Empty gallery" `<p>`. `#attached` is stripped (the editor loads its own styles); output via
  `renderer->renderInIsolation()`.
- Because it delegates to `GalleryBuilder`, **every media item is re-checked with
  `access('view')`** — the caller only ever sees media it is allowed to view.

## `CKEditorMediaGalleryOpener` (service `ckeditor_media_gallery.opener.gallery`)

- Tagged `media_library.opener`; implements `MediaLibraryOpenerInterface`. Unlike core's editor
  opener it returns **all** selected items so the plugin can build a multi-image gallery.
- `checkAccess(MediaLibraryState, account)`: loads the `filter_format_id` from the opener
  parameters; forbidden if the format is missing; otherwise `filter_format->access('use')`
  **and** the gallery filter present + enabled.
- `getSelectionResponse()`: loads each selected media id one-by-one to **preserve selection
  order**, maps to UUIDs, returns them via `EditorDialogSave(['uuids' => …])`. The opener is
  invoked through core Media Library, whose `MediaLibraryState` is hash-signed, so the request is
  tamper-checked by core before this code runs.

## Security-relevant summary (for agents)

Access is enforced consistently: routes require `filter_format.use`; the opener additionally
verifies the filter is enabled; the dialog form and `GalleryBuilder` re-check `access('view')` on
every media entity. The preview route is read-only (GET) and returns only media the caller may
view. No upload controller, no request-supplied filesystem path, no server-side fetch of a
request-supplied URL.
