# Services & data API

Declared in `ohdear_integration.services.yml`. Three public services wrap the Oh Dear
PHP SDK plus the admin report pages.

## `ohdear_sdk` — OhDearSdkService
Bridge to `OhDear\PhpSdk\OhDear`. Credentials use env-over-config precedence and results
are memoised per request.
- `getOhDear(): OhDear` — builds the SDK client from env `OHDEAR_API_KEY` else config
  `ohdear_api_key`; logs an error and throws `\Exception` if neither is set.
- `getMonitorId(): int` — env `OHDEAR_MONITOR_ID` else config `ohdear_monitor_id`; throws if 0/empty.
- `getMonitor(): Monitor` — the configured monitor object (`OhDear::monitor()`).
- `getHealthcheckSecret()`, `getCronUri()`, `getHealthcheckCacheMaxAge()` — config/env reads.

## `ohdear_integration.info` — OhDearInfo (arg `@ohdear_sdk`)
Read helpers over the SDK; uses `DateFormatValidationTrait` for `Y-m-d H:i:s` validation.
- `getChecks(?int $monitorId)` — monitor checks array (empty on failure).
- `getSiteLabel(?int $monitorId)`, `listMonitors()`, `prettySiteList()`.
- `getParsedUptime(?monitorId, ?from, ?to, split='day')` — validates `from`/`to`, defaults
  to the last 7 days; `split` maps to `UptimeSplit` (hour/day/month/year).
- `getParsedBrokenLinks(?monitorId)` — crawledUrl / statusCode / foundOnUrl rows.
- `getMaintenancePeriods(?monitorId)` — maintenance-window objects.
- `getProvidedOrCurrentMonitorId(?monitorId)` — falls back to the configured monitor when 0/null.

## `ohdear_healthcheck.generator` — OhDearHealthcheckGenerator
Args `@monitoring.sensor_runner`, `@logger.factory`. Converts monitoring sensor results
to Oh Dear check results — see [healthcheck-endpoint.md](healthcheck-endpoint.md).
Public methods: `getData(): string`, `getCheckResults()`,
`convertSensorResultToOhdearHealthcheck()`, `getCheckResult()`.

## Report pages — OhdearInfoController (permission `access ohdear info`)
| Route | Path | Shows |
|---|---|---|
| `ohdear_integration.info` | `/admin/reports/ohdear/info/{monitor_id}` | Table of Oh Dear checks (id/type/settings stripped) |
| `ohdear_integration.broken_links` | `/admin/reports/ohdear/broken-links/{monitor_id}` | Broken links crawled by Oh Dear |
| `ohdear_integration.uptime` | `/admin/reports/ohdear/uptime/{monitor_id}` | Uptime %; query args `from`, `to` (`Y-m-d H:i:s`), `split` (hour/day/month) |

`{monitor_id}` is typed integer, default `0`, which resolves to the configured monitor.
These pages appear as local tasks/tabs ("OhDear Checks", "Uptime", "Broken Links") under
the monitoring sensor list.
