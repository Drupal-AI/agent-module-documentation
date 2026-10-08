<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands: migrate / gc / audit

Class `Drupal\atomic_cas\Commands\CasCommands` (`src/Commands/CasCommands.php`), registered by
`drush.services.yml` (service `atomic_cas.commands`, tag `drush.command`) with deps
`@atomic_cas.manager`, `@entity_type.manager`, `@file_system`. All commands use Drush attribute
routing (`#[CLI\Command]`).

## `atomic-cas:migrate` (alias `acas-migrate`)

Migrates every eligible `public://` / `private://` `file_managed` row into CAS
(`AtomicCasManager::findEligibleForMigration()`), mapping `public://`→`cas-public`, `private://`→
`cas-private`.

- `--dry-run` — list what would migrate; no changes.
- Each file is processed independently: a missing source is skipped (logged); a failed ingest is
  logged, its map row rolled back via `deleteMapping($fid)`, and processing continues. Ends with a
  `Migrated / Skipped / Failed` summary.
- **Original source files are NOT deleted** by migrate — remove them manually once satisfied. (Note:
  the *auto-ingest* UI path in `AtomicCasHooks` does delete the original; the Drush migrate path does
  not.)

```bash
drush atomic-cas:migrate --dry-run   # preview
drush atomic-cas:migrate             # run
```

## `atomic-cas:gc` (alias `acas-gc`)

Deletes blobs no longer referenced by any live file entity (`findOrphanedBlobs()` — LEFT JOIN of
`atomic_cas_blob` against live `atomic_cas_map`↔`file_managed` pairs).

- `--dry-run` — list orphans (scheme, short hash, size, MIME) + totals; deletes nothing.
- `--csv=/path` — write the orphan list to CSV; **implies dry-run** (never deletes).
- No flag — deletes each orphan via `AtomicCasManager::deleteBlob()`; reports `Deleted / Errors / Freed`.

```bash
drush atomic-cas:gc --dry-run
drush atomic-cas:gc --dry-run --csv=/tmp/orphans.csv
drush atomic-cas:gc
```

## `atomic-cas:audit` (alias `acas-audit`)

Verifies every mapped blob (`getAllMappings()`).

- No flag — checks `blobExists()` for each mapping; counts OK / Missing.
- `--rehash` — additionally re-computes SHA-256 of each blob (`hashFile()`) and compares to the stored
  hash, catching silent corruption (bit rot, truncation) → OK / Missing / Corrupt. Slower.

```bash
drush atomic-cas:audit
drush atomic-cas:audit --rehash
```

Recommended migration flow: configure roots → `migrate --dry-run` → `migrate` → `audit --rehash` →
check `/admin/reports/status` and `/admin/reports/atomic-cas` → remove original sources.
