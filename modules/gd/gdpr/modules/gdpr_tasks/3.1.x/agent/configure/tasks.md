<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Task entity, task types, routes

## The `gdpr_task` entity and `gdpr_task_type` bundles

- Content entity `gdpr_task` (`ContentEntityType`, base table `gdpr_task`, admin permission
  `administer task entities`, bundle key `type`, `bundle_entity_type = gdpr_task_type`).
  Required base fields: `type` (the bundle) and `status`.
- Bundle = **config entity** `gdpr_task_type` (`ConfigEntityBundleBase`,
  `config_prefix gdpr_task_type`, `bundle_of gdpr_task`, `config_export: id, label, uuid`).
  Config object name `gdpr_tasks.gdpr_task_type.<id>`.
- Two default types ship in `config/install`:
  - `gdpr_sar` — label "SARs Request" (Subject Access Request / data export)
  - `gdpr_remove` — label "Removal request" (Right to be Forgotten)

Create a custom task type:
```php
use Drupal\gdpr_tasks\Entity\TaskType;
TaskType::create(['id' => 'my_request', 'label' => 'My request'])->save();
// list types:
\Drupal::entityTypeManager()->getStorage('gdpr_task_type')->loadMultiple();
```

Create a task for a user:
```php
\Drupal::entityTypeManager()->getStorage('gdpr_task')
  ->create(['type' => 'gdpr_sar', 'user_id' => $uid])->save();
```

## Routes & UI

| Route | Path | Permission |
|---|---|---|
| `gdpr_tasks.summary` | `/admin/config/gdpr/summary` | `view gdpr tasks` |
| `gdpr_tasks.request` | `/user/{user}/gdpr-request/{gdpr_task_type}` | `create gdpr tasks` (CSRF) |
| `gdpr_tasks.remove_settings` | `/admin/config/gdpr/remove-settings` | `administer task entities` |
| (task collection) | `/admin/config/gdpr/tasks` | `administer task entities` |

The base `gdpr` module's `/user/{user}/gdpr` page redirects to the
`view.gdpr_tasks_my_data_requests.page_1` view when this submodule is enabled.

## Removal settings config (`gdpr_tasks.settings`)

The Right-to-be-Forgotten settings form (`RemovalSettingsForm`,
`/admin/config/gdpr/remove-settings`) stores a single value in the config object
**`gdpr_tasks.settings`** under key **`export_directory`** — the directory where processed
removal tasks are exported (constants `CONFIG_KEY = 'gdpr_tasks.settings'`,
`EXPORT_DIRECTORY = 'export_directory'`). Set it via the form or:

```php
\Drupal::configFactory()->getEditable('gdpr_tasks.settings')
  ->set('export_directory', 'private://gdpr-export')->save();
\Drupal::config('gdpr_tasks.settings')->get('export_directory'); // 'private://gdpr-export'
```

## Permissions

`create gdpr tasks`, `view gdpr tasks`, `add task entities`, `administer task entities`
(restricted), `delete task entities`, `edit task entities`, `view task entities`,
`view gdpr data summary`.

Config schema for the task type is in `config/schema/gdpr_task_type.schema.yml`.
