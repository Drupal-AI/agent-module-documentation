<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Document Loader: Media Library (document_loader_media) — agent index

A reusable **media-library opener** service so the core media library can be used inside Document
Loader modal forms without an entity-reference field. Package `Web services`. Version 2.0.5. Core
`^10.4 || ^11`. GPL-2.0-or-later. Depends on `document_loader` + core `media_library`. No
permissions of its own, no routes, no Drush, no config.

## What it provides

- **One service** (`document_loader_media.services.yml`):
  `document_loader_media.media_library.opener` →
  `src/MediaLibrary/DocumentLoaderMediaLibraryOpener.php`, tagged `media_library.opener`.
  Implements core `MediaLibraryOpenerInterface`.
  - `checkAccess(state, account)` → `AccessResult::allowedIfHasPermission($account, 'access content')`
    (+ cacheable dependency on the state).
  - `getSelectionResponse(state, selected_ids)` → reads opener parameters `field_widget_id`
    (default `dl_file_input`) and `dialog_selector` (default `#drupal-modal`); returns an
    `AjaxResponse` that: closes the media-library dialog (`CloseDialogCommand($dialog_selector)`);
    sets the host hidden field value to the comma-joined IDs
    (`InvokeCommand("[data-media-library-widget-value=…]", 'val', [$ids])`); triggers the host
    update button (`InvokeCommand("[data-media-library-widget-update=…]", 'trigger', ['mousedown'])`).

## Usage by host forms

A consumer builds `MediaLibraryState::create('document_loader_media.media_library.opener',
$allowed_types, …, ['field_widget_id' => …, 'dialog_selector' => …])`. Primary in-tree consumer:
the MDXEditor dialog (`document_loader_mdx`). See that submodule's `config/dialog.md`.
