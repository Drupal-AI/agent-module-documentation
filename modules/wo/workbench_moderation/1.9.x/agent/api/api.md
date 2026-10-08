<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services & the moderation_state field

## `moderation_state` base field

`hook_entity_base_field_info()` adds a `moderation_state` base field to every moderatable
entity type. Its value on the edit form is the requested target state; on save the module maps
it to the state's `published`/`default_revision` flags to decide whether the save is a live
publish or a forward draft. Read it: `$node->moderation_state->value`.

## `workbench_moderation.moderation_information` (`ModerationInformation`)

The main query service. Useful methods:

- `isModeratableEntity($entity)` / `isModeratableEntityType($type)` /
  `isModeratableBundle($type, $bundle)` — is moderation on here?
- `isModeratedEntityForm($form_object)` — is this an edit form of a moderated entity?
- `getLatestRevision($entity_type_id, $entity_id)` / `getLatestRevisionId(...)` — the newest
  (possibly forward/draft) revision.
- `getDefaultRevisionId($entity_type_id, $entity_id)` — the live/default revision id.
- `isLatestRevision($entity)` / `hasForwardRevision($entity)` / `isLiveRevision($entity)`.

```php
$mi = \Drupal::service('workbench_moderation.moderation_information');
if ($mi->isModeratableEntity($node) && $mi->hasForwardRevision($node)) { … }
```

## `workbench_moderation.state_transition_validation` (`StateTransitionValidation`)

Which transitions are permitted:

- `getValidTransitions(ContentEntityInterface $entity, AccountInterface $user)` — transitions
  the user may perform from the entity's current state.
- `getValidTransitionTargets($entity, $user)` — the target states.
- `userMayTransition($from, $to, $user)` — permission check for one transition.
- `isTransitionAllowed($from, $to)` — does a transition exist between these states.

## `workbench_moderation.revision_tracker` (`RevisionTracker`)

Tracks the latest revision per entity/langcode in table `workbench_revision_tracker`
(`backend_overridable`). `setLatestRevision($entity_type, $entity_id, $langcode, $revision_id)`.

## Other services

- `workbench_moderation.entity_operations` (`EntityOperations`) — presave/insert/update logic
  that actually applies moderation on save and dispatches the transition event.
- `paramconverter.latest_revision` (`EntityRevisionConverter`) — loads the latest/forward
  revision on routes flagged `load_forward_revision` (the "Latest version" tab).
- `access_check.latest_revision` (`LatestRevisionCheck`) — `_workbench_moderation_latest_version`
  route access.
- `workbench_moderation.views_data` — Views field/filter integration ("Latest revision" filter).

Events on transition: [../events/events.md](../events/events.md).
