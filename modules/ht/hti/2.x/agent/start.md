<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hierarchical Taxonomy Importer (hierarchical_taxonomy_importer) — agent index

Imports taxonomy terms in a **nested parent-child structure** into a chosen vocabulary from an
uploaded **CSV** file. Version dir **2.x** (installed release **2.0.0**). Package **Taxonomy**.
License **GPL-2.0-or-later**. Core `^8 || ^9 || ^10 || ^11 || ^12`, PHP **8.1**.

**Name mismatch (important):** the drupal.org project / Composer package / doc dir is **`hti`**
(install with `composer require drupal/hti`), but the actual module machine name — used in
`core.extension`, `drush en`, service ids, config, and dependency references — is
**`hierarchical_taxonomy_importer`**. Use the machine name everywhere inside Drupal.

- **Depends on** core `taxonomy` and `file`. No composer.json (no third-party requirements). No
  submodules. No permissions.yml, no Drush commands, no plugin types, no config schema, no
  libraries.

## What it provides
- **One route / form** — `hierarchical_taxonomy_importer.form` at
  `/admin/config/development/hierarchical-taxonomy-importer`, permission **`administer taxonomy`**
  (core). Menu link under *Configuration → Development* ("Taxonomy Importer"). Set as the module's
  `configure` route. Form class `Drupal\hierarchical_taxonomy_importer\Form\TaxonomyImporterForm`.
- **Two services** (`*.services.yml`): `hierarchical_taxonomy_importer.importer` →
  `services\ImporterService` (the one the form actually uses) and `importer.taxonomy_importer` →
  `Importer\CsvImporter` (an alternate/legacy importer, not wired to the form). Base class
  `Base\ImporterBase` is empty.
- **One DB table** `hti_term_levels` (`hook_schema` in `.install`) plus a MySQL/PgSQL foreign key
  to `taxonomy_term_data(tid)` added in `hook_install`. NOTE: the shipped 2.0.0 code does **not**
  write to this table — it is defined but unused by the active import path.
- **Hooks** (`.module`): `hook_help`, `hook_modules_installed` (post-install status message).
  `hook_uninstall` (`.install`) deletes config `hierarchical_taxonomy_importer.settings` (which the
  module never creates).

## How the import works
- **How to run it, CSV format, the recursion, quirks, and operating notes** →
  [config/import.md](config/import.md)

Summary: `TaxonomyImporterForm` shows a vocabulary `select` + a `file` field; `validateForm()`
requires a `.csv` extension (by client filename), `submitForm()` reads the temp upload with
`fopen`/`fgetcsv` into a 2-D array and calls `ImporterService::import()`, which recursively walks
rows/columns creating `Term` entities with `parent` references. Import **only creates** terms
(never updates/de-dupes existing ones); no batch (large files can time out).
