<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Scheduled Publish lets editors queue future content-moderation state changes on an entity: add a "Scheduled publish" field, and on the edit form pick one or more date + target moderation-state pairs; on cron the module moves the entity into each state when its time arrives.

---

The module adds a `scheduled_publish` **field type** (with its own widget and formatter) that you attach to any bundle whose entity type is under **Content Moderation**. Each field item stores a `value` (an ISO-8601 datetime) and a `moderation_state` (the target state machine name); the field is normally multi-value so an editor can queue several transitions (e.g. *publish on Friday, archive next month*). On the entity edit form the **`scheduled_publish` widget** shows a datetime picker plus a moderation-state select limited to the bundle's workflow; the **`scheduled_publish_generic_formatter`** renders the scheduled entries (with configurable `date_format` / `text_pattern`). A cron service (`scheduled_publish.update`, `ScheduledPublishCron::doUpdate()`) runs on every Drupal cron: it finds entities whose scheduled datetimes are due and applies the corresponding moderation-state transition (creating a new revision), so publishing/unpublishing/archiving happens automatically. You can also trigger the run manually with the Drush command `scheduled_publish:doUpdate` (alias `schp`). An admin **listing** of pending scheduled changes lives at `/admin/content/scheduled-publish` (with add/edit/delete forms under that path), guarded by the **`access scheduled publish pages`** permission (the listing itself requires `view any unpublished content`). It ships optional config for an `ultimate_cron` job and a `views.view.scheduled_publish` view, config schema for the field storage/formatter, and depends on `content_moderation`, `workflows`, and `datetime`. There is no global settings form (`configure: null`) — configuration is per field.

---

- Schedule a news article to publish automatically at a future date/time.
- Auto-unpublish a promotion when it expires.
- Queue a move to an "Archived" moderation state months ahead.
- Plan several transitions on one node (publish now, archive later) in a single field.
- Publish embargoed content exactly when an embargo lifts.
- Schedule a page to go from Draft to Published overnight without an editor online.
- Set time-boxed content that publishes and later unpublishes on schedule.
- Coordinate a content launch across many nodes via cron.
- Let editors self-serve future publishing without site-builder involvement.
- Move content through a custom workflow state on a timer.
- Trigger scheduled transitions on demand with `drush schp` in CI or deploys.
- Review all pending scheduled changes at /admin/content/scheduled-publish.
- Add scheduled moderation to non-node entities that use content moderation.
- Schedule unpublish of event pages after the event date.
- Roll out staged publishing of a series of articles.
- Apply a "needs review" state automatically at a deadline.
- Combine with a workflow so scheduling respects allowed transitions.
- Automate seasonal content (publish in season, archive after).
- Give a bundle multiple queued state changes with a multi-value field.
- Format the displayed scheduled dates with a custom date format/text pattern.
- Drive scheduled publishing from ultimate_cron for finer cron control.
- Ensure content moderation transitions occur even when no one edits the node.
- Delay publishing of legally-reviewed content until an approved date.
- Schedule an entity to be published then moved to archived in one configuration.
