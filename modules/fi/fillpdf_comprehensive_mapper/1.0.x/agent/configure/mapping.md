<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# fillpdf_comprehensive_mapper — comprehensive mapping

## Choose the source form
`/admin/config/media/fillpdf/comprehensive-mapper` (permission `administer pdfs`). Config `fillpdf_comprehensive_mapper.settings:source_form` = the FillPDF form ID to use as the master mapping. Saving the settings form immediately kicks off `BulkUpdate::initBatch()`.

## What the batch does
`BulkUpdate` queries all `fillpdf_form` entities except the source (`accessCheck(TRUE)`), chunks them by 20, and processes each chunk. `FormsUpdater::overwriteAllWithMapper()` loads the source form's `getFormFields()` (keyed field mappings) and calls FillPDF's `Serializer::importFormFields($keyed_fields, $existing_fields)` on every other form — so each PDF field whose key matches inherits the source's mapping.

## Re-propagating
`FormAlter` adds the same bulk-update submit handler to the **source form's** own edit form (`form_fillpdf_form_edit_form_alter`), so editing and saving the designated master re-applies its mappings across all forms.

## Programmatic
Call the service `fillpdf_comprehensive_mapper.forms_updater` → `overwriteAllWithMapper()` to run the overwrite outside the UI.

Caution: this **overwrites** matching mappings on every other FillPDF form; set the source deliberately.
