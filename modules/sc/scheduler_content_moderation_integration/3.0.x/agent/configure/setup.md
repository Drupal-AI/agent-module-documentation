# Enable scheduled moderation transitions

There is **no configuration page and no permissions** of its own. Setup is done in the
Workflow and Scheduler settings:

1. Put the entity type/bundle under a Content Moderation workflow:
   **Configuration → Workflow → Workflows → edit your workflow → "This workflow applies to"**.
2. Enable scheduling on the bundle:
   **Structure → (Content/Media) types → your type → edit → Scheduler** tab — turn on
   "scheduled publishing" and/or "scheduled unpublishing".
3. On the entity edit form's **Scheduling Options**, editors now get:
   - **Publish on** + **Publish state** (target moderation state to transition to).
   - **Unpublish on** + **Unpublish state**.

Cron must be configured for the scheduled jobs to run.

## Typical Draft → Published flow
- Edit content, set "Change to: Draft".
- Expand Scheduling Options, set **Publish on** to a future date and **Publish state** to
  "Published". At that time cron transitions the entity to Published (if the transition is valid).

## Notes
- The publish/unpublish **date** field is auto-hidden when no moderation transition is
  available for the corresponding state (via `hook_scheduler_hide_publish_date` /
  `hook_scheduler_hide_unpublish_date`).
- Only transitions valid in the workflow (and permitted for the user) are accepted — invalid
  selections are blocked by validation constraints on save.
