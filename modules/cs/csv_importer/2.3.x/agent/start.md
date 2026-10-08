# CSV Importer — agent index

Import any Drupal content entity from a CSV file. No config UI, no config entities, no Drush.
Main interaction is the admin form at `/admin/content/csv-importer`.

- Import UI, routes, permission, CSV format & column-mapping syntax, history/revert → [configure/csv_importer.md](configure/csv_importer.md)
- Programmatic use: parser service, importer plugin type/manager, running an import in code → [api/csv_importer.md](api/csv_importer.md)
- Alter hooks (`hook_csv_importer_pre_import`, `importer_info`) → [hooks/csv_importer.md](hooks/csv_importer.md)
