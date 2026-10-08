<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Paragraphs (custom_paragraphs) — agent index

A developer library for **dynamic, repeatable "add another item" field groups in custom forms**.
It ships a front-end JavaScript class plus two AJAX file-upload endpoints; group data is stored as
**JSON in a hidden form field**. Not the entity-based Paragraphs module. Package `Custom`. Core
`^10 || ^11`. License GPL-2.0-or-later. Version 1.0.x. No admin UI, no config entities, no
permissions of its own, no Drush.

## What it actually is (from source)

- **Library** `custom_paragraphs/custom_paragraphs` (`custom_paragraphs.libraries.yml`): the JS
  `js/components/repeatable-field-group.js` + CSS `css/custom-paragraphs.css`; depends on
  `core/drupal` and `core/once`.
- **JS class** `RepeatableFieldGroup`, exposed globally as `window.RepeatableFieldGroup`. There is
  **no `Drupal.behaviors` auto-attach** — a developer instantiates it in their own JS against a
  wrapper element (`data-rfg-instance` id) with a config object. Renders text / textarea / select /
  checkbox / file fields, add/remove UI, per-field client validation, optional CKEditor 5 on
  textareas (via `Drupal.editors.ckeditor5`), and serializes rows to JSON in a hidden input.
- **Controller** `RepeatableFileUploadController` (`src/Controller/RepeatableFileUploadController.php`),
  two POST routes (`custom_paragraphs.routing.yml`), each `_permission: "access content"`:
  - `custom_paragraphs.repeatable_file_upload` — `/custom-paragraphs/repeatable-file-upload` →
    `::upload()`. Saves each posted file as a permanent managed `file` entity; returns JSON
    `{status, files:[{fid,filename,uri,url}]}`.
  - `custom_paragraphs.repeatable_file_restore` — `/custom-paragraphs/repeatable-file-restore` →
    `::restore()`. Loads files by posted `fids[]`; returns the same metadata shape.
- **Hook** `custom_paragraphs_page_attachments()` (`custom_paragraphs.module`): iterates
  `Drupal\editor\Entity\Editor::loadMultiple()` and pushes each active editor's config into
  `drupalSettings.editor.formats` so the JS can attach CKEditor 5 to dynamically added textareas.
  This uses the core **editor** module at runtime (not declared as a dependency in `info.yml`).

## Solution docs

- Front-end JS: attach the library, the `RepeatableFieldGroup` config, field types, JSON output →
  [js/repeatable-field-group.md](js/repeatable-field-group.md)
- File-upload AJAX endpoints (routes, request params, JSON contract) →
  [api/file-upload.md](api/file-upload.md)

## Notes

- No `*.permissions.yml`, `*.services.yml`, `*.install`, `config/install`, or `config/schema` in
  the project. `provides_config_schema` is false.
- No submodules.
