<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Taxonomy Import (lupus_taxonomy_import) — agent index

An admin form that creates taxonomy terms from an uploaded CSV — hierarchy and term field values
included. Version **8.x-1.3**, package `lupus`, core `^10.2 || ^11`. No dependencies outside core;
no Drush commands, no config, no config schema.

- Form route `lupus_taxonomy_import.csv_import` → `/admin/config/content/taxonomy/csv_import`
  (`Drupal\lupus_taxonomy_import\Form\ImportForm`).
- Example-download route `lupus_taxonomy_import.csv_import.example` →
  `/admin/config/content/taxonomy/csv_import/example/{type}`
  (`Controller\Import::getExampleCsv`), which streams the bundled `src/Controller/examples/{type}.csv`
  as an attachment. Two example files ship: `example_ingredients` (flat) and
  `example_with_hierarchy` (nested).
- Import logic is the service `lupus_taxonomy_import.importer`
  (`Drupal\lupus_taxonomy_import\Service\Importer`), injected with `file_system` and
  `entity_type.manager`.

## Access
Form route requires `administer taxonomy` **OR** `import taxonomy csv` (routing uses
`administer taxonomy+import taxonomy csv`, where `+` means any-of). `import taxonomy csv` is the
module's own permission, letting a data-entry role load vocabularies without full taxonomy
administration. The example-download route is `_access: 'TRUE'` — the bundled example CSVs are
public by design.

## How the CSV is read (the non-obvious part)
Detail in [`agent/forms/csv-import-form.md`](forms/csv-import-form.md). In short:
- Hierarchy is by **column position**, not indentation. Header columns named `0, 1, 2, …` are level
  columns (0 = top). Each row puts its term name in exactly one numbered column; that column index is
  the term's depth. It becomes a child of the nearest preceding term one level shallower.
- Header columns whose names are **not** numbers are term fields (`status`, `weight`, `description`,
  `field_seo_title`, …). A named field missing from the vocabulary is silently ignored; entity-
  reference fields are skipped. Protected header names rejected: `changed`, `parent`, `tid`, `uuid`,
  `vid`, `metatag`.
- Validation aborts the import if level columns are out of order, the first data row is not level 0,
  a row carries more than one term, or **any term name repeats** (names must be globally unique in
  the file).

## Behaviour to know
- **Create-only.** The importer always `create()`s terms; it never updates or de-duplicates against
  existing terms. Re-running the same file without purging duplicates everything. The UI states
  "Updating existing terms is not supported."
- **Purge option** deletes *all* existing terms in the target vocabulary before import (breaking any
  content that referenced them) — off by default.
- **Synchronous** — the whole import runs in the form submit handler, no Batch API. Large files are
  bounded by PHP time/memory limits.
- The uploaded file is created unmanaged and deleted immediately after the run.

## Quirk
`lupus_taxonomy_import.links.action.yml` ships a hard-coded "Zutat hinzufügen" (German: "Add
ingredient") action link pointing at an `ingredients` vocabulary and a `view.ingredients.taxonomy_ingredients`
view — a leftover from the maintainer's own project. It only appears if that view exists; harmless
otherwise.
