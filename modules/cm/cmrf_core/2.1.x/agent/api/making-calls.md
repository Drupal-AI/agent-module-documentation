<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Making CiviCRM API calls through cmrf_core

## The service
Everything goes through the `cmrf_core.core` service (`Drupal\cmrf_core\Core`, extending
`CMRF\Core\Core`). Get it with `\Drupal::service('cmrf_core.core')` or inject `@cmrf_core.core`.

## createCall / executeCall
```php
/** @var \Drupal\cmrf_core\Core $core */
$core = \Drupal::service('cmrf_core.core');

// Signature (from the abstract core):
// createCall($connector_id, $entity, $action, $parameters, $options = [], $callback = NULL, $api_version = '3')
$call = $core->createCall('my_connector', 'Contact', 'get', ['return' => 'id'], []);
$core->executeCall($call);          // synchronous
$reply = $call->getReply();         // decoded associative array
```
`$connector_id` is the machine id of a `cmrf_connector` config entity. `$entity` / `$action` are the
CiviCRM entity and action (e.g. `Contact` / `get`). `$parameters` are the CiviCRM API params.

## APIv3 vs APIv4
- Pass `$api_version = '3'` (default) or `'4'` as the last argument.
- For **v3**, `$parameters` + `$options` are compiled into the CiviCRM `json` payload; the request
  carries `entity`, `action`, `version`. Remote POST fields: `entity`, `action`, `version`, `json`.
- For **v4**, `$parameters` are sent as-is; the remote URL is `{urlV4}/{Entity}/{action}` and the
  POST field is `params`. The profile must define **URL APIv4** for v4 calls.
- See `Call::create()` in `src/Call.php` and `AbstractCurlConnection::createPostDataV3/V4` in the
  vendor library.

## Remote vs local transport
Chosen per connector by its `connectiontype`:
- **remote** (default) → `Drupal\cmrf_core\RemoteConnection` (extends `CMRF\Connection\Curl`). A cURL
  POST to the profile's URL. The library's `Curl::createPostData()` adds `api_key` and `key`
  (= site key) to the POST body. All remote calls run as the single configured CiviCRM API user.
- **local** → `Drupal\cmrf_core\LocalConnection` (extends `CMRF\Connection\Local`). Only offered when
  the `civicrm` service exists (CiviCRM installed in the same Drupal). Calls `civicrm_api3()` /
  `civicrm_api4()` directly, **as the currently logged-in Drupal/CiviCRM user** — so per-user CiviCRM
  permissions apply, unlike remote. `Core::getConnection()` calls `\Drupal::service('civicrm')->initialize()` first.

## Options
`$options` is an associative array stored in the call metadata. Recognized keys (`Call::initOptions`):
- `cache` — a strtotime-style interval string (e.g. `'10 minutes'`, `'1 day'`). Sets `cached_until`;
  a later identical call (same request hash + connector) within the window returns the stored reply
  instead of calling CiviCRM. See `CallFactory::createOrFetch()`.
- `retry_count` — number of automatic retries on failure.
- `retry_interval` — strtotime interval between retries (default `10 minutes`); a failed call with
  retries left is set to `RETRY` with a `scheduled_date` (`Call::checkForRetry`).
- Any other keys are preserved in metadata.

## Sync vs queued
`executeCall()` runs the call **synchronously** and immediately. The framework also supports a
queued/persisted model: calls always land in the `civicrm_api_call` table with a status
(`INIT`/`RETRY`/`DONE`/`FAILED`), and `CallFactory::getQueuedCallIds()` returns `INIT`/`RETRY` calls
whose `scheduled_date` is due — used by callers that process the queue (e.g. cmrf_webform's queued
submissions). The Connection subclasses' `queueCall()` just persists the call via the factory.

## Callbacks / hooks on completion
- Pass a callable (or array of callables) as `$callback`; stored in metadata.
- On completion the Call invokes module hooks: `hook_cmrf_core_call_done($call)` on `DONE` and
  `hook_cmrf_core_call_failed($call)` on `FAILED` (`Call::checkAndTriggerDone/Failure`).

## The call log
Every call row holds `status`, `connector_id`, `entity`, `action`, `request` (JSON), `reply` (JSON),
`metadata` (JSON), `request_hash`, timing (`create_date`, `reply_date`, `scheduled_date`,
`cached_until`, `duration`), and `retry_count`. Schema comes from
`SQLPersistingCallFactory::schema()` (vendor). Note: the stored `request` does **not** contain the
`api_key`/`site_key` — those are added only at POST time by the transport, not persisted.

## Purging
`cmrf_core_cache_flush()` and `cmrf_core_cron()` call `CallFactory::purgeCachedCalls()`, which deletes
expired/`DONE` cached rows, deletes rows older than each profile's `cache_expire_days`, and clears
`FAIL` rows matching each profile's `cache_clear_failed_api_calls` list (`entity.action` per line).
