<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Document Preview (document_preview) — agent index

Renders office/PDF documents inline in the browser by delegating to the **Google Docs viewer**.
It ships **one core-file-field formatter** with two view types (inline iframe or AJAX modal) plus
the route/controller that backs the modal. Package `Media`. Depends only on core **`field`** and
**`file`**. Core requirement `^11.1 || ^12`. License GPL-2.0-or-later. Version 2.0.0 (dir 2.0.x).
No settings form, no permissions, no Drush, no services, no config, no submodules.

- **The formatter, its two view types, the template, and how to attach a preview to content** →
  [fields/formatter.md](fields/formatter.md)
- **The modal route + controller, the library, and the `hook_theme`/preprocess hooks** →
  [api/modal-route.md](api/modal-route.md)

## What it actually is (from source)

- **Formatter** `DocumentPreviewFieldFormatter` (id **`document_preview_formatter`**, label *"Document
  Preview Formatter"*), `src/Plugin/Field/FieldFormatter/DocumentPreviewFieldFormatter.php`, extends
  core `FileFormatterBase`. `field_types = { "file" }` — core file fields only. Setting `view_type`
  ∈ {`simplebox`, `modal`} (default `simplebox`). It previews only **public:// files**; a non-public
  file gets a `messenger()->addError()` instead of a preview.
- **Theme hook** `document_preview_field` (template `templates/document-preview-field.html.twig`) with
  entity/bundle/delta/field-name/field-type theme suggestions, declared in
  `src/Hook/DocumentPreviewHooks.php` (attribute-based hooks). Same file attaches the
  `document_preview/document-preview` library on every node via `hook_preprocess_node`.
- **Route** `document_preview.modal` (`/document_preview`), controller
  `DocumentPreviewModalController::modal` — returns an `AjaxResponse` with an `OpenModalDialogCommand`
  holding an iframe to the Google viewer for the request's `url` query param. Used by the *Modal
  window* view type.
- **Library** `document_preview/document-preview` = `css/document_preview.css` + `core/jquery` +
  `core/drupal.dialog.ajax`.

## Not provided (despite the description)

- The `.info.yml`/README mention a custom **"Document" block type**, but the module ships **no
  block-type config** (no `config/install/*`). You create that block type yourself (the project
  "tutorial" instructs the manual steps). The module contributes only the formatter, route, and theme.
- No `*.install`, no `*.services.yml`, no `*.permissions.yml`, no config schema.
