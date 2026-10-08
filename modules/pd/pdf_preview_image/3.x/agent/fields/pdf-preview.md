<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PDF preview auto-generation — how it works

Everything lives in `pdf_preview_image.module`. There is no `src/`, no plugin, no route,
no permission, no service, no config object, and no config schema. The module wires two Drupal
hooks.

## Install / enable

1. `composer require drupal/pdf_preview_image` — this also pulls `spatie/pdf-to-image:^3.1`.
2. Server must have the **Imagick PHP extension** and **ImageMagick built with PDF/Ghostscript
   delegate support** (v3 rasterises through the Imagick extension, not a CLI binary).
3. `drush en pdf_preview_image` (depends on core `image`).

## Configure (per field, no central settings page)

The module has no admin form of its own. It attaches settings to the **Field UI edit form** of an
eligible file field:

- **Eligibility** — `_pdf_preview_image_is_eligible($field_config)`: field type is `file` AND its
  `file_extensions` setting matches `/(^|\s|,)pdf($|\s|,)/i`. So the file field must allow the
  `pdf` extension. (Add `pdf` under *Allowed file extensions* first.)
- `pdf_preview_image_form_field_config_edit_form_alter()` then adds a fieldset **"PDF preview
  auto-generation"** with:
  - `enable` (checkbox, *"Generate first page preview"*) — stored as third-party setting
    `pdf_preview_image.enable` on the field config.
  - `target_field` (select, *"Store 1st page image preview in"*, `#states` visible only when
    `enable` is checked) — options come from `_pdf_preview_image_allowed_image_fields($entityType,
    $bundle)`, i.e. every **image** field on the same entity type + bundle. Stored as
    `pdf_preview_image.target_field`.

So the target must be an existing **image** field on the same bundle. If none exists, create one,
then set it here.

## Generation flow — `pdf_preview_image_entity_presave(EntityInterface $entity)`

Runs on presave of any `ContentEntityInterface`. For each of the entity's field definitions:

1. Skip unless field type is `file` and its third-party setting `pdf_preview_image.enable` is TRUE.
2. Resolve `target_field` from the third-party setting; skip if not set.
3. Read the first PDF value (`$entity->get(<file field>)->getValue()[0]`).
4. **If a PDF is present:**
   - Load the file entity (`entityTypeManager` storage for the field's `target_type`).
   - **MIME guard:** if `$file->getMimeType() !== 'application/pdf'`, `continue` (only real PDFs
     are processed).
   - Compute the output filename: `str_replace('.pdf', '', $pdf_filename) . '.jpg'` (note: this
     strips *every* occurrence of the substring `.pdf`, not just the extension).
   - Compute the output directory from the **target image field settings**: token-replace
     `file_directory` (`\Drupal::token()->replace(...)`) and prefix with `uri_scheme` (e.g.
     `public://`); `prepareDirectory(..., CREATE_DIRECTORY)` if a directory is set.
   - Build `$img_preview_path = <uri_scheme>://<directory>/<filename>`, using the uploader's uid.
   - Delete any file entities already referenced by the target field (cleanup of a prior preview),
     then `File::create([...])->save()` a new managed image file and set it on the target field.
   - **Rasterise:** if `class_exists('Spatie\PdfToImage\Pdf')`, resolve the PDF's real path with
     `\Drupal::service('file_system')->realpath($pdf_uri)`, then
     `$pdf = new \Spatie\PdfToImage\Pdf($realpath); $pdf->save($img_preview_path);` (first page,
     default output). If the class is missing it logs an error to the `pdf_preview_image` channel.
5. **If the PDF field is empty:** if the target field currently references a file, delete that file
   entity and set the target field to `[]` (keeps the preview in sync with the source PDF).

Note the input to the converter is always the **managed file's own real path** (from the file
entity's `uri`), never a request- or config-supplied arbitrary path. The output path is built from
the admin-configured target image field's `uri_scheme` + `file_directory` plus the uploaded PDF's
(Drupal-sanitised) filename.

## Operate

- Previews regenerate on **every save** of the host entity (existing preview file is deleted and
  recreated), so replacing the PDF replaces the thumbnail.
- Apply core **Image styles** to the target image field's display to size/crop the preview.
- Only the **first page** is rendered (spatie default page 1).
- Non-PDF files in a PDF-allowed field are ignored (MIME check).
- No queue/batch: generation is synchronous inside presave, so large PDFs slow the save request.
