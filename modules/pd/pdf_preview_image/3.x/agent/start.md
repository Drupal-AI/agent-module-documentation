<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PDF Preview Image (pdf_preview_image) — agent index

Auto-generates a **first-page preview image** from an uploaded **PDF file field** and stores it in
a chosen **image field** on the same entity. Version **3.x** (packaged 3.0.0). Package *Field
types*. Core `^10 || ^11`. License GPL-2.0-or-later.

- **How it works, config, mechanism, requirements, operations** →
  [fields/pdf-preview.md](fields/pdf-preview.md)

## What it actually is

- **Not** a field formatter, widget, or field type. The entire module is one file,
  `pdf_preview_image.module` (~176 lines). No `src/`, no routes, no permissions, no services, no
  Drush, no config objects/schema.
- **Dependencies:** core `image` module (`dependencies: drupal:image`), and the Composer library
  `spatie/pdf-to-image:^3.1` (pulled in automatically). That library uses the **Imagick PHP
  extension**; the server's ImageMagick must have PDF (Ghostscript) delegate support.
- Configured **per file field** via two third-party settings it attaches to the Field UI edit
  form — there is no central settings page.

## Provides (from source)

- `hook_entity_presave()` — `pdf_preview_image_entity_presave()`: on save of any content entity,
  for each `file` field that has third-party setting `enable` = TRUE, rasterises the referenced
  PDF's first page and writes it to the configured `target_field` image field. Clearing the PDF
  field deletes the previously generated preview.
- `hook_form_field_config_edit_form_alter()` — `pdf_preview_image_form_field_config_edit_form_alter()`:
  adds the *"PDF preview auto-generation"* fieldset (`enable` checkbox + `target_field` select) to
  eligible file fields.
- Helpers: `_pdf_preview_image_is_eligible()` (file field whose `file_extensions` include `pdf`),
  `_pdf_preview_image_allowed_image_fields()` (lists image fields on the same entity type/bundle).

## Mechanism (one line)

On presave: load PDF managed file → require MIME `application/pdf` → resolve real path via
`file_system->realpath()` → `new \Spatie\PdfToImage\Pdf($realpath)` → `$pdf->save($jpgPath)` → save
the managed image file and set it on the target field.
