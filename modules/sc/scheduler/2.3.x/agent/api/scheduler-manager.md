# SchedulerManager service

Service id `scheduler.manager` (`\Drupal\scheduler\SchedulerManager`) is the module's core
engine. It selects due entities, dispatches events/hooks, and performs the publish/unpublish.

```php
$manager = \Drupal::service('scheduler.manager');
```

## Cron processing
- `publish()` — process all entities whose `publish_on` is due (called from cron). Returns TRUE
  if any were published.
- `unpublish()` — same for `unpublish_on`.
- `runLightweightCron(array $options = [])` — run only Scheduler's publish+unpublish pass.
  Options: `nomsg`, `nolog`. Backs the `/scheduler/cron/{key}` route and `drush scheduler:cron`.
- `isAllowed(EntityInterface $entity, $process)` — whether `$process` ('publish'|'unpublish')
  is permitted for `$entity` (consults `hook_scheduler_*_allowed()`).

## Settings & third-party settings
- `setting($key)` — read a `scheduler.settings` value.
- `getThirdPartySetting($entity, $setting, $default)` — per-bundle scheduler setting for an entity.
- `entityTypeNoBundleConfig($entityTypeId)`, `getNoBundleEntityTypeSetting($id, $setting, $default)`.
- `getEnabledTypes($entityTypeId, $process)` — bundles with publishing/unpublishing enabled.

## Plugins / supported entity types
- `getPlugins()`, `getPluginDefinitions()`, `getPlugin($entityTypeId)`,
  `getPluginEntityTypes()` — introspect which entity types Scheduler supports.
- `getEntityFormIds()`, `getEntityTypeFormIds()`, `getCollectionRoutes()`,
  `getUserPageViewRoutes()`, `getDevelGenerateFormIds()` — routing/form maps built from plugins.
- `permissionName($entityTypeId, $permissionType)` — resolve a dynamic permission name.

## Maintenance (also exposed via Drush)
- `entityUpdate()` — add Scheduler base fields for entity types now covered by a plugin.
- `entityRevert(array $only_these_types = [])` — remove Scheduler fields + third-party settings.
- `viewsUpdate()`, `invalidatePluginCache()`, `resetFormDisplayFields()`.

To react to publish/unpublish rather than drive it, subscribe to the events in
[events.md](events.md); to allow/deny/customise, implement the hooks in
[../hooks/hooks.md](../hooks/hooks.md).
