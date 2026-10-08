<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Unpublished-media warning mechanism

Everything lives in `entity_usage_validate.module` (no `src/`, no config, no routes, no
services, no permissions, no plugins). Two hook implementations.

## `hook_module_implements_alter()`

`entity_usage_validate_module_implements_alter(&$implementations, $hook)` — for the
`entity_update` hook only, it removes and re-adds this module's implementation so it sorts
**last**. This guarantees `entity_usage_validate_entity_update()` runs *after*
`entity_usage_entity_update()`, so Entity Usage has already recorded the current revision's
relationships before this module reads them.

## `hook_entity_update()`

`entity_usage_validate_entity_update(EntityInterface $entity)`:

1. Early return unless `$entity->getEntityTypeId() === 'node'` **and**
   `$entity->isPublished()`. Non-node entities and unpublished nodes are ignored.
2. `$revisionId = $entity->getRevisionId();` then
   `\Drupal::service('entity_usage.usage')->listTargets($entity, $revisionId)`. Early return
   if `$targets['media']` is empty (node references no media).
3. `Media::loadMultiple(array_keys($targets['media']))` loads the referenced media.
4. For each media where `!$media->isPublished()`, it calls
   `\Drupal::messenger()->addWarning(t('The media entity: %media-title (ID: %media-id) referenced in this node is unpublished.', ...))` with `%media-title => $media->label()` and
   `%media-id => $media->id()`.

## Behavior notes (from source)

- **Update only.** It hooks `hook_entity_update()`, not `hook_entity_insert()`, so it does
  **not** fire on the first save that creates a node — only when an existing published node is
  saved again.
- **Node + media only.** It filters to `node` entities and reads only the `media` bucket of the
  `listTargets()` result; other entity types and other target types are ignored.
- **Advisory.** It only adds a `messenger` warning. It never blocks or alters the save, changes
  the node, or writes anything.
- **`%` placeholders** in `t()` are escaped by Drupal's placeholder handling, so the media label
  renders as text.

## Install / operate

- `composer require drupal/entity_usage_validate` (pulls `drupal/entity_usage ^2.0`), then
  `drush en entity_usage_validate -y`.
- Core requirement `^8.9 || ^9 || ^10 || ^11`. Nothing to configure — active on enable.
- To verify: re-save an already-published node that references an unpublished media item; a
  warning naming that media (title + ID) appears.
