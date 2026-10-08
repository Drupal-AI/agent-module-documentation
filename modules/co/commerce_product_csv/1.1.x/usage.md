<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Product CSV Import/Export bulk-creates and updates Drupal Commerce products (including paragraph and taxonomy fields) from an uploaded CSV, and exports existing products back to CSV.
---
An admin picks a product type, downloads a sample/template CSV showing the expected columns, fills it in, and uploads it; the import form reads the uploaded managed file with `fgetcsv` and, per row, creates or updates a product of that type, mapping columns onto fields including paragraph sub-fields, taxonomy terms and media. Export streams all products of a type to a CSV via `php://output` (StreamedResponse), and a sample endpoint returns a header + example rows. All four routes (overview, import/export form, export, sample) require the `administer product csv` permission (marked `restrict access: true`) plus a custom access check that the product type exists.

The uploaded file is a Drupal `managed_file` restricted to the `csv` extension, read from its stored URI via `file_system` realpath — there is no user-supplied file path, so no path traversal. Because import can create/update products and resolve taxonomy/media references, the permission is intentionally administrative. Set up by granting `administer product csv` to trusted roles, then use `/admin/commerce/products/csv`.
---
- Bulk-import Commerce products from a CSV file
- Bulk-update existing products by re-importing a CSV
- Export all products of a type to a downloadable CSV
- Download a sample/template CSV for a product type
- Populate product paragraph sub-fields from CSV columns
- Assign taxonomy terms to products during import
- Attach media references to products during import
- Map plain-text fields from CSV columns
- Restrict CSV import/export to trusted roles via a dedicated permission
- Pick which product type to import into or export from
- Seed a catalogue quickly from a spreadsheet
- Migrate products between environments via CSV round-trip
- Edit product data in a spreadsheet and re-import
- Validate that only .csv uploads are accepted
- Generate a starter CSV with example rows to learn the format
