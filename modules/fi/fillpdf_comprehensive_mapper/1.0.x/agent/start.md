<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FillPDF Comprehensive Mapper (fillpdf_comprehensive_mapper) — agent index

**Designates one FillPDF form as a master mapping and bulk-copies its field mappings onto all other FillPDF forms.**

- **Version:** 1.0.0-rc1 (dir 1.0.x)  •  **Core:** ^10.3 || ^11.0 || ^12  •  **Requires:** fillpdf  •  **Configure:** `fillpdf_comprehensive_mapper.settings` (`/admin/config/media/fillpdf/comprehensive-mapper`)
- **Route:** settings form gated by `administer pdfs` (FillPDF's permission).
- **Service:** `fillpdf_comprehensive_mapper.forms_updater` (`FormsUpdater::overwriteAllWithMapper()`). Batch `BulkUpdate` + `BulkUpdateBatch`. Form-alter (`src/Hook/FormAlter.php`) adds the bulk-update submit to the source form's edit form. Config key: `source_form`.
- **Security:** Admin-only (`administer pdfs`). Operates on FillPDF *form config entities* and field-key matching via FillPDF's serializer — it does **not** upload, read, or move PDF files itself (no file-path/upload handling), so no path-traversal surface here. Entity queries use `accessCheck(TRUE)`. Operational caution: saving overwrites mappings on all other forms.

See [configure/mapping.md](configure/mapping.md)
