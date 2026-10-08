# Health-check endpoint

Route `ohdear_integration.healthcheck` → `GET /json/oh-dear-health-check-results`,
served by `OhDearIntegrationController::buildJson()`. It returns the enabled
`monitoring` sensor results serialised in Oh Dear's application-health-check JSON
format, for Oh Dear's Application-health monitor to poll.

## Access
The route requirement is `_access: 'TRUE'`; the controller authenticates every request
itself in `OhDearIntegrationController::access(AccountInterface $account)`. Access is
allowed when **either**:
- the request presents the shared secret — header `oh-dear-health-check-secret` **or**
  query arg `?oh-dear-health-check-secret=<value>` — equal to the configured secret
  (`OhDearSdkService::getHealthcheckSecret()`: env `OHDEAR_HEALTHCHECK_SECRET` else config
  `ohdear_healthcheck_secret`); **or**
- the current account has the `monitoring reports` permission (from the monitoring module).

Otherwise it returns HTTP `403` with body `{"error": "Access denied!"}` (marked
`no-store`) and logs a notice. Configure Oh Dear's Application-health monitor with the
same secret string; Oh Dear sends it as the header. `buildJson()` renders inside a
`RenderContext` so late sensor render metadata is captured onto the response rather than
leaking.

## Payload
`OhDearHealthcheckGenerator::getData()` runs `monitoring.sensor_runner`
(`runSensors()`), maps each `SensorResultInterface` to an
`OhDear\HealthCheckResults\CheckResult` — status map OK→ok, CRITICAL→failed,
UNKNOWN→skipped, WARNING→warning, INFO→ok, anything unmapped→skipped — attaching the
sensor value/value-label as `meta`, and returns `CheckResults::toJson()`. Oh Dear caps a
report at 50 checks: if more than 50 sensors are enabled the list is truncated to 50 and
a warning is logged, so keep the enabled sensor count ≤ 50 at
`/admin/config/system/monitoring/settings`.

## Caching
Disabled by default. Set integer `healthcheck_cache_max_age` (seconds) on
`ohdear_integration.settings` to enable it. When set, `computeHeaders()` emits
`Cache-Control: public,max-age=<n>,s-maxage=<n>` plus `Last-Modified` / `Expires` /
`ETag` derived from the sensor batch `finishedAt`; when unset (0) it emits
`Cache-Control: private,no-cache,must-revalidate`. The response also carries cache tag
`monitoring_sensor_result` and cache contexts
`url.query_args:oh-dear-health-check-secret`, `headers:oh-dear-health-check-secret`,
`user.roles`.

Service `ohdear_healthcheck.page_cache_request_policy.disallow_ohdear_healthcheck_requests`
(a `RequestPolicyInterface` tagged `page_cache_request_policy`) returns `DENY` for any
request carrying the secret **header**, so Drupal's internal Page Cache never stores those
responses. To let the internal Page Cache serve cached health-check responses, send the
secret as the **query arg** instead of the header.
