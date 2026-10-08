Scheduler Content Moderation Integration lets Scheduler move entities to a chosen moderation state at a scheduled time, so editorial workflows (Draft → Published → Archived) can be published or unpublished automatically.

---

On its own Scheduler simply toggles an entity's published flag; this sub-module makes Scheduler aware of Content Moderation workflows. When an entity type is under a workflow and has scheduling enabled, the module adds **Publish state** and **Unpublish state** fields to the entity form's Scheduling Options, letting editors say "on this date, transition to *Published*" (or any valid state) rather than just "publish". At cron time it implements Scheduler's `hook_scheduler_publish_process()` / `hook_scheduler_unpublish_process()` to set and save the target `moderation_state` — but only if a valid transition exists between the current state and the target, otherwise processing is abandoned. It also handles Scheduler's "publish immediately" event during entity save via an event subscriber, and hides the publish/unpublish date fields when no moderation transitions are available. Validation constraints (`PublishStateConstraint`, `UnPublishStateConstraint`, `TransitionAccessConstraint`) block invalid or unauthorized scheduled transitions on the edit form. Two node tokens expose the scheduled publish/unpublish state labels for use in messages or views. It has no admin page or permissions of its own — configuration lives entirely in the Workflow and Scheduler settings. If you use Scheduler together with Content Moderation, this module is required.

---

- Schedule a draft to transition to Published on a future date.
- Schedule content to move to an Archived state automatically.
- Combine editorial workflows with time-based publishing.
- Auto-publish press releases at an embargo lift time into the correct state.
- Unpublish time-sensitive content by transitioning it to a Draft/Archived state.
- Ensure scheduled changes respect valid workflow transitions only.
- Prevent scheduling an invalid state transition via form validation.
- Restrict scheduled transitions to states the editor is allowed to use.
- Let editors pick the exact target moderation state, not just publish/unpublish.
- Hide scheduling date fields when no moderation transition is possible.
- Publish immediately to a chosen moderation state during a normal save.
- Support scheduled moderation transitions for nodes.
- Support scheduled moderation transitions for media entities.
- Support scheduled transitions on Commerce or other custom moderated entities.
- Show the scheduled publish state label in a view or email via a token.
- Show the scheduled unpublish state label via a token.
- Coordinate multi-step editorial calendars (draft now, publish later).
- Automate content lifecycle on sites with strict governance.
- Roll out seasonal/campaign content on a fixed schedule with workflow control.
- Take stale content out of circulation on a schedule without deleting it.
- Keep an audit-friendly workflow while still automating go-live times.
- Let a review team approve to a "Ready" state that then auto-publishes.
- Abandon a scheduled job safely when the workflow no longer permits the transition.
- Integrate scheduling into a Draft-Published-Archived thunder-style workflow.
