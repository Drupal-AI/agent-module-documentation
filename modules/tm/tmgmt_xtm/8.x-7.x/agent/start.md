<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TMGMT XTM (tmgmt_xtm) — agent index
**TMGMT provider for XTM Cloud; unauthenticated callback enqueues work and the queue worker re-fetches translations over the authenticated XTM API with a project-reference check.**

- **Version:** 8.x-7.x — core `^9 || ^10`
- **Depends on:** tmgmt
- **Configure:** `entity.tmgmt_translator.collection` (TMGMT translators list)
- **Route:** `tmgmt_xtm.callback` `/tmgmt_xtm_callback` — `_access: 'TRUE'` (unauthenticated); controller `RemoteCallbackController`
- **Queue:** `callback_job_queue` worker `JobQueue` (cron, 3600s)
- **Security:** callback is unauthenticated and reads project/job ids from `$_REQUEST`, but it only enqueues integer-sanitized ids; the queue worker (`JobQueue::processItem`) enforces `xtmProjectId === job.reference` (`isInvalidProjectInJob`, line 74) and re-downloads the translation from XTM over the authenticated API — request body content is NOT trusted. Residual: anonymous callers can enqueue items / trigger retrieval for matching (job,project) pairs.

See [api/callback.md](api/callback.md).
