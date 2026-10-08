<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The 'Files / Downloads' paragraph type (drowl_paragraphs_bs_type_attachments)

## Install & enable

```bash
drush en drowl_paragraphs_bs_type_attachments -y
```

Enabling pulls in its dependencies (`entity_reference_display:entity_reference_display`, `drowl_paragraphs_bs:drowl_paragraphs_bs`, `media_library:media_library`, `media_library_edit:media_library_edit`, `fences:fences`, `drupal:media`) and imports the shipped `config/install` (paragraphs_type, fields, entity form/view displays, optional language content settings). It has no permissions, routes, services or config schema of its own.

## Bundle(s) & fields

`field_attachments` (multi-value media entity reference; storage shipped here), `field_nodeentityrefvm` (embedded view-mode selector) and `field_settings`.

## `.module` (preprocess)

`drowl_paragraphs_bs_type_attachments_preprocess_paragraph()` (bundle `attachments`) attaches the `drowl_paragraphs_bs_type_attachments/global` CSS library, then iterates the paragraph wrapper classes, removes any `btn-*` class and collects them, and pushes them onto each referenced item as `content.field_attachments[key]['#drowl_media']['button_classes']` so drowl_media/drowl_base document templates can render the link as a button. (A cache-tag TODO for referenced entities is left commented out.)

## Template

`templates/paragraph--drowl-paragraphs-bs--attachments.html.twig` adds a `paragraph--embeded-entity-view-mode-<vm>` class (from `field_nodeentityrefvm`, run through `clean_class`) and prints the referenced media through the parent template's content block.

## Library

`global` in `drowl_paragraphs_bs_type_attachments.libraries.yml` = `dist/css/drowl_paragraphs_bs_type_attachments.global.min.css`.

## Notes

- This is a presentational bundle for the Paragraphs / Layout Paragraphs stack; it is not standalone.
- Per-instance options are UI Styles selected under the Paragraphs 'Settings', not a config form.
- Override the template in your Bootstrap 5 / Radix / DROWL Base theme to change markup.
