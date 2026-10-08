<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable queue tracking + cleanup

**Enable (settings.php only):**
```php
$config['entity_usage_queue_tracking.settings']['queue_tracking'] = TRUE;
```
This is intentionally not in the UI. Once set, Entity Usage's synchronous CRUD hooks are unhooked (`hook_module_implements_alter`) and this module enqueues `entity_usage_tracker` items on entity insert/update/predelete/translation_delete/revision_delete (only for trackable source entities, decided by Entity Usage's `allowSourceEntityTracking()`).

**Processing:** the `entity_usage_tracker` QueueWorker runs on cron (max 300s/run). Per item it reloads the entity and calls `trackUpdateOnCreation()` / `trackUpdateOnDeletion()`, deletes non-current-revision usage rows, and invalidates `{target_type}:{target_id}` cache tags. If the entity is already deleted, it deletes usage rows by source.

**Veto tracking:**
```php
function mymodule_entity_usage_queue_tracking_should_remove_usage($entity) {
  return $entity->bundle() === 'ephemeral'; // TRUE => delete usage instead of tracking
}
```

**Cleanup command:**
```
drush clean_usage_table            # remove duplicate rows, prune non-current revisions
drush clean_usage_table --pointing # also delete rows where target_id == source_id
```
Run it on a schedule; queue mode can leave stale rows between cron runs.
