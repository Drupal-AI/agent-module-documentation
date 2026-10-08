# Scheduling a preset with cron

## The `cron` field

`hook_entity_base_field_info()` adds a boolean **`cron`** field to the `cacheflush` entity (default
0). The preset add/edit forms get a **Cron** checkbox; on the edit form, if a job already exists, an
"Edit" link to the Ultimate Cron job is shown.

## Job lifecycle (Ultimate Cron)

Handled by entity hooks on `cacheflush`:

- `hook_ENTITY_TYPE_insert()` / `hook_ENTITY_TYPE_update()` → `cacheflush_cron_cacheflush_update()`:
  if `cron == 1`, load `CronJob::load('cacheflush_preset_' . $entity->id())`; create it if missing:
  ```php
  CronJob::create([
    'id'       => 'cacheflush_preset_' . $id,
    'callback' => 'cacheflush_cron_clear_preset',
    'module'   => 'cacheflush_cron',
    'status'   => TRUE,
    'title'    => 'Cacheflush cron preset ' . $id,
  ])->save();
  ```
  if the job exists but is inactive, it is re-enabled. If `cron == 0` and a job exists, it is set
  **inactive** (`setStatus(FALSE)`), not deleted.
- `hook_ENTITY_TYPE_delete()` → the job `cacheflush_preset_<id>` is **deleted**.

## The callback

`cacheflush_cron_clear_preset(CronJob $job)` derives the preset id from the job id
(`str_replace('cacheflush_preset_', '', $job->id())`), loads the preset with `cacheflush_load()`, and
calls `\Drupal::service('cacheflush.api')->clearById($entity)` — so the preset's configured caches are
cleared each time the job fires.

## Scheduling & running

The **schedule** is configured per job in the Ultimate Cron admin (`/admin/config/system/cron/jobs`).
Jobs fire on the site's normal cron (e.g. `drush cron` or a system crontab hitting cron). So the flow
is: enable Cron on a preset → a `cacheflush_preset_<id>` Ultimate Cron job appears → set its schedule
→ it clears that preset on cadence.

```php
// Programmatic: enable cron on a preset (creates the job on save).
$preset->set('cron', 1)->save();
// Inspect the job:
\Drupal\ultimate_cron\Entity\CronJob::load('cacheflush_preset_' . $preset->id());
```
