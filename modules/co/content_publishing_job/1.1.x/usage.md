<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Publishing Job lets an administrator define "publishing config" jobs that automatically unpublish nodes of a chosen content type once a configured date field has passed.
---
Each job is a `publishing_config` config entity (managed at `entity.publishing_config.collection`) pairing a content type with a date field. On every cron run `content_publishing_job_cron()` loads all jobs, and for each calls `ContentManager::getExpiredContents()` — an entity query filtered to `type`, `status = PUBLISHED`, and `date_field < now` — then enqueues each matching nid into the `unpublish_expired_contents` queue. The `UnPublishExpiredContents` queue worker (`cron` time 20s) loads each node, re-checks the date via `DateFieldHandler`, and calls `setUnpublished()->save()`.

Security posture: the module only ever UNPUBLISHES content — it never publishes, so it cannot expose unpublished/embargoed material. Its only trigger is Drupal cron (no route, no anonymous or web-facing endpoint), and the expiry query already selects only published nodes. Note the worker calls `setUnpublished()->save()` directly, which bypasses Content Moderation workflow transitions (the node is force-unpublished regardless of moderation state); on moderated sites prefer a moderation-aware approach. The bundled `RelatedContentsBlock` is a separate presentational block using an access-checked published-only query. Setup: enable (depends on `block`), create a publishing config per content type at the collection route, and ensure cron runs.
---
- Automatically unpublish news items once their expiry date passes.
- Schedule event nodes to drop off the site after the event date.
- Create one unpublish job per content type with its own date field.
- Manage jobs from the `publishing_config` entity collection UI.
- Rely on cron to enqueue and process expirations in the background.
- Batch expirations through the `unpublish_expired_contents` queue worker.
- Limit each queue-worker run to ~20 seconds of cron time.
- Re-verify the expiry date inside the worker before unpublishing.
- Restrict processing to already-published nodes only.
- Log each unpublish action to the `content_publishing_job` channel.
- Add a "related contents" block filtered by a taxonomy term.
- Show recent published content of the same type via the related-contents block.
- Exclude the current node from the related-contents listing.
- Choose the date field per job (supports different date field types).
- Handle both plain date and datetime-range style fields via the date handler.
- Audit that the module never re-publishes content automatically.
- Confirm cron is the only trigger (no web route exposes the jobs).
- Delete a publishing config job to stop expiring that content type.
- Combine with editorial workflows that set an "unpublish on" date.
- Verify moderation implications before using on Content Moderation sites.
- Translate the module UI via the bundled interface-translation project.
- Use the JobManager service to look up a job by content type programmatically.
