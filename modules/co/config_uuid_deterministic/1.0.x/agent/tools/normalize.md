<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: cud:normalize (config-uuid-deterministic:normalize)

Backfills existing random config UUIDs to their deterministic UUIDv5 values. Needed
only when enabling the module on a site that already has config with random UUIDs
(new config gets deterministic UUIDs automatically via the storage decorators/hooks).

Defined in `src/Commands/ConfigUuidDeterministicCommands.php`; logic in
`ConfigUuidNormalizer::normalizeStorage()`. CLI-only (no route/web trigger).

## Usage

```bash
drush cud:normalize                       # normalize active storage
drush cud:normalize --dry-run             # preview only, no writes
drush cud:normalize --pattern='views.view.*'   # glob-filter config names (fnmatch)
drush cud:normalize --include-sync        # also rewrite config/sync files
```

| Option | Effect |
|--------|--------|
| `--dry-run` | Report changed configs/paths; write nothing. |
| `--pattern=<glob>` | Only process config names matching the `fnmatch` glob. |
| `--include-sync` | Also normalize the sync file storage (`config.storage.sync`). |

## Behavior

- Iterates `storage->listAll()`, reads each config, runs
  `ConfigUuidNormalizer::normalizeItem('default', $name, $data)`:
  - skips `system.site` (and skip-list entries);
  - if a root `uuid` exists, replaces it with `Uuid::uuid5(NS, $name)`;
  - remaps nested plugin `[id, uuid]` pairs via `ConfigUuidRemapper::remapNested()`.
- Only writes configs whose data actually changed; reports each with its changed paths.
- **Idempotent** — a second run reports no changes.
- On a non-dry run with changes it calls `drupal_flush_all_caches()`.
- Prints a warning to export/commit current config first.

## Operational notes

- Rewriting UUIDs en masse is a config-integrity operation: it changes the identity of
  config entities in active (and optionally sync) storage. Export + commit + review the
  diff before and after (README's "Enabling on an Existing Site" flow). Intended to be
  run by an operator with CLI/admin access.
- `system.site:uuid` is deliberately left alone; align it across environments manually
  if config import requires it (see README "Aligning Site UUID Across Environments").
- Note: warning strings in `FieldTableNameChecker` mention a `drush cud:fix-tables`
  command — that command is **not** implemented in this release; only `cud:normalize` exists.
