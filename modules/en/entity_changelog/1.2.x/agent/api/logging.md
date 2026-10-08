<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How changes are captured and stored

## Trigger: entity CUD hooks

`entity_changelog.module` implements three hooks, each resolving the logger service and forwarding to
`addEntry()` with the matching enum case:

- `entity_changelog_entity_insert()` → `EntityChangelogOperation::INSERT`
- `entity_changelog_entity_update()` → `EntityChangelogOperation::UPDATE`
- `entity_changelog_entity_delete()` → `EntityChangelogOperation::DELETE`

The enum `Drupal\entity_changelog\Type\EntityChangelogOperation` (`src/Type/EntityChangelogOperation.php`)
is a backed string enum: `INSERT = 'insert'`, `UPDATE = 'update'`, `DELETE = 'delete'`. There is no
allow-list — every entity type that fires these core hooks is logged.

## Service: EntityChangelogLogger

`Drupal\entity_changelog\Services\EntityChangelogLogger`
(service id `entity_changelog.entity_changelog_logger`, defined in `entity_changelog.services.yml`).
Constructor args: `entity_type.manager`, the `entity_changelog.logger` channel, `current_user`,
`request_stack`, `database`. The constructor caches the `entity_changelog_entry` entity-type definition.

- **`addEntry(EntityInterface $entity, EntityChangelogOperation $operation): void`** — early-returns if
  the entity has no `id()` **or** is itself an `entity_changelog_entry` (prevents recursion). Otherwise it
  builds a data array and does `EntityChangelogEntry::create($data)->save()`. Captured fields:
  `entity_type` (`$entity->getEntityType()->id()`), `entity_id` (`(string) $entity->id()`), `entity_title`
  (`$entity->label()`), `timestamp` (`(new \DateTime())->getTimestamp()`), `user_id` (`currentUser->id()`),
  `username` (`currentUser->getDisplayName()`), `request_path` (see below), `operation`
  (`$operation->value`). Any `\Throwable` on save is caught and written to the `entity_changelog` logger
  channel as an error (with `exception` + `data` context) — a failed log entry never breaks the CUD op.
- **`getRequestPathAndQuery(): ?string`** — private; returns `getPathInfo() . '?' . getQueryString()`
  from the current request, or `NULL` if there is no request (e.g. Drush/cron context). Logic mirrors
  `Symfony\Component\HttpFoundation\Request::getUri`.
- **`getLoggedEntityTypes()` / `getLoggedUsernames()`** — `DISTINCT` selects on the base table's
  `entity_type` / `username` columns; used by `hook_views_pre_build` to build grouped exposed-filter
  option lists for the view.
- **`deleteOldEntries(): void`** — a `database->delete()` on the base table with
  `condition('timestamp', <now minus P3Y>, '<')`. Called from `entity_changelog_cron()`, so entries
  older than three years are pruned on each cron run. Retention is fixed in code (three years); there is
  no config for it.

## Storage: the entity_changelog_entry entity

`Drupal\entity_changelog\Entity\EntityChangelogEntry` (`src/Entity/EntityChangelogEntry.php`) — a
`@ContentEntityType` with id `entity_changelog_entry`, base table `entity_changelog_entry`, entity keys
`id` + `uuid`. Handlers: view_builder `EntityChangelogEntryViewBuilder` (bare extension of core
`EntityViewBuilder`), views_data `EntityChangelogEntryViewsData` (bare extension of core
`EntityViewsData`), access `EntityChangelogEntryAccessControlHandler` (see views/log-view.md).
`baseFieldDefinitions()` declares: `entity_type` (string), `entity_id` (string), `entity_title` (string),
`timestamp` (timestamp), `user_id` (integer), `username` (string_long), `request_path` (string_long),
`operation` (string). No bundles, no forms, no canonical/edit/delete routes or links.

## Install / enable

`ddev drush en entity_changelog -y`. The entity schema is created automatically from the entity
definition; the Views page is imported from `config/install/`. No further setup — logging is immediate.
