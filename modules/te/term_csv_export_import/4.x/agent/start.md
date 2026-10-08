# Term CSV Export/Import — agent index

Two admin forms to **import** taxonomy terms from CSV and **export** a vocabulary's terms to
CSV, preserving the term hierarchy. No Drush, no config entity, no service — the work is done
by two directly-instantiable PHP classes. Single permission gates both forms.

- **The forms, routes, CSV column format, options, and how to import/export
  programmatically** → [configure/import-export.md](configure/import-export.md)
- **Permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Import form: `/admin/config/content/term-csv-import` (route `term_csv_export_import.import`,
  the module's `configure` route). Export form: `/admin/config/content/term-csv-export`.
- CSV columns (no IDs): `name,status,description__value,description__format,weight,parent_name`.
  With IDs: `tid,uuid,name,status,revision_id,description__value,description__format,weight,parent_name,parent_tid`.
  Optional trailing `fields` column = extra fields `http_build_query`-encoded. Multiple
  parents separated by `;`.
- Classes: `Drupal\term_csv_export_import\Controller\ImportController($csv_string, $vid)`
  then `->execute($preserve_vocabularies, $preserve_tids)`; and
  `Drupal\term_csv_export_import\Controller\ExportController($term_storage, $vid)`
  then `->execute($include_ids, $include_headers, $include_fields)` (returns the CSV string).
- Permission: `administer term_csv_export_import`. Depends on `taxonomy`. No `provides_config_schema`.
