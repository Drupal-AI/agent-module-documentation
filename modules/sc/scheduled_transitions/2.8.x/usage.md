<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Scheduled Transitions lets editors schedule a content-moderation revision to change to another moderation state (publish, unpublish, archive, …) at a future date and time, per entity and per language.

---

The module builds on core **Content Moderation** and **Dynamic Entity Reference**. For each moderated entity/bundle you enable in its settings, a **Scheduled transitions** tab appears on the entity where an editor picks a source revision, a target moderation state, and a date/time. That choice is stored as a `scheduled_transition` content entity (fields: a dynamic `entity` reference, `entity_revision_id`, `entity_revision_langcode`, target `moderation_state`, `workflow`, `transition_on` timestamp, `options`, `is_processed`). On cron the `ScheduledTransitionsJobs::jobCreator()` finds due, unprocessed, unlocked transitions and pushes each onto the `scheduled_transition_job` queue; the queue worker calls `ScheduledTransitionsRunner::runTransition()`, which loads the chosen revision, creates a new default revision in the target state, writes a templated revision-log message, and (unless retention is enabled) deletes the processed transition. The Drush command `scheduled-transitions:queue-jobs` (alias `sctr-jobs`) forces the same queue-filling step on demand. Settings live in `scheduled_transitions.settings`: which bundles are enabled (`bundles`), whether cron creates queue items (`automation.cron_create_queue_items`), the three revision-log message templates (with `[scheduled-transitions:*]` tokens), whether editors may override those messages (`message_override`), how access is mirrored to other entity operations (`mirror_operations`), and whether/how long processed transitions are retained (`retain_processed`). Access is governed by three dynamic per-entity-type/bundle permissions plus `view all scheduled transitions` and `administer scheduled transitions`. A `scheduled_transitions.new_revision` event lets other modules override which revision is transitioned. There is a collection view at `/admin/content/scheduled-transitions`.

---

- Schedule a Draft article to auto-publish next Monday at 09:00.
- Schedule a published page to be archived on a campaign end date.
- Unpublish time-sensitive content automatically after an embargo/expiry date.
- Publish a press release at an exact embargo time without a person clicking "publish".
- Schedule a translation to change state independently of the source language.
- Queue several future state changes for the same node (e.g. publish then archive later).
- Move an older historical revision back to the top by scheduling it to a new state.
- Enable scheduled transitions only for specific content types via the settings form.
- Let a role add scheduled transitions for Article but not for Page using per-bundle permissions.
- Grant read-only visibility of upcoming transitions with `view scheduled transitions <type> <bundle>`.
- Reschedule an existing pending transition to a new date from the entity's Scheduled transitions tab.
- Review all pending/processed transitions site-wide at `/admin/content/scheduled-transitions`.
- Customise the revision-log message written when the latest revision is transitioned, using tokens.
- Allow editors to override the default revision-log message per transition (`message_override`).
- Force due transitions to run immediately with `drush scheduled-transitions:queue-jobs`.
- Process transitions on a schedule by leaving cron to fill the queue (`automation.cron_create_queue_items`).
- Retain processed transition records for auditing for a configurable number of days (`retain_processed`).
- Mirror "add/view/reschedule" access to the entity's `update` operation via `mirror_operations`.
- Override which revision is used for a transition with the `scheduled_transitions.new_revision` event.
- Programmatically schedule a transition with `ScheduledTransition::createFrom($workflow, $state, $revision, $dateTime, $author)`.
- Build an editorial calendar of future publish/unpublish actions across the site.
- Automate a "publish → archive after 30 days" lifecycle for news items.
- Coordinate a coordinated site-wide launch by scheduling many nodes to publish at once.
- Expose scheduled-transition data in Views (from-state, to-state, and revision-link fields are provided).
- Clean up stale processed transitions automatically during cron (`cleanupExpired()`).
