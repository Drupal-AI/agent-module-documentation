<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reading migration state

Two state keys are maintained by `MigrateEventSubscriber` during core Migrate runs:

| Key | Type | Meaning |
|---|---|---|
| `migrate_utils.migration_running` | bool | TRUE between PRE and POST of an import or rollback |
| `migrate_utils.active_migration` | string\|null | id of the migration currently running (deleted on POST) |

## From procedural code (hooks)
```php
use Drupal\migrate_utils\MigrateState;

if (MigrateState::isMigrationRunning()) {
  // e.g. skip notifications / heavy derivative work
  $id = MigrateState::getActiveMigrationId();
}
```

## From a service (DI)
```php
public function __construct(
  private readonly \Drupal\migrate_utils\EventSubscriber\MigrateEventSubscriber $migrateSubscriber,
) {}

if ($this->migrateSubscriber->isMigrationRunning()) { /* ... */ }
```

Both read the same underlying `\Drupal::state()` keys, so they agree. The flag is TRUE for imports *and* rollbacks; use `getActiveMigrationId()` if you need to know which migration.
