<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entities Import provides an admin UI to bulk-create and update Drupal content and taxonomy entities from uploaded Excel or CSV files.

---

Entities Import lets administrators define reusable "import types" that map spreadsheet columns to the fields of a chosen content type or vocabulary, then upload an Excel (xlsx/xls) or CSV file to create or update one entity per row via Drupal's Batch API. Each import type names the column(s) used as a unique key (to decide whether a row is a new entity or an update to an existing one), the column used for the title/name, and a folder path for file/image fields. It reads spreadsheets with the phpoffice/phpspreadsheet library (installed via Composer) and supports core field types — text, number, date and date range, entity reference to content or taxonomy, and file/image — plus Paragraph fields through an encoded column syntax, with optional per-language import. It is aimed at teams who maintain data in spreadsheets and want repeatable bulk loads without building a full migration.

---

- Bulk-load nodes of a content type from a spreadsheet maintained by an editorial team.
- Import taxonomy terms into a vocabulary from an Excel or CSV file.
- Update existing content in bulk by matching on unique-key columns.
- Keep a catalogue, directory, or product list in a spreadsheet and re-import to sync changes.
- Seed a new site with initial content without writing a custom migration.
- Import multi-value fields using the pipe (`|`) separator within a single cell.
- Populate entity reference fields (content or taxonomy) by referencing target entities by title/name.
- Import date and date-range fields from human-readable date strings.
- Attach file/image fields by naming files in the spreadsheet and placing them under a configured folder.
- Import Paragraph field data through the `|`/`#`/`*` encoded column syntax.
- Import content in a specific language by choosing a language code on the import type or adding a `langcode` column.
- Create translations of existing entities during import when the Language module is enabled.
- Define multiple import types, each mapping a different spreadsheet to a different content type or vocabulary.
- Re-run an import type repeatedly as the source spreadsheet is updated.
- Distribute a sample template (see the module's `doc/` folder) to non-technical staff for data entry.
- Convert legacy CSV exports from another system into Drupal content.
- Batch-import large data sets with progress reporting and per-row error messages.
- Standardise recurring bulk-content operations behind a saved configuration.
- Load reference/lookup taxonomy data alongside the content that references it.
- Onboard content editors who prefer working in Excel over the Drupal node form.
