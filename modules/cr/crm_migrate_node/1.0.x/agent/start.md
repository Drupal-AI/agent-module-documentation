<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Migration to CRM (crm_migrate_node) — agent index

UI builder that generates Migrate Plus migration config entities to move Drupal **nodes** into
**Drupal CRM** contacts and contact methods. Version **1.0.0-alpha1**, core `^11`.

- **Dependencies:** `crm` (drupal/crm ^1.0), `migrate_plus` (^6.0). No external libraries.
- **Permission:** `administer crm_migrate_node` (restricted). Both routes require it.
- **Provides:** two admin forms, three PHP hook implementations (attribute-based), one Drush command,
  a config-install migration group, and an optional recipe. No entity types, plugins, or config schema.

## Routes (crm_migrate_node.routing.yml)
- `crm_migrate_node.mapping_add` — `/admin/config/crm/node-migration/add` → `Form\AddForm`
  (pick node type + CRM contact type; also the module's `configuration` route).
- `crm_migrate_node.mapping_edit` — `/admin/config/crm/node-migration/{migration_id}` → `Form\EditForm`
  (edit label + field mapping table).

## What it creates
A parent `migrate_plus` Migration (source `content_entity:node`, destination `entity:crm_contact`,
tag/group `crm_migrate_node`) plus per-bundle **child** migrations (`{parent}__email`,
`__telephone`, `__address`; destination `entity:crm_contact_method`) linked via `migration_lookup`.

## Services & hooks
- `crm_migrate_node.menu_local_tasks_hooks` → `Hook\MenuLocalTasksHooks` (`hook_menu_local_tasks_alter`,
  injects dynamic per-migration tabs).
- `crm_migrate_node.migration_hooks` → `Hook\MigrationHooks` (`hook_migration_presave` /
  `hook_migration_delete`; invalidates the tabs cache tag and cascade-deletes child migrations).
- `crm_migrate_node.commands` (drush.services.yml) → `Commands\CrmMigrateNodeCommands`.

## Solution docs
- [Forms, routes & permission](config/mapping-forms.md) — Add/Edit forms and the field mapping table.
- [Generated migration structure](migrations/structure.md) — parent/child entities, contact methods, hooks.
- [Simpsons sample data](drush/simpsons-recipe.md) — the Drush generator and `crm_migrate_node_simpsons` recipe.
