<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Changelog (entity_changelog) — agent index

Auto-logs **create / update / delete (CUD)** operations on entities into a content entity, and ships a
**Views page** to browse them. Package `Custom`. Depends only on core **`views`**. Core `^10 || ^11`,
PHP `^8.1`. License GPL-2.0-or-later. Version 1.2.0. No settings form (`configure = null`), no config schema.

- **How changes are captured & stored** (hooks, service, entity, retention/cron) →
  [api/logging.md](api/logging.md)
- **The log page, Views config, fields, filters, access** →
  [views/log-view.md](views/log-view.md)

## What it actually is

- **Hooks** (`entity_changelog.module`): `hook_entity_insert/update/delete` each call
  `EntityChangelogLogger::addEntry($entity, EntityChangelogOperation::INSERT|UPDATE|DELETE)`.
  `hook_cron` calls `deleteOldEntries()`. `hook_views_pre_build` populates grouped exposed-filter
  options for the `entity_changelog` view.
- **Service** `entity_changelog.entity_changelog_logger` → `Drupal\entity_changelog\Services\EntityChangelogLogger`
  (args: `entity_type.manager`, `entity_changelog.logger`, `current_user`, `request_stack`, `database`).
  Plus logger channel `entity_changelog.logger`.
- **Entity** `entity_changelog_entry` (`ContentEntityType`, base table `entity_changelog_entry`),
  in `src/Entity/EntityChangelogEntry.php`. Base fields: `entity_type`, `entity_id`, `entity_title`,
  `timestamp`, `user_id`, `username`, `request_path`, `operation`. Handlers: `EntityChangelogEntryViewBuilder`,
  `EntityChangelogEntryViewsData`, access `EntityChangelogEntryAccessControlHandler`.
- **Enum** `Drupal\entity_changelog\Type\EntityChangelogOperation` — `insert`, `update`, `delete`.
- **Permission** (`entity_changelog.permissions.yml`): `access entity changelog` (`restrict access: true`).
- **Views page** (`config/install/views.view.entity_changelog.yml`): view id `entity_changelog`, path
  `admin/entity_changelog`, under the `admin` menu (parent `system.admin_reports`), access `perm:
  access entity changelog`.
- No routing.yml, no submodules, no Drush, no plugin types, no libraries.
