<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MySQL LOAD DATA importer decorator

## Enable
- Enable the parent `dkan_datastore_import_tweak` and DKAN's
  `dkan_datastore_mysql_import`, then `drush en dkan_datastore_mysql_import_tweak`.
- Only needed when the site imports datastore resources via the MySQL
  `LOAD DATA` path. The standard importer is handled by the parent module alone.

## Decorator wiring
- `dkan_datastore_mysql_import_tweak.services.yml` defines
  `dkan.datastore_mysql_import_tweak.service.factory.import`, which
  `decorates: dkan.datastore.service.factory.import` with `decoration_priority: -1`.
- Class `Factory\MysqlImportFactory` extends DKAN's
  `dkan_datastore_mysql_import\Factory\MysqlImportFactory`. Its `getInstance()`
  calls `parent::getInstance()`, then `$importer->setImporterClass(MysqlImport::class)`
  so the tweaked importer class is used. Constructor args (the DKAN factory's):
  import job store factory, database table factory, logger channel, event
  dispatcher, metastore reference lookup.

## Import flow (`Service\MysqlImport::runIt`)
- Extends DKAN's `dkan_datastore_mysql_import\Service\MysqlImport`.
- Short-circuits to `Result::DONE` if `dataStorage->hasBeenImported()`.
- Resolves the resource file path via `file_system` `realpath()`; errors if it
  cannot resolve, or if `filesize` is empty (workaround for DKAN issue #4273).
- Delimiter selection: a literal tab (`"\t"`) when the resource mime type is
  `text/tab-separated-values`; otherwise
  `\Drupal::config('dkan_datastore_import_tweak.parser_settings')->get('delimiter') ?? ','`.
- Reads columns and EOL from the file (`getColsFromFile($file_path, $delimiter)`),
  detects the EOL sequence (`getEol`, default `\n`), computes the header line count,
  builds the table spec (`generateTableSpec`), sets the storage schema, and
  triggers table creation via `dataStorage->count()`.
- Executes the load: `getDatabaseConnectionCapableOfDataLoad()->query(
  getSqlStatement($file_path, $tableName, array_keys($spec), $eol, $header_line_count, $delimiter),
  [], ['allow_delimiter_in_query' => TRUE])`, then `Database::setActiveConnection()`,
  sets `Result::DONE`, and runs `runOptionalPostImportCleanup()`.
- Column sanitization, the `LOAD DATA` statement construction, and post-import
  cleanup are all inherited from DKAN's parent importer; this class only changes
  where the delimiter comes from and the tweaked class swap.

## Notes
- The `quote` setting from the parent form is not applied on this MySQL path
  (only `delimiter`); `quote` affects the standard datastore importer.
- The `@todo` in the file about injecting `file_system` reflects that it uses the
  `\Drupal::service()` / `\Drupal::config()` static accessors rather than DI.
