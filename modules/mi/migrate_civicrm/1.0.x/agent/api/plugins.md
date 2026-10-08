<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate CiviCRM plugins

Requires CiviCRM (the `civicrm` service). Use in a migration YAML.

**Source** — `Plugin/migrate/source/CiviCrmApi4` (id typically `civicrm_api4`): iterates CiviCRM API v4 `get` results via `Api4Iterator`.

**Destination** — `Plugin/migrate/destination/CiviCrmApi4` (service `civicrm_migrate_dest.destination.api4`, arg `@civicrm`): creates/updates CiviCRM records through API v4. `NoOp` destination is available for lookup-only runs.

Run with core Migrate / migrate_tools:

```bash
drush migrate:import <migration_id>
drush migrate:rollback <migration_id>
```

Inspect `src/Plugin/migrate/source/CiviCrmApi4.php` for the exact source config keys (entity, action, params) before authoring a migration.
