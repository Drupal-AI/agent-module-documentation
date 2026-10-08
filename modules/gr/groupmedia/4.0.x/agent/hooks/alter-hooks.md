<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Media alter hooks

Defined in `groupmedia.api.php`. They only affect **automatic** tracking, not manual
relate/create. For the finder registry hook see [../plugins/media-finder.md](../plugins/media-finder.md)
(`hook_media_finder_info_alter`).

### `hook_groupmedia_entity_group_alter(array &$groups, EntityInterface $entity)`
Alter the list of groups an entity's media should be attached to. **If `$groups` is emptied,
the entity is skipped** (no media attached).

```php
function mymod_groupmedia_entity_group_alter(array &$groups, EntityInterface $entity) {
  if ($entity->bundle() === 'draft') {
    $groups = [];   // never auto-attach media from draft content
  }
}
```

### `hook_groupmedia_finder_add_alter(array &$result, MediaInterface $media, array &$context)`
Vote on whether a **found** media item may be processed. Push `FALSE` into `$result` to veto;
**any single `FALSE` blocks that media item**. `$context` = `['entity' => …, 'field_name' => …]`.

```php
function mymod_groupmedia_finder_add_alter(array &$result, MediaInterface $media, array &$context) {
  if ($context['field_name'] === 'field_ignore_me') {
    $result[] = FALSE;
  }
}
```

### `hook_groupmedia_attach_group_alter(array &$result, MediaInterface $media, GroupInterface $group)`
Vote on whether a media item may be attached to a **specific** group. Same `FALSE`-wins
semantics as above.

```php
function mymod_groupmedia_attach_group_alter(array &$result, MediaInterface $media, GroupInterface $group) {
  if (!$media->isPublished()) {
    $result[] = FALSE;   // keep unpublished media out of groups
  }
}
```

Group/entity cardinality limits configured on the relation plugin are always enforced last,
after these hooks.
