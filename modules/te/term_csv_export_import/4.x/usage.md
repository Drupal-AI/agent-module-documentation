Term CSV Export/Import adds two admin forms to bulk-import taxonomy terms from CSV text and export a vocabulary's terms to CSV, preserving the parent/child hierarchy.

---

The module provides an **Import** form (`/admin/config/content/term-csv-import`, route `term_csv_export_import.import`, the module's `configure` route) and an **Export** form (`/admin/config/content/term-csv-export`), both gated by the single `administer term_csv_export_import` permission. Import is a 3-step form: paste CSV, optionally create a new vocabulary, confirm; export is a 2-step form: choose a vocabulary and options, then read the generated CSV from a textarea. The CSV columns are, without IDs: `name,status,description__value,description__format,weight,parent_name` and, with IDs: `tid,uuid,name,status,revision_id,description__value,description__format,weight,parent_name,parent_tid`; an optional trailing `fields` column carries any extra taxonomy fields, `http_build_query`-encoded. Hierarchy is expressed by `parent_name` (or `parent_tid`), and multiple parents are separated by `;`. Import options include **Preserve Vocabularies on existing terms**, **Preserve existing terms** (skip rather than update on a tid collision — useful when importing from another install), and creating a brand-new vocabulary inline. The heavy lifting is in two plain PHP classes, `ImportController` (parses the CSV and creates/updates `taxonomy_term` entities, inserting rows directly for preserved tids) and `ExportController` (walks `loadTree()` and builds the CSV). There is no Drush command, no config entity, and no service; the classes can be instantiated directly for scripted imports/exports. A `d7exportview.txt` Views export is bundled to help pull terms out of a Drupal 7 site.

---

- Bulk-import a list of taxonomy terms into a vocabulary by pasting CSV.
- Export an existing vocabulary's terms to CSV for backup or review.
- Migrate a term hierarchy between two Drupal sites (export on one, import on the other).
- Recreate a parent/child category tree from a spreadsheet using `parent_name`.
- Import terms and create a new vocabulary for them in one step.
- Preserve term IDs when moving terms between installs (include IDs on export/import).
- Skip already-existing terms on re-import with "Preserve existing terms" to avoid duplicates.
- Keep terms in their current vocabulary while updating other fields ("Preserve Vocabularies").
- Seed a taxonomy quickly for a new site from a prepared CSV.
- Export terms with their extra fields (http_build_query-encoded `fields` column).
- Import multi-parent terms using `;`-separated `parent_name`/`parent_tid` values.
- Round-trip a vocabulary: export with headers+IDs, edit in a spreadsheet, re-import.
- Migrate taxonomy from a Drupal 7 site using the bundled `d7exportview.txt` Views export.
- Populate a large category list (hundreds of terms) without manual term entry.
- Update term descriptions or weights in bulk by editing an exported CSV and re-importing.
- Set term weights (ordering) via the CSV `weight` column during import.
- Import term descriptions with a specific text format via `description__format`.
- Programmatically import terms by instantiating `ImportController($csv, $vid)->execute(...)`.
- Programmatically export a vocabulary via `ExportController($termStorage, $vid)->execute(...)`.
- Clone a vocabulary's structure into a new vocabulary on the same site.
- Standardise taxonomy across environments by committing the CSV to version control.
- Give editors a copy-paste way to add many terms at once without the term add form.
- Rebuild a corrupted or partially deleted vocabulary from an earlier CSV export.
