# Hooks, cron & runtime behavior

## Entity hooks (`redirect_audit.module`)

Implemented for the `redirect` entity type:

| Hook | Behavior |
|------|----------|
| `hook_ENTITY_TYPE_insert` (`redirect_audit_redirect_insert`) | Marks the redirect unprocessed in `redirect_audit_processed`, then queues it (`_redirect_audit_queue_redirect`, operation `insert`) — only if `scan_on_change` is TRUE. |
| `hook_ENTITY_TYPE_update` (`redirect_audit_redirect_update`) | Queues the redirect (operation `update`) when `scan_on_change` is TRUE. |
| `hook_ENTITY_TYPE_delete` (`redirect_audit_redirect_delete`) | Removes all audit rows referencing the deleted rid (source, target, or an intermediate in `path`) via `RedirectAuditStorage::deleteByRedirectId()`, and clears its processed row. |

`hook_theme` registers `redirect_audit_intermediate_links` (template
`templates/redirect-audit-intermediate-links.html.twig`), which renders the dashboard's
"Full Redirect Flow" column as `From:`/`To:` lines with edit links per hop.

## Queue worker — `redirect_audit_queue`

`Drupal\redirect_audit\Plugin\QueueWorker\RedirectAuditQueueWorker`
(`@QueueWorker(id = "redirect_audit_queue", cron = {"time" = 60})`). On each cron run it
drains queued redirect IDs:

- If a manual scan/fix holds the `redirect_audit_scan` lock, it throws
  `SuspendQueueException` and retries the item on the next tick (avoids racing the batch).
- Loads the redirect, calls `analyzer->analyzeRedirect()`. Non-intermediate chains and
  new loops are saved via `storage->saveChain()`; intermediate-redirect chains are skipped
  (the chain head drives detection).
- If `autofix_enabled` is TRUE and the record is a chain (not a loop), it calls
  `fixer->fixChain()` immediately.

## Install / update / requirements (`redirect_audit.install`)

- `hook_schema` creates `redirect_audit_chains` (id, source_rid, target_rid, path; unique
  key `chain_signature` on the three data columns) and `redirect_audit_processed`
  (rid, chain_processed).
- `hook_install` seeds the processed table with all existing rids and, when
  `scan_on_change` is on, queues them for analysis.
- `hook_requirements` (runtime) surfaces a warning on the Status Report listing any
  unresolved chains/loops with a link to the dashboard.
- `redirect_audit_update_9001` queues existing redirects; `redirect_audit_update_9002`
  de-duplicates legacy audit rows and adds the `chain_signature` unique index.

## How a scan runs (dashboard)

The dashboard (`RedirectAuditDashboardForm`, route `redirect_audit.dashboard`) has three
submit buttons, each gated by `administer redirect audit` and Drupal form tokens:

- **Audit** → `batch_set` of `RedirectAuditBatch::processAudit` — chunked full scan
  (100 redirects/step), truncates then rebuilds the audit tables under the scan lock.
- **Fix** → `RedirectAuditBatch::processFix` — 25 chain records/step; rewrites chain
  sources, skips loops.
- **Clear** → acquires the scan lock, drains the queue, and truncates both audit tables.

All detection/fix work is DB + entity-graph resolution (path alias + language aware).
No step fetches a redirect target over HTTP.
