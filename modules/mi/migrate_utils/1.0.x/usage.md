<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Migrate Utils is a small developer helper for Drupal core's Migrate module that records whether a migration is currently running and which one, in Drupal state, via an event subscriber.

---

The module subscribes to the four migrate lifecycle events (`PRE_IMPORT`, `POST_IMPORT`, `PRE_ROLLBACK`, `POST_ROLLBACK`). On pre-import and pre-rollback it sets `migrate_utils.migration_running` to TRUE and stores the active migration id in `migrate_utils.active_migration`; on the matching post event it flips the flag back to FALSE and deletes the active-migration key. Other code — hooks, event subscribers, entity presave logic — can then branch on migration context, e.g. to skip expensive derivative work, suppress notifications, or avoid re-entrancy while a migration is importing.

There are two ways to read the state. The static convenience class `Drupal\migrate_utils\MigrateState` exposes `isMigrationRunning()` and `getActiveMigrationId()` (reads `\Drupal::state()` directly, handy from procedural hook code). The autowired service `Drupal\migrate_utils\EventSubscriber\MigrateEventSubscriber` also has an `isMigrationRunning()` method if you prefer dependency injection. The module ships no routes, no permissions, no config and no UI — it is purely an API. Security surface is nil: no HTTP endpoints, no user input, no external calls; it only reads/writes two Drupal state keys during migrate runs. Setup is just `composer require drupal/migrate_utils` and enabling it; nothing to configure.

---
- Detect whether any migration is currently running from custom code
- Get the id of the migration that is currently importing/rolling back
- Skip expensive `hook_entity_presave` logic during a migration
- Suppress email/notifications while content is being migrated
- Avoid search-index or cache rebuilds mid-migration
- Prevent re-entrant processing triggered by migration-created entities
- Read migration state statically via `MigrateState::isMigrationRunning()`
- Read the active migration id via `MigrateState::getActiveMigrationId()`
- Inject `MigrateEventSubscriber` and call `isMigrationRunning()`
- Branch behavior in a `hook_ENTITY_TYPE_insert` when migrating
- Gate a queue/derivative build so it only runs outside migrations
- Tag log entries with the active migration id
- Base a Views/computed-field decision on migration context
- Coordinate multi-module logic that must pause during imports
- Use the two state keys (`migrate_utils.migration_running`, `migrate_utils.active_migration`) directly if needed
- Provide migration-awareness without patching core Migrate
