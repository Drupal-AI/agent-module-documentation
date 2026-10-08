<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate Utils (migrate_utils) — agent index
**Records whether a core Migrate import/rollback is currently running (and which migration) in Drupal state.**

- **Version:** 1.0.x (release `1.0.1`)
- **Core:** `^10.3 || ^11`
- **Depends on:** `drupal:migrate`
- **How:** `EventSubscriber\MigrateEventSubscriber` listens to `PRE/POST_IMPORT` and `PRE/POST_ROLLBACK`; sets state `migrate_utils.migration_running` (bool) and `migrate_utils.active_migration` (migration id).
- **Read the state:**
  - Static: `Drupal\migrate_utils\MigrateState::isMigrationRunning()` / `::getActiveMigrationId()`.
  - Service: autowired `Drupal\migrate_utils\EventSubscriber\MigrateEventSubscriber::isMigrationRunning()`.
- **Surface:** API only — no routes, permissions, config or UI.

**Security:** No HTTP endpoints, no user input, no external/outbound calls, no permissions. Reads and writes only two Drupal state keys during migrate lifecycle events. No security findings.

See [api/state.md](api/state.md).
