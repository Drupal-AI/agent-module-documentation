<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Uploader by Uppy (file_uploader_uppy) — agent index

Binds the **Uppy** JavaScript uploader to the **File Uploader** module (`drupal/file_uploader`).
It ships a single **field widget**, `file_uploader_uppy`, that you select on a `file`/`image`
field in *Manage form display*; the widget renders Uppy's **Dashboard** (drag-and-drop, previews,
progress, an optional inline **Image Editor** for crop/rotate/zoom) in place of the stock file
input. Files are sent client-side by Uppy's **XHR** plugin to the endpoint the parent module
provides — the route `file_uploader.xhr` (`/file-uploader/upload`) in `drupal/file_uploader` — which
runs `file_save_upload()` with the field's own `#upload_validators` and returns the saved file id;
the widget's JS collects those ids into a hidden `[fids]` input that becomes the field value on
form submit. This module itself contributes **no route, controller, service, or permission** — it is
purely the client-side front end plus config for it.

The widget also generates per-language **Uppy locale** libraries: `hook_library_info_build()` walks
`UppyLocaleMapper::getMap()` and, for the current interface language, attaches an external locale
JS file from Transloadit's CDN (`https://releases.transloadit.com/uppy/locales/v3.2.1/<locale>.min.js`).

- Depends on: `file_uploader:file_uploader` (supplies the render element, the base widget class
  `FileUploaderWidgetBase`, and the server-side upload route/controller). Composer: `drupal/file_uploader:^1.0.3`.
- Core: `^9 || ^10 || ^11`. Package: none declared. Version **1.1.0**.
- No settings page / `configure` route — **all configuration is per field-widget** (form display).
  Provides config schema, **no permissions, no drush, no services, no routes, no plugin types**.
- Client library dependency: bundles Uppy (`@uppy/core`, `dashboard`, `xhr-upload`, `image-editor`)
  webpacked into `public/js/widget.js`; loads locale strings from an external CDN per language.

## What you'd do → where

- **Turn on the Uppy widget for a file/image field and tune the Dashboard / Image Editor / theme** →
  [configure/widget-settings.md](configure/widget-settings.md)
- **Add a language to the Uppy locale map, understand the locale mapper, the theme hook and the
  generated locale libraries** → [api/locale-and-hooks.md](api/locale-and-hooks.md)

## Key facts (real machine names)

- Field widget: `file_uploader_uppy` (class `…Plugin\Field\FieldWidget\FileUploaderUppyWidget`,
  extends `Drupal\file_uploader\…\FileUploaderWidgetBase` → `FileWidget`). `field_types = {file, image}`,
  `multiple_values = TRUE`.
- Server-side upload endpoint is **not in this module**: route `file_uploader.xhr`
  (`/file-uploader/upload`, `_csrf_token: TRUE`, `_custom_access`), controller
  `Drupal\file_uploader\Controller\FileUploaderController::upload` (parent `drupal/file_uploader`).
- Config schema: `field.widget.settings.file_uploader_uppy` (keys under `options.instance`,
  `options.plugin`, `options.uploader`).
- Hooks implemented: `hook_theme` (theme `file_uploader_uppy`, template
  `templates/file-uploader-uppy.html.twig`), `hook_library_info_build` (generates `locale.<langcode>`).
- Alter hook provided: `hook_file_uploader_uppy_locale(array &$map)` — see `file_uploader_uppy.api.php`.
- Libraries: `file_uploader_uppy/global` (`public/js/global.js`),
  `file_uploader_uppy/widget` (`public/js/widget.js` + `public/css/widget.css`; depends on
  `file_uploader/widget` and `…/global`), and generated `file_uploader_uppy/locale.<langcode>`.
- Utility class: `Drupal\file_uploader_uppy\UppyLocaleMapper` (`const URL`, `const MAP`,
  static `getMap()`, `getLocale(?$language)`, `getUrl(?$language)`).
- Widget setting keys: `options.instance.autoProceed`; `options.plugin.{showProgressDetails,
  hideCancelButton, hideProgressAfterFinish, singleFileFullScreen, disableStatusBar,
  disableInformer, disableThumbnailGenerator, waitForThumbnailsBeforeUpload, thumbnailWidth,
  thumbnailHeight, enableImageEditor, autoOpenFileEditor, imageEditor.actions, theme}`;
  `options.uploader.method` (only value `xhr`, labelled "Drupal").
- JS entry point: `window.DrupalFileUploader.file_uploader_uppy` (registered by `widget.js`);
  `window.Uppy = { locales: {} }` bootstrap in `global.js`.
