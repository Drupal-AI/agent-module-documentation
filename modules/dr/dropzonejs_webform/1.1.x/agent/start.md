<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform DropzoneJS (webform_dropzonejs) — agent index

Adds a **DropzoneJS** drag-and-drop file-upload element to **Webform**. It contributes one Webform
element plugin (`webform_dropzonejs`, listed in the "File upload elements" category) backed by a
render element (`#type => 'webform_dropzonejs'`) that extends the `dropzonejs` core element and the
`WebformManagedFileBase` webform element. The browser posts files to the **`dropzonejs` core** upload
endpoint (route `dropzonejs.upload`) as temporary uploads; on webform submission the element's
`valueCallback` reads the `;`-separated `uploaded_files` hidden field, renames each temporary file,
and the plugin's `validateManagedFile` copies the bytes into the element's `#upload_location` as a
permanent `file` entity and sets the resulting fids as the submission value.

The module ships no routes, services, permissions, drush commands, or config schema of its own — it
reuses the `dropzonejs` core route (`dropzonejs.upload`) and permission (`dropzone upload files`),
and stores its per-element settings inside the host webform's YAML like any other webform element.
A small JS integration (`webform_dropzonejs/integration`) re-attaches already-uploaded files to the
Dropzone instance, wires up remove links (posting `deleted_dropzone_files[]`), and links previews to
the stored file. Note the naming: the **project** is `dropzonejs_webform`; the **module machine
name it ships is `webform_dropzonejs`** (that is the id used everywhere below).

- Depends on: `webform:webform`, `dropzonejs:dropzonejs` (both hard dependencies). The Dropzone JS
  library itself is supplied by `dropzonejs` core.
- Core: `^9 || ^10 || ^11`. Package: `Webform`.
- No settings page / `configure` route. No permissions, no drush, no config schema, no plugin types
  of its own.
- Provides one **WebformElement plugin** and one **render (FormElement)** element, both id
  `webform_dropzonejs`, plus a theme hook and a JS/CSS library.

## What you'd do → where

- **Add / configure the DropzoneJS element on a webform; the plugin + render element, admin form,
  allowed-extensions/multiple/upload-location settings** → [plugins/webform-element.md](plugins/webform-element.md)
- **Understand the upload → temp-file → permanent-file flow, the reused `dropzonejs.upload`
  endpoint, `valueCallback`, `validateManagedFile`, drupalSettings, the theme hook and the delete
  path** → [api/upload-flow.md](api/upload-flow.md)

## Key facts (real machine names)

- WebformElement plugin: `webform_dropzonejs` (`Plugin\WebformElement\WebformDropzonejs`, extends
  `Drupal\webform\Plugin\WebformElement\WebformManagedFileBase`; `category = "File upload elements"`,
  `states_wrapper = TRUE`).
- Render element: `webform_dropzonejs` (`Element\WebformDropzonejs`, `@FormElement`, extends
  `Drupal\dropzonejs\Element\DropzoneJs`).
- Element methods: `getInfo`, `preRenderDropzoneJs`, `processDropzoneJs`, `validateWebformDropzonejs`
  (required-check), `valueCallback`. Plugin methods: `form` (admin), `validateManagedFile` (save),
  `getFileExtensions`.
- Theme hook: `webform_element_dropzonejs` (template `templates/webform-element-dropzonejs.html.twig`);
  preprocess `template_preprocess_webform_element_dropzonejs` → delegates to webform's
  `template_preprocess_webform_element_managed_file`. (`getInfo` sets `#theme => 'dropzonejs'` for the
  input widget itself.)
- Hook: `hook_theme` (`webform_dropzonejs_theme`).
- Library: `webform_dropzonejs/integration` (`js/webform_dropzonejs.integration.js`,
  `css/webform_dropzonejs.integration.css`; deps `core/once`, `core/drupal`, `core/drupalSettings`,
  `dropzonejs/dropzonejs`, `dropzonejs/integration`).
- Reused from `dropzonejs` core: route `dropzonejs.upload`, permission `dropzone upload files`,
  config `dropzonejs.settings.tmp_upload_scheme`.
- Config read: `webform.settings` → `file.default_managed_file_extensions` (default extensions when
  the element sets none).
- Client/JS contract: `drupalSettings.webformDropzoneJs[elementId].files` and `.file_directory`;
  POST fields `uploaded_files` (`;`-separated temp filenames) and `deleted_dropzone_files[]` (fids).
