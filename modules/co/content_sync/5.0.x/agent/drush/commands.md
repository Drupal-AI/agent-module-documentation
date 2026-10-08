<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Two commands, both batched (`drush_backend_batch_process()`), both interactive by default —
they print a change table and ask *"Do you want to import/export?"* unless `--skiplist` is passed.
Script them with `--skiplist` (and `-y` where Drush prompts).

## `content-sync:export` (aliases `cse`, `content-sync-export`)

```bash
drush content-sync:export [label] [options]
```

`label` is a key of the `$content_directories` array in `settings.php` (default `sync`).

| Option | Values | Effect |
|---|---|---|
| `--entity-types` | comma list | Restrict to these entity types. **With `--force` the syntax is `type.bundle`** (e.g. `node.article`); without `--force` it is matched as a prefix against storage collection names (e.g. `node`). |
| `--uuids` | comma list | Only these entity UUIDs. |
| `--actions` | `create,update,delete` | Only these change kinds (ignored under `--force`). |
| `--files` | `none` \| `base64` \| `folder` | How file entities' payloads travel. Default `folder`. |
| `--include-dependencies` | flag | Also export entities referenced by the exported ones. |
| `--skiplist` | flag | Skip the change table + confirmation. |
| `--compare-dates` | flag | Use changed-date comparison when building the change list. |
| `--force` | flag | Ignore the snapshot/diff entirely and export straight from the entity storages (`accessCheck(FALSE)`), i.e. a full re-export. |

Without `--force` the command diffs `content.storage` (the `cs_db_snapshot` active storage)
against the sync directory and exports only what changed; if nothing differs it prints
*"Nothing to export, the active content is identical to the content in files."* and stops — that
message means "no diff", not "no content".

```bash
# Full first export of everything, non-interactive.
drush content-sync:export sync --force --skiplist

# Only articles and their referenced entities.
drush content-sync:export sync --force --entity-types=node.article --include-dependencies --skiplist

# Just two known entities, with file payloads inlined.
drush content-sync:export sync --uuids=1f0a…,9c22… --files=base64 --skiplist
```

## `content-sync:import` (aliases `csi`, `content-sync-import`)

```bash
drush content-sync:import [label] [options]
```

| Option | Values | Effect |
|---|---|---|
| `--entity-types` | comma list | Restrict to collections whose name starts with one of these. |
| `--uuids` | comma list | Only these entity UUIDs. |
| `--actions` | `create,update,delete` | Only apply these change kinds — e.g. import new/updated content but never delete. |
| `--skiplist` | flag | Skip the change table + confirmation. |
| `--compare-dates` | flag | Build the change list by comparing changed dates instead of content. |

Direction of the comparer is reversed relative to export (`sync` storage vs. active storage), so
the change list reads "what the files would do to this site". `create` + `update` entries are
imported; `delete` entries cause the matching entities to be deleted — pass
`--actions=create,update` if you want a purely additive import.

```bash
# Deploy content in CI.
drush content-sync:import sync --skiplist

# Additive only: never delete local content.
drush content-sync:import sync --actions=create,update --skiplist

# Bring in one entity someone exported for you.
drush content-sync:import sync --uuids=1f0a… --skiplist
```

## Notes for scripted deploys

- Nothing to import → the command logs a notice and exits 0, so a no-op deploy is not an error.
- Answering "no" to the confirmation throws `UserAbortException` (non-zero exit) — always pass
  `--skiplist` in CI.
- The commands are registered via `extra.drush.services` in `composer.json`
  (`drush.services.yml`, Drush `^10 || ^11`) with the Drush 11+ attribute-style class
  `Drupal\content_sync\Drush\Commands\ContentSyncDrushCommands`. If `drush list` does not show
  them, clear caches (`drush cr`) — Drush caches command discovery.
- Imports bypass entity access. `ContentImporter::validateEntity()` runs constraint validation
  **only for `user` entities** (it returns TRUE for everything else without validating); failures
  are logged to the `content_sync` channel. Do not rely on import to reject malformed YAML for
  nodes, terms, etc.
