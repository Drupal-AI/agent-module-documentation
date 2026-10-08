# Drush commands

Defined in `PathRedirectImportCommands` (registered via `drush.services.yml`). The class
extends Migrate Tools' `MigrateToolsCommands`; both commands require the `migrate_tools`
module to be enabled.

## `path_redirect_import:import` (alias `prii`)

```bash
drush path_redirect_import:import /path/to/redirects.csv
drush prii /path/to/redirects.csv
```

- Takes one argument: the path to a CSV file (same `source,destination,language,status_code`
  format as the Migrate form).
- Errors out if the file does not exist.
- Copies the file to `temporary://path_redirect_import/migrate.csv`, resets the
  `path_redirect_import` migration status, then runs it with `limit=0`, `update=TRUE`,
  `force=FALSE` — so it imports/updates every row in one batch.
- Logs "Redirects imported." on success.

Note: unlike the web form, the Drush import performs **no pre-validation** of headers,
encoding, empty cells, or self-redirects — supply a clean CSV.

## `path_redirect_import:export` (alias `prie`)

```bash
drush path_redirect_import:export
drush prie
```

- Takes no arguments. Builds a batch from `RedirectExport::getBatchOperations()` and processes
  it (`drush_backend_batch_process()`), exporting all existing `redirect` entities to a CSV
  with the `source,destination,language,status_code` structure.
