<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Activities — services, entity & hooks

## Services

### `activities.logger` (`ActivitiesLogger`, `ActivitiesLoggerInterface`)

```php
\Drupal::service('activities.logger')
  ->log(EntityInterface $entity, string $op, ?AccountInterface $account = NULL);
```

Creates a `user_activities` record for `$entity` under operation `$op`
(`create`/`update`/`delete`/`view`). Applies the `security` throttle/anonymous rules for
views. Called automatically from the entity CRUD hooks in `activities.module`.

### `activities.manager` (`ActivitiesManager`)

- `getContentEntity()` — map of content entity type id => label (the types offered on the
  settings form).
- `activitiesGetDescription(UserActivitiesInterface $a)` — human-readable description of an
  activity.
- `activitiesGetLink(UserActivitiesInterface $a)` — link markup to the affected entity.

### `activities.purge` (`ActivitiesPurgeService`)

- `executePurge()` — run the configured purge (called by `activities_cron()`).
- `purgeByTime($value, $unit)` / `purgeByCount($max)` / `purgeByEntityType($type, $bundle = NULL)`.
- `getTotalCount()` / `getEntityTypesWithCounts()` / `getBundlesWithCounts($type)` — reporting.

## The `user_activities` entity

`@ContentEntityType id = "user_activities"`, base table `user_activities`, owner key
`user_id`, handlers: `UserActivitiesListBuilder`, `UserActivitiesViewsData`,
`UserActivitiesAccessControlHandler`. Getters (`UserActivities`):

| Getter | Returns |
|---|---|
| `getOwner()` / `getOwnerId()` | The acting user. |
| `getOperation()` | `create`/`update`/`delete`/`view`. |
| `getInfo()` | Stored info payload. |
| `getRelatedEntityId()` / `getRelatedEntityTypeId()` / `getBundle()` | The affected entity. |
| `getCreatedTime()` | Timestamp. |
| `getIpAddress()` / `getLocation()` | Request IP / location. |

`label()` resolves to the affected entity's label when loadable.

## Alter hook (`activities.api.php`)

```php
/** Alter the activity data before save. */
function hook_activities_logger_log(\Drupal\activities\Entity\UserActivitiesInterface $activities) {
  // Modify $activities before it is persisted.
}
```

## Views integration

`hook_views_data` (in `.module`) adds a `filter_by_bundles` filter on `user_activities`
(plugin `all_bundles`, label "Bundle"). Plus custom Views **field** plugins for the log:
`description_field` (`DescriptionField`), `event_link` (`EventLinkField`),
`related_entity_link` (`RelatedEntityLinkField`), and the `all_bundles` **filter**
(`AllBundles`, extends `in_operator`). These power the Activity Data Export submodule's view.

No new plugin *type*, no Drush commands, no services beyond the three above.
