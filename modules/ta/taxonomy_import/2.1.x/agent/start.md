# Taxonomy Import — agent index

Bulk-imports taxonomy terms into an **existing** vocabulary from an uploaded CSV or XML file.
Column/tag order = name, parent (matched by name for hierarchy), description. Extra columns map
to matching custom term fields.

- **The import form, file format, import behaviour, and the settings** →
  [configure/import.md](configure/import.md)
- **The `taxonomy_import.term_utils` service (programmatic import)** →
  [api/service.md](api/service.md)

Key facts:
- Import form: route `taxonomy_import.import` at `/admin/config/content/taxonomy_import/import`
  (permission `administer taxonomy import`).
- Settings form: route `taxonomy_import.config` at
  `/admin/config/content/taxonomy_import/settings_import_taxonomy`
  (permission `administer configure taxonomy import`), config object `taxonomy_import.config`
  with keys `file_extensions` (default `csv xml`) and `file_max_size` (default `256000000`).
- Service: `taxonomy_import.term_utils` → `TaxonomyUtils::saveTerms($vid, $rows, $forceNewTerms)`.
- No config schema shipped, no Drush, no plugin types. Vocabulary must already exist.
