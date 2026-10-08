<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate source plugins

Sources are standard `@MigrateSource` plugins under `src/Plugin/migrate/source/`. An importer stores a
`plugin_id` + `configuration`; `EntityImporter::getMigrateSourceDefinition()` injects `importer_id` so the
source can load its owning `entity_importer` and derive `fields()` / `getIds()` from the field mappings.

## Class hierarchy

- **`EntityImportSourceInterface`** — adds import-form hooks (`buildImportForm`/`validate`/`submit`),
  `isValid()`, `isRequired()`/`setRequired()`, `runCleanup()`/`skipCleanup()`.
- **`EntityImportSourceBase`** (abstract, extends core `SourcePluginBase`) — injects `entity_type.manager`
  and reads the `entity_import.settings` config. Key methods:
  - `fields()` — labels keyed by each field mapping's `name()`.
  - `getIds()` — builds the migration ID map from the importer's unique identifiers; `identifier_settings`
    is a JSON string decoded with `JSON_THROW_ON_ERROR` (bad JSON silently ignored).
  - `getEntityImporter()` / `getImporterId()` — loads the importer from the required `importer_id` directive
    (throws `MigrateException` if absent).
- **`EntityImportSourceLimitIteratorBase` / `…Interface`** — wrap the concrete iterator with an
  `\AppendIterator`/limit-iterator for paging (`limitedIterator()`).

## CSV source — `EntityImportSourceCSV` (id `entity_import_csv`, label "CSV")

Extends `EntityImportSourceLimitIteratorBase`, implements core `RequirementsInterface`. Parsing uses
**`league/csv`** (`League\Csv\Reader`).

- **Import form** (`buildImportForm`): a `managed_file` element `file_id` with
  `#upload_validators => ['FileExtension' => ['extensions' => 'csv']]`, `#multiple` when
  "Upload multiple files" is on, `#required` when the source is required, `#upload_location` from
  `getUploadTemporaryUri()` (the `temporary_uri` setting, else core default temp).
- **Validate** (`validateImportForm`): stashes `file_id`, builds the iterator, reads the header row, and
  errors if the importer's unique identifiers are missing from the CSV header
  (`getMissingUniqueIdentifiers()`).
- **Config form** (`buildConfigurationForm`): `upload_multiple` checkbox and an `encoding` from/to select
  pair (options from `mb_list_encodings()` minus `pass`/`auto`).
- **Iterator** (`buildFileIterator`): for each loaded managed file, `Reader::from($fileUri)` with
  `setHeaderOffset(0)` and delimiter `,`; when from/to encoding differ it appends an
  `convert.iconv.<from>/<to>` stream filter on read (failures logged via `Error::logException`). Empty
  rows are skipped in `current()`.
- **Requirements/validity**: `isValid()`/`checkRequirements()` require a `file_id` in configuration.
- **Cleanup** (`runCleanup`): deletes the uploaded `file` entities after import unless `skipCleanup` is set;
  invoked by `EntityImportSubscriber` on POST_IMPORT.

Files are loaded through the core `file` storage by ID and read only via `$file->getFileUri()` — the source
never fetches a remote or request-supplied path/URL.

## Discovering sources

`entity_import.source.manager` (`EntityImportSourceManager`, wraps the core migrate source + migration
plugin managers) enumerates available source plugins for the importer add/edit form.
