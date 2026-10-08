<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Defined in `src/Commands/A12sMapsSyncCommands.php` (registered via `drush.services.yml`,
constructor args `@a12s_maps_sync.auto_config_manager`, `@lock`). All command names are
`a12s_maps_sync:*`; aliases in parentheses.

## Import

| Command (alias) | Args / key options | Effect |
|---|---|---|
| `a12s_maps_sync:import:profile` (`amsip`) | `<profile>`; `--limit --force --all --batch-no-track --do-not-process --force-queue` | Import a whole profile. Default path queues the profile in `State` then processes; `--batch-no-track` runs a direct Drupal batch under the profile lock; `--all` forces a full reimport first. |
| `a12s_maps_sync:import:converter` (`amsic`) | `<converter>`; same options | Import a single converter. |
| `a12s_maps_sync:import_entity` (`amsie`) | `<entityType> <entityId>`; `--profile --converter --with-dependencies` | Push one existing Drupal entity back through the mapping. |
| `a12s_maps_sync:import_object` (`amsio`) | `<objectId> <converterId>`; `--with-dependencies` | Import a single MaPS object/media by its MaPS id. |

## Reimport / rollback

| Command (alias) | Args | Effect |
|---|---|---|
| `a12s_maps_sync:force_profile_reimport` (`amsfpr`) | `<profile>` | Reset last-imported time on every converter (next import is full). Fails if a batch is already set. |
| `a12s_maps_sync:force_converter_reimport` (`amsfcr`) | `<converter>` | Same, one converter. |
| `a12s_maps_sync:rollback:profile` (`amsrp`) | `<profile>` | Delete everything imported by the profile's converters (confirm prompt). |
| `a12s_maps_sync:rollback:converter` (`amsrc`) | `<converter>` | Delete everything imported by one converter. |

## Auto-config

| Command (alias) | Args | Effect |
|---|---|---|
| `a12s_maps_sync:auto_config_converter` (`amsacc`) | `<converter>` | Run `AutoConfigManager::processConverter()` for the converter's attribute sets. |
| `a12s_maps_sync:auto_config_profile` (`amsacp`) | `<profile>` | Run `manageAttributeSets()` for each converter of the profile. |

## Batch / state / locks

| Command (alias) | Effect |
|---|---|
| `a12s_maps_sync:batch:process` (`amsbp`) | Process the queued state batch (`--force --limit`). Refuses to run while Drupal cron is running. |
| `a12s_maps_sync:batch:status` (`amsbs`) | Show the current `State` (warns if cron is running). |
| `a12s_maps_sync:batch:flush_state` (`amsbfs`) | Reset the whole `State` (confirm). |
| `a12s_maps_sync:batch:kill` (`amsbk`) | Delete a batch + its queue rows by batch id (confirm). |
| `a12s_maps_sync:release_lock` (`amsrl`) | `<profile>` — delete the profile's import lock. |
| `a12s_maps_sync:list_locks` (`amsll`) | List each profile's current lock timestamp. |

## Typical scheduled sync

```bash
# Cron / deploy: queue and process a profile, honoring differential import + lock.
drush a12s_maps_sync:import:profile my_profile
# Recover a stuck run:
drush amsbs           # inspect state
drush amsrl my_profile  # release the lock
drush amsbp --force   # reprocess
```

Locking is per profile (state key `a12s_maps_sync:lock:profile:<python_profile_id>`); set
`a12s_maps_sync.settings:ignore_lock` or pass `--force` to bypass it.
