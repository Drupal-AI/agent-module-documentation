<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, working tables & planning/purge flow

All services are defined `public: true` in `fast_revision_purge.services.yml` and share the
`logger.channel.fast_revision_purge` channel. All are plain services (no interfaces/plugin types).

## Working tables & stats (`fast_revision_purge.install`)

`hook_schema()` creates InnoDB working tables and a singleton stats table; `hook_install()` inserts
`fastrev_stats` row `id = 1`.

- `fastrev_node_keep(vid)`, `fastrev_node_delete(vid)` — node revision ids to keep / delete.
- `fastrev_par_in_use(rid)`, `fastrev_par_delete(rid)` — paragraph revision ids in use / to delete.
- `fastrev_lb_keep(rid)`, `fastrev_lb_delete(rid)` — Layout Builder revision ids to keep / delete.
- `fastrev_stats` (id=1): `total_node_revisions_deleted`, `total_para_revisions_deleted`,
  `total_lb_revisions_deleted`, `space_freed_last_run`, `space_freed_total`, `potential_claimable_space`
  (NULL = never planned), `last_dryrun_timestamp`, `last_purge_timestamp`.

## RevisionTableMap (`fast_revision_purge.table_map`)

`build()` discovers revision **field** tables from `EntityFieldManager` field-storage definitions
(`node_revision__<field>`, `paragraph_revision__<field>` for revisionable fields), flags
`entity_reference_revisions` fields whose `target_type === 'paragraph'` as ERR edge tables, and unions any
orphan `node_revision__%` / `paragraph_revision__%` tables found via `information_schema` (filtered to
`^[A-Za-z0-9_]+$`). Paragraph tables are only included when the `paragraphs` module is enabled. Getters:
`getNodeRevisionFieldTables()`, `getParagraphRevisionFieldTables()`, `getNodeErrParagraphTables()`,
`getParagraphErrParagraphTables()`, `getLayoutBuilderRevisionFieldTableName()`.

## Planner (`fast_revision_purge.planner`) — dry run

`plan($keepLast, ?$since, $protectPublished, $perLanguage, $keepParagraphLast)`:

1. `resetWorkingTables()` truncates all working tables.
2. Parses `$since` via `DateTimeImmutable::createFromFormat('Y-m-d', …)` (throws `InvalidArgumentException` if
   invalid) to a UNIX cutoff.
3. `planNodeKeep()` seeds keep set from current vids in `node_field_data`, then keeps revisions newer than the
   cutoff, the latest published per node (`ROW_NUMBER()` over `nid`), and the latest N per node or per
   `(nid, langcode)`.
4. `planNodeDelete()` stages every node revision not kept and not current.
5. `computeParagraphInUse()` marks paragraph revisions referenced by kept node revisions (first hop) and walks
   nested paragraph ERR edges with a bounded BFS (max 50 passes).
6. `planParagraphDelete()` protects current/default paragraph pointers, keeps last M per paragraph entity, and
   stages the rest.
7. `planLayoutBuilderKeepDelete()` keeps LB rows whose `revision_id` = current `node_field_data.vid`, stages the
   rest.
8. Estimates reclaimable bytes (`avg_row_size * rows_to_delete` from `information_schema`) and persists via
   `StatsStorage::updateAfterDryRun()`.

Keep/limit counts (`$keepLast`, `$keepParagraphLast`, cutoff) are bound query parameters (`:n`, `:m`,
`:cutoff`). Table/column names come from entity definitions or `information_schema`. Both D10
(`paragraphs_item_*`) and D11 (`paragraph_*`) schemas are handled by runtime introspection.

## Purger (`fast_revision_purge.purger`) — execute

`purge(int $chunk, int $sleepMs): PurgeResult`. Deletes **paragraphs first, then nodes**, and within each,
**field-revision tables before the core revision table**. Per chunk it loads up to `$chunk` ids from the
`fastrev_*_delete` working table, deletes via `deleteIn($table, $field, $ids, $count)` (an `IN (...)` list of
bound, `(int)`-cast placeholders), then removes those ids from the working table and optionally sleeps.
`rowCount()` yields accurate counts; bytes freed are estimated from `information_schema` average row sizes and
persisted via `StatsStorage::updateAfterPurge()`. Returns a `PurgeResult` DTO
(`nodeRevisionsDeleted`, `paragraphRevisionsDeleted`, `layoutBuilderRowsDeleted`).

## IndexManager (`fast_revision_purge.index_manager`)

`ensureHelpfulIndexes()` adds idempotent indexes on node/paragraph core + field revision tables and ERR target
columns. `safeAddIndex()` skips missing tables/existing indexes and swallows errors as warnings.
`addIndexCompat()` tries the mysql 4-arg / core 3-arg `Schema::addIndex()` signatures, then falls back to raw
`ALTER TABLE ... ADD INDEX` — but only after validating every table/index/column identifier against
`^[A-Za-z0-9_]+$`. Index names are fixed literals (e.g. `fastrev_nrev_nid_ts_vid`).

## Dedicated truncators

- **LayoutBuilderRevisionTruncator** (`fast_revision_purge.lb_truncator`): `plan($keepLast)` /
  `execute($chunk, $keepLast)` delete non-current rows from `node_revision__layout_builder__layout` (join to
  `node_field_data`), one chunk per call, via a temporary candidate table. `keep_last > 0` needs MySQL 8+ window
  functions (falls back to 0 otherwise). Deadlock/serialization errors (1213/40001) get up to 5 retries with
  backoff.
- **ParagraphRevisionTruncator** (`fast_revision_purge.paragraph_truncator`): `plan()` / `execute($chunk)`
  detect the paragraph base/revision tables (entity definition, then legacy fallback), stage non-current
  `revision_id`s into a temp table, and delete from the meta revision table plus all discovered paragraph
  field-revision tables inside a per-chunk transaction. `discoverFieldRevisionTables()` filters names to
  `^[A-Za-z0-9_]+$`.

## Helpers

- **TableStats** (`fast_revision_purge.table_stats`): `getDatabaseSizeBytes()`, `getTopTables($limit)`,
  `getTableSizeBytes()`, `getAverageRowSize()`, `getRowCount()`, static `humanBytes()`. Reads
  `information_schema` (MySQL/MariaDB oriented).
- **StatsStorage** (`fast_revision_purge.stats`): `get()`, `updateAfterDryRun()`, `updateAfterPurge()` on the
  singleton `fastrev_stats` row via `merge()`.
- **DbPlatform** (`fast_revision_purge.db_platform`): thin wrapper exposing `driver()`; a seam for future
  platform branching.
