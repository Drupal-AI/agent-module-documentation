<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reporting pipeline — access_job_reporting

The end-to-end flow: TAPIS job insert to enqueue to cron POST to ACCESS. Source:
`access_job_reporting.module`, `src/AccessJobReporter.php`,
`src/Plugin/QueueWorker/AccessJobQueueWorker.php`.

## 1. Per-system opt-in (node form)

`access_job_reporting_form_node_form_alter()` adds a details fieldset **only** when the node's
bundle is `tapis_system`:
- `sys_access_report_enabled` (checkbox) → stored as `systems.<nid>.enabled` (int 0/1).
- `sys_access_resource_map` (textarea) → stored as `systems.<nid>.resource_map` (string), one
  mapping per line, format `resource | queue1, queue2`.
- A submit handler `access_job_reporting_tapis_system_submit()` is appended to each submit button
  and writes both values into `access_job_reporting.settings` via `getEditable(...)->save()`.
- `access_job_reporting_validate_resource_map()` (element validator) enforces `resource | queues`
  syntax and rejects a queue mapped to two different resources within one system.

## 2. Enqueue on job insert

`access_job_reporting_tapis_job_insert()` → `access_job_reporting_enqueue_for_job(TapisJobInterface
$entity)`:
1. Requires the job's system and app to be `NodeInterface`s; else return.
2. Reads `systems.<sysId>.enabled`; if 0, **return** (reporting off for that system).
3. Loads full TAPIS job metadata via `\Drupal::service('tapis_job.tapis_job_provider')
   ->getJob($tenantId, $entity->getTapisUUID(), $jobOwnerId)` (try/catch → log + return).
4. Builds the queue-to-resource map with `reporter->buildQueueToResourceMap(resource_map)` and does
   a **case-insensitive** lookup on `execSystemLogicalQueue`. If no resource matches, **return**
   (job not reportable).
5. Parses `parameterSet.schedulerOptions` for an arg starting `--account` → `allocation`.
6. Loads the owner `user` entity, requires a non-empty **UUID** (else warn + return); derives
   `gateway_user` from `first_name`+`last_name` fields, else `getAccountName()`.
7. Derives `submittime` from `remoteSubmitted`/`created` (numeric epoch or `strtotime`), and
   `software` from the app title + `DrupalIds::APP_VERSION`.
8. Calls `reporter->enqueue(...)`.

`AccessJobReporter::buildQueueToResourceMap(string $mapText): array` — splits lines, ignores blanks
and `#` comments, `explode('|', …, 2)`, lowercases queue keys, keeps the first mapping on a
duplicate (logs a warning). Returns `[queueKeyLower => resourceName]`.

## 3. Queue item shape

`AccessJobReporter::enqueue()` calls `queueFactory->get('access_job_reporting.job_queue')
->createItem([...])` with keys: `tapis_job_id`, `tapis_job_uuid`, `tenant_id`, `job_owner_id`,
`remote_job_id`, `account_uuid`, `gateway_user`, `submittime`, `software`, `allocation`,
`resource`, `queue`, `attempt_count` (0), `last_attempt` (0), `status` ('queued').

## 4. Cron delivery (`AccessJobQueueWorker`)

Plugin id **`access_job_reporting.job_queue`**, `cron time = 20`. `processItem($data)`:
1. Resolves the API key: config `api_key`, overridden by `key.repository->getKey(api_key_key)
   ->getKeyValue()` when `key` is enabled and a key is selected (try/catch fallback).
2. Reads `retry_interval` (default 86400) and `max_attempts` (default 15).
3. **Backoff gate**: if `attempt_count > 0` and `time() - last_attempt < retry_interval`, throws
   (requeues without processing) so cron retries later.
4. Builds headers `XA-API-KEY` (+ `XA-AGENT` when set).
5. If `remote_job_id` is empty and tenant/owner/uuid are present, calls `refreshFromTapisJob()` — a
   fresh `tapisJobProvider->getJob(...)` to fill `remote_job_id`/`submittime`. If still no
   `remote_job_id`, logs a warning and **returns** (drops the item).
6. Builds `form_params`: `gatewayuser`, `xsederesourcename` (the mapped resource), `jobid`
   (= remote job id), `submittime`, optional `software`; adds `debug => 'x'` in debug mode.
7. **Debug mode**: logs "not reported" and (per the flag) does not perform a real send.
8. Guzzle **POST** to `endpoint_url` (fallback `PROD_ENDPOINT`) with `headers`, `form_params`,
   `http_errors => FALSE`. Default Guzzle TLS verification is left on.
9. `2xx` → log success and return (item removed). Non-2xx or thrown → increment `attempt_count`,
   set `last_attempt = time()`; if `>= max_attempts` log a permanent error and return (drop), else
   rethrow to requeue.

## Notes

- Delivery is **outbound only**; the module exposes no route to view reported data — no cross-user
  id-parameter read surface.
- `processItem()` logs the full item payload and API response body at `info` level (includes the
  `gateway_user` display name and `account_uuid`); consider raising the log level or trimming for
  privacy on production.
- No raw SQL (uses core queue + config APIs); no JWT.
