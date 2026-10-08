# Entity Log — service & entity

## Service `entity_log` (`EntityLogService implements EntityLogServiceInterface`)
Args: `entity_type.manager`, `config.factory`, `logger.factory`, `database`.

- `entitySetForLogging(EntityInterface $entity): array|false` — returns the enabled watched-field list for the
  entity's type+bundle, or FALSE if neither log target is enabled / no fields configured.
- `logFields(EntityInterface $entity, array $fields): void` — for each field: iterates `$entity->get($field)`
  and `$entity->original->get($field)` items collecting `getString()` values, implodes each with commas, and if
  old != new (and not both empty) writes to logger (when `log_in_logger`) and/or creates an `entity_log` entity
  (when `log_in_entity`). Requires `$entity->original` to be set (present during `hook_entity_update`).
- `cleanupLogs(): void` — prunes the `entity_log` table to `row_limit`.

Invoked from `entity_log.module`:
- `hook_entity_update()` → `entitySetForLogging()` then `logFields()`.
- `hook_cron()` → `cleanupLogs()`.

Diffing is shallow: it compares the string forms of field items only. It is not a full field/property revision
diff, and it fires on update (not on create/delete).

## Entity `entity_log` (ContentEntityType)
- Base table `entity_log`; `admin_permission = administer entity log entities`; fieldable
  (`field_ui_base_route = entity_log.settings`), publishable (`status`).
- Notable base fields / entity keys: `name` (label = changed field name), `log_type` (source entity type id),
  `old_value`, `new_value`, `entity_logged_id` (the changed entity, via `dynamic_entity_reference`),
  `user_id` (acting user, defaulted in `preCreate` to current user), `hostname` (client IP, from
  `preCreate`), `langcode`, `uuid`.
- Routes: canonical `/admin/structure/entity_log/{entity_log}`, add/edit/delete, collection
  `/admin/structure/entity_log`. Access handler `EntityLogAccessControlHandler`; Views data via
  `EntityLogViewsData`.

Create one from code (normally the service does this):
```php
\Drupal::entityTypeManager()->getStorage('entity_log')->create([
  'name' => 'field_status',
  'log_type' => 'node',
  'old_value' => '0',
  'new_value' => '1',
  'status' => 1,
  'entity_logged_id' => $node,   // dynamic entity reference to the changed entity
])->save();
```
