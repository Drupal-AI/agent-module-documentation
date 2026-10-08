<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — adapter, API client, subscribers

## The adapter (`new_relic_rpm.adapter`)

Interface `\Drupal\new_relic_rpm\ExtensionAdapter\NewRelicAdapterInterface`. The service is
built by `AdapterFactory::getAdapter()`, which returns:
- `ExtensionAdapter` — thin wrappers over the PHP `newrelic_*()` functions — **iff**
  `extension_loaded('newrelic')`;
- `NullAdapter` — every method is a no-op — otherwise.

So on a host without the New Relic C extension the whole module degrades gracefully; calls
to the adapter simply do nothing (no fatals).

Interface methods (call from custom code via `\Drupal::service('new_relic_rpm.adapter')`):

| Method | Extension call | Purpose |
|---|---|---|
| `setTransactionState($state)` | `newrelic_background_job` / `newrelic_ignore_transaction` | `bg` marks background, `ignore` drops the transaction. |
| `setTransactionName($name)` | `newrelic_name_transaction` | Rename the current transaction. |
| `addCustomParameter($key,$value)` | `newrelic_add_custom_parameter` | Attach a custom attribute. |
| `recordCustomEvent($name,array $attrs)` | `newrelic_record_custom_event` | Send an Insights custom event (used for `SlowView`). |
| `logException($e)` | `newrelic_notice_error` | Report an exception. |
| `logError($msg,$e=NULL)` | `newrelic_notice_error` | Report an error message. |
| `disableAutorum()` | `newrelic_disable_autorum` | Suppress RUM JS injection for this request. |

Transaction-state constants: `STATE_NORMAL='norm'`, `STATE_BACKGROUND='bg'`, `STATE_IGNORE='ignore'`.

## The REST client (`new_relic_rpm.client`)

`\Drupal\new_relic_rpm\Client\NewRelicApiClient` — Guzzle wrapper over New Relic REST API
v2 (`https://api.newrelic.com/v2`), authenticated with the `X-Api-Key` header from
`new_relic_rpm.settings:api_key`.

- `listApplications($name = NULL)` — GET `/applications`, optionally filtered by name.
- `getAppId()` — resolves the app id from `newrelic.appname` (lazy, cached on the instance).
- `createDeployment($revision, $description = NULL, $user = NULL, $changelog = NULL)` —
  POST `/applications/{appId}/deployments`; returns TRUE/FALSE.
- `setAppName($name)` — override the app used for subsequent requests.

## Event subscribers (automatic, no API to call)

- `NewRelicRequestSubscriber` (priority 30, after RouterListener) — applies ignore/background
  URL + role rules and `disable_autorum` per request.
- `RoutingTransactionNameSubscriber` / `TransactionNameEnhancer` — name transactions by route.
- `ExceptionSubscriber` — forwards exceptions when `override_exception_handler` is TRUE.
- `NewRelicConfigSubscriber` — deployment marker on config import (`config_import`).
- `NewRelicLogger` (a `logger` channel) — forwards watchdog messages listed in
  `watchdog_severities`.
