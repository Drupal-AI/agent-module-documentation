<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Recently Read — service, entities, Views plugins

## The `recently_read` service

`Drupal\recently_read\RecentlyReadService` (service id `recently_read`, interface
`RecentlyReadServiceInterface`). Injects `current_user`, `entity_type.manager`,
`session_manager`, `config.factory`.

```php
$rr = \Drupal::service('recently_read');
$rr->insertEntity($entity, $user = NULL);        // record/refresh a view (user defaults to current)
$rr->getRecords($user_id);                        // array of recently_read entity ids, newest first
$rr->deleteRecords([$rid, ...]);                  // delete by recently_read entity id
$rr->deleteEntityRecords($entity, $user = NULL);  // delete history rows for one entity
```

Behavior notes:
- `insertEntity()`: for an **anonymous** user it keys on `sessionManager->getId()` (and force-
  starts a session by setting `$_SESSION['recently_read']`); for an authenticated user it keys
  on `user_id`. If a matching row exists it just bumps `created` to `time()`; otherwise it
  creates one. When `delete_config === 'count'` it trims to `count` newest afterwards.
- `getRecords($user_id)`: `$user_id === 0` queries by `session_id` (current `session_id()`);
  otherwise by `user_id`. Returns ids sorted `created` DESC.

## Entities

- **`recently_read`** (content entity, `src/Entity/RecentlyRead.php`) — one row per
  user/session + entity view. Fields: `user_id`, `session_id`, `type` (viewed entity type id),
  `entity_id`, `created`. Custom storage schema in `RecentlyReadStorageSchema`.
- **`recently_read_type`** (config entity, `src/Entity/RecentlyReadType.php`) — declares a
  tracked entity type; `getTypes()` returns the bundle allow-list. Managed via
  `RecentlyReadTypeListBuilder` / `RecentlyReadTypeForm`.

## Views plugins (integration, not a public plugin type)

Registered in `recently_read.views.inc`:
- Relationship `recently_read_relationship` (`Plugin/views/relationship/RecentlyReadRelationship.php`)
  — joins a base entity to the current user's recently_read rows; `user_scope` option.
- Filter `recently_read_user_filter` — boolean, limits to the acting user's rows.

There is **no plugin manager** here — these are Views' own plugin types, so `data.json`
`provides_plugin_types` is `[]`. Recording is driven entirely by `hook_entity_view()` in
`recently_read.module`.
