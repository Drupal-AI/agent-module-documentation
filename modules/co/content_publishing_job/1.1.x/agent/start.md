<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Publishing Job (content_publishing_job) — agent index
**Cron + queue that unpublishes nodes of a content type once a configured date field has expired.**

- **Version:** 1.1.x
- **Core:** ^9 || ^10 — depends on `block`.
- **Config entity:** `publishing_config` (content_type + date_field), managed at `entity.publishing_config.collection`.
- **Cron:** `content_publishing_job_cron()` enqueues expired published nids into queue `unpublish_expired_contents`.
- **Queue worker:** `UnPublishExpiredContents` → `setUnpublished()->save()`.
- **Services:** `content_publishing_job.content_manager`, `.job_manager`, `.date_field_handler`.
- **Security:** UNPUBLISH-only (never publishes, so no access/embargo bypass); cron-triggered only, no web/anonymous route; expiry query is `status = PUBLISHED`. Caveat: worker force-unpublishes bypassing Content Moderation transitions. No security findings.

See [configure/jobs.md](configure/jobs.md).
