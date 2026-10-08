<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Batch Import — built-in migration services & the id-map table

Migration services (`src/BatchMigrationServices/`) hold reusable import logic and are auto-registered
as container services `batch_import.migration.<id()>` (compiler pass `BatchImportServicePass`). A
migration receives `db_table` always, plus the service whose id matches its `entity_type` and
`origin`, plus any listed in its `services` annotation. Reach them via `$this->service('<id>')`.

## The id-map table (`db_table` — `LocalDatabaseTableService`, always injected)

- id `db_table`, ctor arg `database`. Backs the `batch_import` table (`hook_schema` in
  `batch_import.install`): columns `eid` (source id), `eid_new` (created entity id), `uuid`, `type`
  (dest entity type), `bundle`, `origin`, `is_referenced`.
- `save($source_id, $dest_id, $type, $bundle, $origin)` inserts a map row (called by
  `BatchMigrationBase::saveEntity()`); `load(...)` returns dest ids for a source id;
  `loadSource(...)` reverses it; `delete($dest_id, $type)`; `setEntityAsReferenced(...)` flags
  media/file rows in use. All queries use parameter binding.
- `hook_entity_delete()` (`batch_import.module`) calls `db_table->delete()` so a deleted entity's map
  row is removed.

## Entity services (extend `EntityMigrationServiceBase`)

`EntityMigrationServiceBase` (ctor args `batch_import.migration.db_table`, `entity_type.manager`)
provides `checkForExisting()` / `loadEntity()` (look up an existing dest entity via the id-map,
setting `$data['is_new']`) and `getEntity()` (load-or-create; sets `$data['is_new']`). Subclasses
override `id()`, `entityTypeId()`, `storage()`, `new()`, `load()`, `save()`, and optionally
`initEntity()`.

- **`node`** (`NodeMigrationService`) — id key `nid`; also injects `batch_import.migration.user`.
  `new()` creates a node with `type=bundle`, `status`, `created`, and `uid` resolved from
  `$data['uid']` via the user service (falls back to uid 1). `initEntity()` re-resolves the author,
  sets `created`, `title`, and maps `status == 1` to `moderation_state = published`.
- **`user`** (`UserMigrationService`) — id key `uid`. `new()` creates a user from `name`, `pass`,
  `mail`, `status`, timestamps, etc. `save()` saves then calls `updateUserPassword($data['pass'], uid)`,
  which writes the given value **directly** into `users_field_data.pass` (intended for carrying over
  an already-hashed password from the source). `checkForExisting()` also matches by existing username
  (`entityQuery('user')->accessCheck(FALSE)->condition('name', ...)`). `getDummyUser($email)`
  loads-or-creates a placeholder user by email.
- **`taxonomy_term`** (`TermMigrationService`) — id key `tid`. `new()` sets `name`, `vid`
  (`$data['vocabulary']`), and a `description` in `full_html`. Helpers: `getTidByName()`,
  `setTermFieldByName()`, `getTermData()` / `loadMultipleTermField()` (query terms from a source
  connection). Term description is stored with the `full_html` text format.
- **`media`** (`MediaMigrationService`) — id key `mid`. `new()` creates media (`bundle`, optional
  `uuid`). `setMediaField()` loads an existing media by source fid, flags it referenced in the id-map,
  and sets it on a field of the parent entity.
- **`file`** (`FileMigrationService`) — id key `fid`. `new()` creates a `File` from `uri`, `uid`,
  status `STATUS_PERMANENT`. Files must already exist under the files directory (README) — no
  fetching/copying is done.
- **`paragraph`** (`ParagraphMigrationService`) — id key `pid`. `new()` creates a paragraph of
  `type = bundle`. (Needs the contrib Paragraphs module to be usable.)

## Writing your own

Extend `MigrationServiceBase` (or `EntityMigrationServiceBase`), implement static `id()` and static
`serviceArguments()` (container ids passed to the constructor), place it in your module's
`src/BatchMigrationServices/`, rebuild the container (`drush cr`) so the compiler pass registers it,
then inject it by adding its id to a migration's `services` annotation.

## `MigrationActivationService` programmatic entry points

Besides driving the form: `getData($plugin_id)` (run a migration's `processSource()`),
`processData($plugin_id, $row)` (run `processDestination()`), and `runMigrationPlugins($ids)` (run
migrations immediately, no queue/batch — source then per-row destination).
