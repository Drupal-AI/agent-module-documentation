<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Definition Update (entity_definition_update) — agent index

Developer/deployment helper. Provides **one service** whose `applyUpdates()` applies pending
entity-type and field storage definition (schema) changes to the database, called from your own
`hook_install()` / `hook_update_N()`. Alternative to core's Entity Definition Update Manager
(which no longer applies definition updates automatically). Depends on core **`system`**, **`field`**.
Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.2.0.

- **The service, `applyUpdates()`, the update/delete loop, the data-migration guard, and how to
  call it from an update hook** → [api/update-manager.md](api/update-manager.md)

## What it actually is (from source)

- Service `entity_definition_update.entity_definition_update_manager` →
  `src/EntityDefinitionUpdateManager.php` (`Drupal\entity_definition_update\EntityDefinitionUpdateManager`).
  Constructor-injected with core `entity.definition_update_manager`,
  `entity.last_installed_schema.repository`, `entity_type.manager`, `entity_type.listener`,
  `entity_field.manager`, `field_storage_definition.listener` (see `*.services.yml`).
- Public method **`applyUpdates()`**: reflects into core's protected `getChangeList()`, clears
  cached entity type / field definitions when changes exist, then applies entity-type changes
  (`doEntityUpdate()`) and field storage changes (`doFieldUpdate()`) via core listeners.
- `src/EntityTypeDefinitionServiceProvider.php` (`ServiceProviderBase`) auto-registers every PHP
  class under `src/` as an **autowired** service keyed by FQCN, unless already defined.

## What it is NOT

- **No routes, no forms, no controllers** (no `*.routing.yml`).
- **No permissions** (`provides_permissions: false`), **no Drush commands**, **no hooks**
  (`.module`/`.install`), **no config** (`config/` absent; `provides_config_schema: false`).
- Not invoked from the web UI — used only from update/deployment code run via `drush updatedb`
  / `update.php`, an already-privileged maintenance context.
