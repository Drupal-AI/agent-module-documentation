<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Track Usages (track_usage) — agent index

Backend service + config-entity system that records which **target** entities are used by which
top-level **source** entities. The `track_usage.tracker` service descends a source entity's
fields, follows references via pluggable **Track** plugins, traverses intermediate
("traversable") entities, and records only the **source→target endpoint** (plus the traversal
path) in two DB tables. No end-user UI, **no public routes** — all routes are admin-only.

- Core requirement `^10.4 || ^11`. PHP `>=8.1`, `ext-dom`, `ext-pdo`. License GPL-2.0-or-later.
  Version 1.0.0-alpha7 (doc dir `1.x`). No hard Drupal module dependencies.
- **Configuration entity, settings form, routes & permission** →
  [config/settings.md](config/settings.md)
- **Services, hooks, schema, Drush, queue — how tracking actually works** →
  [api/services.md](api/services.md)
- **The two plugin types (Track, BlockTarget) and the shipped plugins** →
  [plugins/track.md](plugins/track.md)

## What it provides (from source)

- **Config entity** `track_usage_config` (`config_prefix: config`, class
  `src/Entity/TrackConfig.php`), admin routes under `/admin/config/system/usage-track`
  (collection, add, edit, delete) via `AdminHtmlRouteProvider`, `admin_permission =
  "administer track usage"`. Exported keys: `trackPlugins`, `activeRevision`,
  `realTimeRecording`, `source`, `traversable`, `target`.
- **Services** (`track_usage.services.yml`): `track_usage.tracker` (`TrackerInterface`),
  `Recorder` (`RecorderInterface` + `ReaderInterface`, an event_subscriber on
  `KernelEvents::RESPONSE`), `Updater` (`UpdaterInterface`, bulk rebuild), `EntityGuesser`
  (`EntityGuesserInterface`, resolves a URL string to a local entity), the two plugin managers,
  a `track_usage.logger` channel, and `Hook\RecordUsageHook`.
- **Two plugin types**: `Track` (`Plugin/TrackUsage/Track`, attribute
  `Drupal\track_usage\Attribute\Track`) — 11 shipped plugins; `BlockTarget`
  (`Plugin/TrackUsage/BlockTarget`, attribute `…\Attribute\BlockTarget`) — 3 shipped plugins.
- **Hooks** (`RecordUsageHook`, attribute-based with `#[LegacyHook]` shims in
  `track_usage.module`): `entity_insert`, `entity_update`, `entity_delete`,
  `entity_translation_delete`, `entity_revision_delete`, `comment_insert`.
- **Drush**: `track_usage:update <config> [--method=batch|queue|instant]`
  (`src/Drush/Commands/TrackUsageCommands.php`).
- **Queue worker** `track_usage` (`src/Plugin/QueueWorker/TrackUsageWorker.php`, cron 30s).
- **Two DB tables** `track_usage` + `track_usage_paths` (`track_usage.install`), plus
  `hook_track_usage_entity_guess()` API (`track_usage.api.php`).
- **Permission**: `administer track usage` (`track_usage.permissions.yml`).

## Terminology

- **Source** — top-level entity whose target usages are recorded (e.g. a node). Must be fieldable.
- **Traversable** — entity that is descended into but not itself recorded (e.g. media, paragraph).
- **Target** — entity whose usage is recorded against the source (e.g. a file, a term). Any entity
  type, even config.
