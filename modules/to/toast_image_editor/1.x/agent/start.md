<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Toast Image Editor (toast_image_editor) — agent index

Embeds the **Toast UI Image Editor** into Drupal's **media edit form** so editors can crop / rotate /
flip / draw / annotate / filter an **image** media item in-browser and save it back as a **new media
revision**. Package `Media`. Depends on core **media, file, user, system**. Core
`^10.3 || ^11.0`, PHP 8.1. License GPL-2.0-or-later. Version 1.x (installed 1.0.1). Ships by DXPR;
all editor JS (Toast UI 3.15.3, fabric.js, tui-color-picker, file-saver) is **vendored** under
`assets/` — no CDN, no external service.

- **Save pipeline (route, controller, presave hook, image processor)** → [api/save.md](api/save.md)
- **Settings form + config object/schema** → [config/settings.md](config/settings.md)

## What it provides (from source)

- **No entities, no plugin types, no Drush.** Two permissions, one config object, one settings form,
  one JSON route, three services, three hook implementations.
- **Permissions** (`toast_image_editor.permissions.yml`): `use toast image editor` (gates editing) and
  `administer toast image editor` (`restrict access: true`; gates the settings form).
- **Routes** (`toast_image_editor.routing.yml`):
  - `toast_image_editor.media_save` — `POST /media/{media}/save-image` →
    `ImageEditorController::save()`. Requirements: `_permission: 'use toast image editor'`,
    `_entity_access: 'media.update'`, `_method: POST`, `media: \d+` (bound `entity:media`).
  - `toast_image_editor.settings` — `/admin/config/media/toast-image-editor` → `SettingsForm`,
    `_permission: 'administer toast image editor'`. Menu link under Configuration → Media.
- **Services** (`toast_image_editor.services.yml`):
  - `toast_image_editor.image_processor` → `Service\ImageProcessorService` — decodes the base64 data
    URL and overwrites the media's **own source file** (`FileExists::Replace`), sets new revision,
    flushes image styles. Also `canEditMedia()` / `getImageUrl()`.
  - `toast_image_editor.media_form_alter` → `Service\MediaFormAlterService` — adds the editor
    fieldset + hidden `toast_image_editor_data` field and `drupalSettings.toastImageEditor` to the
    media form.
  - `toast_image_editor.media_presave` → `Service\MediaPresaveService` — on `hook_media_presave`,
    reads `toast_image_editor_data` from the request and calls the image processor.
  - `logger.channel.toast_image_editor`.
- **Hooks** (`toast_image_editor.module`): `hook_help()`, `hook_form_media_form_alter()` (delegates to
  the form-alter service), `hook_media_presave()` (delegates to the presave service).
- **Config**: object `toast_image_editor.settings` (`enabled_tools[]`, `editor_width`,
  `editor_height`, `theme`) with `config/schema/` and `config/install/` defaults. Details in
  [config/settings.md](config/settings.md).

## Mechanism in one line

Client captures the edited image as a `data:image/…;base64,…` string → sent either in the media form's
hidden `toast_image_editor_data` field (presave hook) or POSTed to `…/save-image` (JSON route) →
`ImageProcessorService::saveEditedImage()` re-checks permission + `media.update`, decodes, and
`fileSystem->saveData()` overwrites the media's existing source file URI, creating a new revision.
