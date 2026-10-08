<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring publishing jobs

## Create a job
- Collection route: `entity.publishing_config.collection`.
- A `publishing_config` entity stores `content_type` and `date_field`.
- One job per content type (`JobManager::loadPublishingConfigJobByContentType()` uses `loadByProperties`).

## Execution flow
1. `content_publishing_job_cron()` → `JobManager::loadPublishingConfigJobs()` loads all jobs.
2. For each: `ContentManager::getExpiredContents($content_type, $date_field)` runs an entity query with `->accessCheck()`, `type`, `status = PUBLISHED`, and `<date_field> < now`.
3. Each returned nid is enqueued to `unpublish_expired_contents` with `{nid, date_field}`.
4. `UnPublishExpiredContents::processItem()` reloads the node, re-checks `isContentDateExpired()`, then `setUnpublished()->save()`.

## Notes for agents
- The module only unpublishes. There is no publish path and no web endpoint — the sole trigger is cron.
- `setUnpublished()->save()` bypasses Content Moderation state transitions. On moderated sites this force-unpublishes regardless of the current moderation state; consider a moderation-aware alternative if that matters.
- `date_field` must exist as a `node.<field>` `field_storage_config`; `DateFieldHandler` resolves the queryable column by field type.
