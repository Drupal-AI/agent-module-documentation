<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# XTM callback & queue

## Callback route
`/tmgmt_xtm_callback` (`tmgmt_xtm.callback`, `_access: 'TRUE'`) — `RemoteCallbackController::callback`.

- Reads `xtmJobId` (Connector::TMGMT_JOB_ID) → comma-split list of TMGMT job ids, `xtmProjectId`, `xtmJobId` from `$_REQUEST`.
- Casts project/job ids to `int` via `filter_var(... FILTER_SANITIZE_NUMBER_INT)`; returns HTTP 400 if `xtmProjectId` is empty.
- Enqueues `{xtmProjectId, tmgmtJobIds, xtmJobId}` onto queue `callback_job_queue` and returns an empty 200. No content is fetched inline.

## Queue worker (`JobQueue::processItem`)
For each tmgmt job id:
1. Load the `tmgmt_job` (or fall back to `tmgmt_job_item` → its job + remote-mapping reference).
2. **Guard:** `isInvalidProjectInJob($data['xtmProjectId'], $reference)` — bails if the stored job reference is null or `!== xtmProjectId`. This is what prevents a forged callback from binding an arbitrary XTM project to a local job.
3. `Connector::retrieveTranslation($job)` (or `retrieveContinuousTranslation`) downloads the translated files from XTM over the site's authenticated API and imports them.

**Net:** content is authoritative (re-fetched under the reference check); the only residual is unauthenticated queue insertion / retrieval triggering for legitimately matching pairs.
