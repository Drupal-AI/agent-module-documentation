<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services, hooks, schema, Drush & queue

Autowired services (`track_usage.services.yml`). Query usage data through the interfaces; do not
touch the tables directly.

## Tracker — `track_usage.tracker` (`TrackerInterface`, `src/Tracker.php`)

`track(EntityInterface $entity, TrackConfigInterface $config): UsageCollection`. If the entity is
a source for the config, `doTrack()` walks its fields:

- For each non-empty field whose type is applicable (from the enabled Track plugins), it asks each
  applicable Track plugin for `getTargetEntities($itemList)`.
- Each returned entity that `isTarget()` is added to the `UsageCollection` with the current path;
  each that `isTraversable()` is recursed into, appending the entity's key to the path.
- Recursion guards: a per-call `visited` map stops cycles, and paths deeper than **20** are
  dropped with a `track_usage.logger` warning. Entity "keys" are `type:id:revision` triples
  (`EntityUtilityTrait`).

## Recorder / Reader — `Recorder` (`RecorderInterface` extends `ReaderInterface`, `src/Recorder.php`)

An **event subscriber** on `KernelEvents::RESPONSE`. `record()` merely queues affected source and
traversable entity keys in memory; `registerUsageRecords()` runs after the response is built:
`processTraversables()` re-queues any source whose path contained a changed traversable, then for
each queued source it deletes that source+config's existing rows and re-inserts fresh usage rows
(one per translation) via `createUsageRecord()`. `cleanup()` handles delete/revision-delete/
translation-delete, plus config-entity and language deletions.

Reader methods for consumers:

- `getTargetsForEntity(FieldableEntityInterface $entity, string $targetEntityTypeId,
  TrackConfigInterface $config): iterable` — target IDs used by a source or traversable entity.
- `getPathsToTarget(EntityInterface $target, TrackConfigInterface $config): array` — list of
  paths (each a list of `[type, id, revision]` triples) leading to a target.

All DB access uses the Drupal query builder with parameterized `Condition` objects; IDs are split
across integer/string columns (`IdColumnTrait`) so both int- and string-keyed entities work.

## Real-time recording — `Hook\RecordUsageHook` (`src/Hook/RecordUsageHook.php`)

Attribute hooks (`#[Hook(...)]`), with `#[LegacyHook]` procedural shims in `track_usage.module`:

- `entity_insert` / `entity_update` → `record()`: for each **enabled config with
  `realTimeRecording = TRUE`**, if the entity matters and (for active-revision configs) is the
  default revision, queue it.
- `entity_delete` / `entity_translation_delete` / `entity_revision_delete` → `Recorder::cleanup()`.
- `comment_insert` → `onCommentInsert()`: a new comment references its commented entity, which is
  not itself re-saved, so the commented source entity is re-queued to pick up the new usage.

Configs with `realTimeRecording = FALSE` are only (re)built by a bulk update.

## Bulk rebuild — `Updater` (`UpdaterInterface`, `src/Updater.php`)

`update(BulkUpdateMethod $method, TrackConfigInterface $config)` first calls
`Recorder::cleanup($config, Operation::Delete)` (wipes the config's rows) then dispatches by
method:

- **batch** — a `BatchBuilder`; source IDs chunked (50) into `recordUsages()` operations.
- **queue** — items (chunks of 10) pushed to the `track_usage` queue, processed on cron.
- **instant** — loads and records everything immediately (only for small data / testing).

Source entities are found by an entity query with `accessCheck(FALSE)` (correct here — it must see
all content regardless of the acting user), optionally across all revisions and filtered by the
configured source bundles.

## Drush & queue

- `TrackUsageCommands::update()` — `drush track_usage:update <config> [--method=batch|queue|instant]`
  (default batch). Validates the method and that the config exists, then calls the Updater; runs
  the batch when method is batch.
- `TrackUsageWorker` (`#[QueueWorker(id: 'track_usage', cron: ['time' => 30])]`) — loads the queued
  entities/revisions and calls `Recorder::record()`; malformed items are ignored.

## EntityGuesser — `EntityGuesserInterface` (`src/EntityGuesser.php`)

`guessFromUrl(string $url): ?EntityInterface` resolves a link/href string to a **local** entity so
link-based Track plugins (HTML links, Linkit, CKEditor image) can record targets. It rejects
malformed URLs, disallowed schemes, and any host that is not a local stream wrapper — URLs
pointing at other sites return NULL. It resolves via the router (`router.no_access_checks`), local
file stream wrappers, and optionally the Redirect module, and finally lets
`hook_track_usage_entity_guess($url, $langcode)` supply a custom match. It **does not fetch remote
content** — `Request::create()` only builds a request object for inbound path processing.

## Schema (`track_usage.install`, `hook_schema`)

- **`track_usage`** (`RecorderInterface::TABLE`): one row per source→target usage. Columns:
  `tid` (serial PK), `config`, `source_type`, `source_id_int`, `source_id_string`,
  `source_langcode`, `source_revision`, `target_type`, `target_id_int`, `target_id_string`.
  Unique key `track` over all non-tid columns; indexes on source/target type+id.
- **`track_usage_paths`** (`RecorderInterface::TABLE_PATHS`): the traversal path(s) for each usage.
  Columns: `tid`, `path`, `delta`, `type`, `id`, `revision`; FK `tid → track_usage.tid`.
- Update hooks `8001`–`8004` migrate an older single-table layout: add the serial `tid`, create
  `track_usage_paths`, migrate the JSON `meta` column into it, then drop `meta`.

## API hook (`track_usage.api.php`)

`hook_track_usage_entity_guess(Url $url, ?string $langcode): ?EntityInterface` — return an entity
for a URL the built-in guesser could not resolve, or NULL.
