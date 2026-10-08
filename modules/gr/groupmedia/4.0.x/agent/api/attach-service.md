<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `groupmedia.attach_group` service + bulk actions

## Service `groupmedia.attach_group` (`Drupal\groupmedia\AttachMediaToGroup`)

Central service that attaches media to groups. Injected as `@groupmedia.attach_group`.

| Method | Purpose |
|---|---|
| `attach(EntityInterface $entity)` | Auto-track entry point: finds media on `$entity` (via `media_finder` plugins) and attaches it to the group(s) `$entity` belongs to. Called from `hook_entity_update`, `hook_group_insert`, `hook_group_relationship_insert`. Respects `tracking_enabled` and the alter hooks. |
| `assignMediaToGroups(array $media_items, array $groups)` | Directly relate the given `MediaInterface[]` to the given `GroupInterface[]` (used by the bulk actions). |
| `getMediaFromEntity(EntityInterface $entity)` | Return the media items found on an entity by running all finders. |
| `getGroups(EntityInterface $entity)` | Return the groups an entity is (or should be) associated with. |

```php
$svc = \Drupal::service('groupmedia.attach_group');
$svc->assignMediaToGroups([$media], [$group]);   // relate one media to one group
```

Attachment creates a `group_relationship` entity of the matching `group_media:<bundle>`
relation type; nothing happens if that media type's plugin is not installed on the group's
type, or if group/entity cardinality limits are already reached.

## Bulk action plugins (core Action, type `media`)

| id | label |
|---|---|
| `assign_media_to_group` | Assign media to a Group |
| `remove_media_from_group` | Remove media from Group |

Each stores a single `group_id` (config schema `action.configuration.assign_media_to_group` /
`remove_media_from_group`) chosen when you configure the action, so one action = one fixed
group. Configure them with core's *Action* UI (`/admin/config/system/actions`) and attach to a
media-based View, or use the `groupmedia_vbo` submodule to pick the group at run time.
Action `access()` requires `update` access on the media item.
