<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FillPDF Comprehensive Mapper solves the chore of re-entering the same PDF field mappings across many FillPDF forms by letting you nominate one form as the "comprehensive" source and pushing its field mappings onto all the others.
---
You pick a source FillPDF form at `/admin/config/media/fillpdf/comprehensive-mapper` (permission `administer pdfs`). Saving that form runs a batch (`BulkUpdate`) that loads every other FillPDF form and imports the source's keyed field mappings into each via FillPDF's own serializer (`importFormFields`), so any PDF field with a matching key inherits the source mapping. A form_alter also adds the same bulk-update submit handler to the source form's own edit form, so editing the designated master re-propagates its mappings. The service `FormsUpdater::overwriteAllWithMapper()` performs the same overwrite programmatically.

It works entirely with FillPDF *form* configuration entities and field-key matching — it does not upload, move, or read PDF files itself; the actual PDF handling stays in the FillPDF module. All access is gated by the FillPDF `administer pdfs` permission, and entity queries use access checking. Because it overwrites mappings on every other form, treat the source selection carefully — a mis-set source rewrites all forms' mappings on save.
---
- Reuse one FillPDF field mapping across all PDF forms
- Nominate a master FillPDF form as the mapping source
- Bulk-apply field mappings to every other FillPDF form
- Re-propagate mappings by editing the source form
- Avoid re-mapping identical fields on each PDF
- Batch-update large numbers of FillPDF forms at once
- Keep shared PDF fields (name, date, address) mapped consistently
- Import source mappings by matching PDF field keys
- Run the overwrite programmatically via FormsUpdater
- Standardise mappings across a family of similar PDFs
- Update all forms when the master mapping changes
- Chunk the update into batches of 20 forms
- Configure the source form at the mapper settings page
- Skip the source form itself when propagating
- Onboard new PDF forms by inheriting the master mapping
- Reduce manual mapping errors across many templates
