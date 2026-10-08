<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Excel Importer turns an uploaded `.xlsx` spreadsheet into Drupal nodes — one worksheet per content type, one row per node — so a client's spreadsheet becomes content without building a migration.

---

The module adds an upload form at `/excel-import` and a settings form at `/admin/config/content/excel_importer`. An admin first picks which content types may be imported into (`allowed_types`, default `article`) and writes intro text. An importer then uploads an `.xlsx` file whose worksheets are named after those content types; row 2 of each sheet lists the field machine names and the rows below hold the data. On submit the file is parsed with `phpoffice/phpspreadsheet ^3`, each cell is validated (field exists, required fields present, integer fields numeric, taxonomy references resolvable), values are coerced — taxonomy/user/node references are looked up by name/email/title and turned into ids, date ranges split on a comma, empty numeric cells default to zero — and a node is created and saved for every data row, with a generated title when none is given. The whole import runs synchronously in one request; the first invalid cell aborts the batch with a message naming the sheet, row and field. Its niche versus the Migrate framework is the one-off handover: no rollback, no CI, but no migration to build either. Requires PHP 8.1+ and Drupal 9.5, 10 or 11.

---

- Create nodes from a client's spreadsheet.
- Import a product list into Drupal.
- Turn an XLSX export into content.
- Map spreadsheet columns to node fields by machine name.
- Load reference content before a site launch.
- Avoid building a Migrate pipeline for a one-off import.
- Import a staff directory.
- Bulk-create event listings.
- Let a trusted content team self-serve an import.
- Import data exported from another CMS.
- Load a catalogue from a supplier file.
- Resolve taxonomy references by term name instead of by tid.
- Auto-create taxonomy terms when the field handler allows it.
- Populate entity-reference fields to users (by email) or nodes (by title).
- Import date-range fields from a single "start,end" cell.
- Restrict importing to selected content types via settings.
- Create content from a survey or form export.
- Import a list of locations or venues.
- Populate a demo or staging site with sample content.
- Convert a maintained spreadsheet into pages.
- Reduce manual data entry for a large content batch.
- Hand editors a template sheet and collect content offline.
- Seed a taxonomy-driven catalogue from one file.
