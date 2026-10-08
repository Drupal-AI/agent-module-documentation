<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity IO Purge (entity_io_purge) — agent index

Submodule of **Entity IO**. Deletes files from the Entity IO export storage directory. Depends on
`system`, `entity_io`. Core `^10 || ^11`. `configure` route `entity_io_purge.settings`. No
permissions.yml (admin uses `administer site configuration`); no config schema, no plugin type.

## Mechanism (from source)

- **`PurgeService`** (`src/Service/PurgeService.php`, args `@config.factory`, `@file_system`,
  logger, `@state`):
  - `purge()` — cron-driven; runs only when `entity_io_purge.settings.auto_purge` is on and enough
    time has passed (`purge_frequency` = `daily`/`weekly`/`monthly`), then calls
    `ExportDirectory::clearFiles()` and records `state('entity_io_purge.last_run')`.
  - `manualPurge()` — clears all export files immediately, ignoring frequency.
  - `purgeByEntityTypes(array $entity_types)` — clears all (`['*']`) or per-type.
- **`PurgeController`** (`src/Controller/PurgeController.php`) — `purgeForm`/`purgeConfirm`/`purge`
  admin actions.
- **Forms** (`src/Form/`): `PurgeSelectionForm` (choose scope), `PurgeConfirmForm` (confirm),
  `PurgeSettingsForm` (writes `entity_io_purge.settings`: `auto_purge`, `purge_frequency`).

## Routes (`entity_io_purge.routing.yml`) — all `administer site configuration`

| Route | Path |
|---|---|
| `entity_io_purge.form` | `/admin/config/entity-io/purge` |
| `entity_io_purge.settings` | `/admin/config/entity-io/purge/settings` |
| `entity_io_purge.confirm` | `/admin/config/entity-io/purge/confirm` |
| `entity_io_purge.execute` | `/admin/config/entity-io/purge/execute` |
