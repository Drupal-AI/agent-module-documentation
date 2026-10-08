<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Datastore MySQL Import Tweaked (dkan_datastore_mysql_import_tweak) — agent index

Submodule of `dkan_datastore_import_tweak`. Applies the parent module's configured
CSV `delimiter` to DKAN's fast MySQL `LOAD DATA` datastore importer
(`dkan_datastore_mysql_import`), which otherwise ignores that setting.

## Dependencies
- `dkan_datastore_import_tweak:dkan_datastore_import_tweak` (for the settings/config).
- `dkan:dkan_datastore_mysql_import` (the importer it extends).
- Core `^10 || ^11`.

## What it provides
- Service decorator (`dkan_datastore_mysql_import_tweak.services.yml`):
  `dkan.datastore_mysql_import_tweak.service.factory.import`
  `decorates: dkan.datastore.service.factory.import` (priority -1),
  class `Drupal\dkan_datastore_mysql_import_tweak\Factory\MysqlImportFactory`.
- `MysqlImportFactory` extends the parent DKAN `MysqlImportFactory` and, in
  `getInstance()`, calls `$importer->setImporterClass(MysqlImport::class)`.
- `MysqlImport` (`src/Service/MysqlImport.php`) extends the DKAN
  `dkan_datastore_mysql_import` `MysqlImport`; its `runIt()` reads the delimiter
  from `dkan_datastore_import_tweak.parser_settings` (or `,`; a literal `\t` for
  `text/tab-separated-values`) and passes it through `getColsFromFile()` and
  `getSqlStatement()` for the `LOAD DATA` query.
- No config, schema, permissions, routes, or Drush commands of its own.

## Solution docs
- Decorator wiring and the import flow: `services/mysql-import.md`
