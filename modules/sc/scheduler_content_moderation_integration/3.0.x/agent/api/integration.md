# How it integrates with Scheduler

All behavior is automatic; nothing is meant to be called directly. Extension points:

## Scheduler hook implementations (`includes/scheduler_hooks.inc`)
- `hook_scheduler_publish_process($entity)` — if the entity is moderated, reads
  `publish_state`, checks a valid transition from the current `moderation_state` exists, then
  sets + saves `moderation_state`. Returns `1` (handled, skip Scheduler's default publish),
  `-1` (invalid transition → abandon), or `0` (not moderated → let Scheduler proceed).
- `hook_scheduler_unpublish_process($entity)` — same for `unpublish_state`.
- `hook_scheduler_hide_publish_date` / `hook_scheduler_hide_unpublish_date` — hide the date
  field when no transition is available for that state.

## Event subscriber
`SchedulerEventSubscriber` listens to `SchedulerNodeEvents::PUBLISH_IMMEDIATELY` and
`SchedulerMediaEvents::PUBLISH_IMMEDIATELY` (fired during edit-time "publish now", not cron)
and sets `moderation_state` from `publish_state` for moderated entities.

## Validation constraints (`src/Plugin/Validation/Constraint/`)
Applied to the scheduling fields on the edit form:
- `PublishStateConstraint` / `UnPublishStateConstraint` — the chosen target state must be a
  valid transition from the entity's current state.
- `TransitionAccessConstraint` — the current user must be allowed to make that transition.

## Field widget
`SchedulerModerationWidget` (`@FieldWidget`) renders the publish/unpublish state selectors,
limited to the states reachable in the entity's workflow.

## Tokens (node)
- `[node:scheduled-moderation-publish-state]` — label of the scheduled publish state.
- `[node:scheduled-moderation-unpublish-state]` — label of the scheduled unpublish state.
