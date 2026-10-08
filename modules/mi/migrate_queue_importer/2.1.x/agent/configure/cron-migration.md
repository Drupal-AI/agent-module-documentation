<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: the `cron_migration` config entity

Config entity type `cron_migration` (`Drupal\migrate_queue_importer\Entity\CronMigration`) →
stored as config `migrate_queue_importer.cron_migration.<id>`. Exported keys (`config_export`):

| Key | Type | Meaning |
|---|---|---|
| `id` | string | machine name. |
| `label` | label | admin label. |
| `migration` | string | the **migration plugin id** to import (e.g. `article_import`, or a `migrate_plus` migration id). |
| `time` | int | interval in **seconds** between imports. `0` = eligible every cron run. |
| `update` | bool | run as an update (re-import; calls `prepareUpdate()` on the id map). |
| `sync` | bool | sync — remove destination items missing from the source (`syncSource`). |
| `ignore_dependencies` | bool | skip dependency resolution / clear the migration's `requirements`. |

`status` (enabled/disabled) is the entity's status key — only **enabled** cron migrations are
scheduled. The referenced `migration` id is stored as a plain string; the migration itself is
resolved at cron time via the migration plugin manager.

## Admin UI

- Collection: `entity.cron_migration.collection` →
  `/admin/config/migrate_queue_importer/cron_migration` (menu: *Configuration → Development →
  Cron migration*).
- Add / edit / delete forms under that path; plus **enable** / **disable** actions
  (`.../{id}/enable`, `.../{id}/disable`, CSRF-protected).
- Gated by the `administer cron migrations` permission (also the entity `admin_permission`).

Note: `info.yml` declares no `configure` route, so data.json `configure` is `null`; reach the
UI via the menu link, not the Extend page's Configure button.

## Via drush php:eval (scriptable)

```php
\Drupal::entityTypeManager()->getStorage('cron_migration')->create([
  'id' => 'article_hourly',
  'label' => 'Hourly article import',
  'migration' => 'article_import',   // a real migration plugin id
  'time' => 3600,                    // seconds
  'update' => TRUE,
  'sync' => FALSE,
  'ignore_dependencies' => FALSE,
  'status' => TRUE,
])->save();
```

Read back / manage:

```bash
drush cget migrate_queue_importer.cron_migration.article_hourly
drush cset migrate_queue_importer.cron_migration.article_hourly time 7200 -y
```

Disable/enable programmatically: `$entity->disable()->save();` / `$entity->enable()->save();`
(or set the `status` key). Disabled entities are ignored by cron.

## Deployment

`cron_migration` entities are plain exportable config, so include them in `drush cex`/`cim` to
move schedules between environments, or split them per-environment with Config Split.
