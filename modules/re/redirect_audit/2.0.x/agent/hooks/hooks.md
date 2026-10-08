<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks, queue worker, cron & install

## Hook class `Hook\RedirectAuditHooks` (OOP `#[Hook]`)

Registered as a service (`redirect_audit.services.yml`) with `@database`,
`redirect_audit.storage`, `config.factory`, `@queue`, `logger.factory`.

- `#[Hook('theme')]` — declares theme hook `redirect_audit_intermediate_links`
  (variables `items`, `warning_message`; template
  `templates/redirect-audit-intermediate-links.html.twig`) used to render the dashboard's
  "Full Redirect Flow" cell.
- `#[Hook('runtime_requirements')]` — adds a **Status Report** entry "Redirect Audit":
  OK when no chains/loops, otherwise a Warning summarizing counts (from
  `storage->getStats()`) linking to the dashboard.
- `#[Hook('redirect_insert')]` — marks the new redirect unprocessed in
  `redirect_audit_processed` and, if `scan_on_change` is on, queues it (op `insert`).
- `#[Hook('redirect_update')]` — queues the redirect (op `update`) when `scan_on_change`.
- `#[Hook('redirect_delete')]` — removes the redirect's audit rows
  (`storage->deleteByRedirectId()`) and its processed row.

`queueRedirect()` is a no-op when `scan_on_change` is FALSE. All three entity hooks guard
against a non-positive redirect id via `validateRedirectId()`.

## Queue worker — `Plugin\QueueWorker\RedirectAuditQueueWorker`

Plugin id `redirect_audit_queue`, `cron = {"time" = 60}` (processes items ~60s per cron
run). `processItem($data)`:
- Validates `{rid, operation}` (`validateQueueData()`).
- If the scan lock `redirect_audit_scan` is held (a dashboard/drush scan or fix is
  running), throws `SuspendQueueException` so items are retried on the next cron tick — it
  never inserts in parallel with a truncating scan.
- Loads the redirect (silently returns if it was deleted), calls
  `analyzer->analyzeRedirect()`, and saves chains/non-duplicate loops via
  `storage->saveChain()`. Intermediate-redirect chains are skipped (their head drives
  detection). When `autofix_enabled` and the record is a chain (not a loop), it calls
  `fixer->fixChain()`.

## Cron flow (scan-on-change)

With `scan_on_change` on: editing/creating a redirect enqueues it; the next cron run
drains `redirect_audit_queue` through the worker, updating the audit tables incrementally.
This is separate from the full, lock-guarded rescan triggered by the dashboard **Audit**
button or `drush ras`, which truncates and rebuilds the tables.

## Install / update — `redirect_audit.install`

- `hook_schema()` — creates `redirect_audit_chains` (`id` serial, `source_rid`,
  `target_rid`, `path` varchar(255); UNIQUE key `chain_signature` on
  (source_rid,target_rid,path); index on source_rid) and `redirect_audit_processed`
  (`rid` PK, `chain_processed` int timestamp; index on chain_processed).
- `hook_install()` — seeds the processed table with all existing redirect ids and, if
  `scan_on_change`, queues them for analysis; otherwise prompts a manual scan.
- `hook_uninstall()` — deletes the State keys `redirect_audit.last_scan` and
  `redirect_audit.last_cleared`.
- `redirect_audit_update_9001()` — re-queues all existing redirects (when scan_on_change).
- `redirect_audit_update_9002()` — deduplicates legacy self-loop/chain rows then adds the
  `chain_signature` UNIQUE index (safe to re-run).
