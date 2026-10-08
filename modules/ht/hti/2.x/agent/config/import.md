<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Running the import (form, CSV format, mechanism)

Machine name `hierarchical_taxonomy_importer`. This is the whole runtime surface of the module —
one admin form that turns a CSV into nested taxonomy terms.

## Install / enable
- `composer require drupal/hti` (Composer package is the **project** name `hti`), then
  `drush en hierarchical_taxonomy_importer` (enable by the **machine** name).
- Depends on core `taxonomy` + `file`. On install, `hook_install` creates table `hti_term_levels`
  and, on MySQL/PgSQL, adds FK `hti_term_levels_tid_fk → taxonomy_term_data(tid) ON DELETE CASCADE`
  (failures are logged, not fatal). `hook_modules_installed` shows a status message linking to the
  form. (The `hti_term_levels` table is defined but not written by the 2.0.0 import path.)

## Route, form, permission
- Route `hierarchical_taxonomy_importer.form`, path
  `/admin/config/development/hierarchical-taxonomy-importer`, requirement
  `_permission: 'administer taxonomy'` (`hierarchical_taxonomy_importer.routing.yml`). Menu link
  under *Configuration → Development* (`*.links.menu.yml`).
- Form `Form/TaxonomyImporterForm` (`FormBase`, id `taxonomy_importer_form`), DI:
  `entity_type.manager`, `hierarchical_taxonomy_importer.importer`, `messenger`, `file_system`.
  - `buildForm()`: a required `vocabulary` **select** (options from `getVocabularies()` =
    `Vocabulary::loadMultiple()` → id⇒label) and a required `csv_file` **file** field, plus an
    *Import* submit. As a `FormBase`, it carries Drupal's CSRF token automatically.
  - `validateForm()`: reads the upload from `getRequest()->files->get('files')['csv_file']`, checks
    `isValid()`, takes the **client** filename's extension via `pathinfo(...PATHINFO_EXTENSION)` and
    errors unless it is `csv`. Stores the temp real path (`getRealPath()`) in `csv_file`. (Extension
    is checked, MIME is not; content is validated only by `fgetcsv` parsing.)
  - `submitForm()`: `fopen($path,'r')` then a `fgetcsv($handle, 1000, ",")` loop building a 2-D
    `$output` array (row → array of cell strings), then `ImporterService::import($vid, $output)`
    inside try/catch → success or error message. Comma-delimited, 1000-byte line cap per `fgetcsv`.

## CSV format (column = depth)
Each **column** is a hierarchy level; leading empty cells push a term deeper. Example
(from README):

```
Electronics,,,
,Computers,,
,,Laptops,
,,,Gaming Laptops
,,,Business Laptops
```

→ Electronics > Computers > Laptops > {Gaming Laptops, Business Laptops}. `getIndexOfNonNullValues`
finds the first non-blank column in a row (treats `""` and `" "` as blank) to decide the term's
depth.

## Term creation — `services\ImporterService::import()`
Recursive over rows/columns; signature
`import($vid, $data, $count, $row, $pointer, $parent, $tag)`.
- Throws nothing for depth but returns `NULL` when `$count >= count($data)` or the row is blank.
- For each row it finds the active column (`getIndexOfNonNullValues`), the parent row
  (`getParentRow`, scans upward for a non-empty cell one column left) and the parent path
  (`getParentTree`, walks up-and-left collecting ancestor names).
- To resolve the correct existing parent it loads all terms named like the parent
  (`taxonomy_term` storage `loadByProperties(['vid','name'])`), compares each candidate's
  `loadAllParents()` name-chain against the CSV-derived `$csv_tree`, and picks the id whose ancestry
  matches — this disambiguates duplicate names in different branches.
- `updateActualParent()` → `createNewTerm()` builds `Term::create(['name','parent','vid'])->save()`
  (parent `[$id]` when >0, else `[]`); errors are caught and logged to channel
  `hierarchical_taxonomy_importer`. Tags `SAME_PARENT`(0)/`DIFFERENT_PARENT`(1)/`PREVIOUS_PARENT`(-1)
  drive whether recursion descends to `$row+1,$pointer+1` (child), stays at `$pointer` (sibling), or
  climbs to `$pointer-1`.

## Alternate importer (not wired to the form)
Service `importer.taxonomy_importer` → `Importer\CsvImporter` offers `importTaxonomies($vid,$data)`
/ `getNestedTid()` with a similar name-based parent lookup, but the form does **not** call it. Treat
`ImporterService::import()` as the live path.

## Operating notes / limits
- **Creates only** — never updates or de-duplicates against existing terms; re-running or importing
  into a populated vocabulary produces duplicates. Best on an empty/fresh vocabulary; back up first.
- **No batch / no queue** — the whole file is parsed and all terms saved in one request; large CSVs
  can hit PHP time/memory limits. Split large files.
- CSV **only** (`fgetcsv`); `.xlsx`/binary spreadsheets are not parsed despite "csv/Excel" wording
  elsewhere. Use comma delimiters; keep lines under the 1000-byte `fgetcsv` cap.
- `hook_uninstall` deletes config `hierarchical_taxonomy_importer.settings`, which the module never
  writes — a harmless no-op.
