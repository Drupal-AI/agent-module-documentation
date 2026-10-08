<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Monitoring HRM (monitoring_hrm) — agent index

Single GET route **`/healthz`** whose HTTP status (200 or 500) says whether any **Monitoring**
sensor is failing, plus a tiny JSON body `{"count_failures": N}`.
Version **2.0.0**. Core `^10.2 || ^11`, **PHP 8.1**. Depends on `monitoring:monitoring` (`~1.14`).
Package *Monitoring*. No permissions, no Drush, no submodules, no UI.

- **Install, the `/healthz` route, the token access check, the JSON response, and config** →
  [endpoint/health-endpoint.md](endpoint/health-endpoint.md)

## What it actually is (from source)

- One controller `MonitoringHrmController::healthEndpoint()`
  (`src/Controller/MonitoringHrmController.php`): calls
  `monitoring.sensor_runner`'s `runSensors()`, filters results to
  `SensorResultDataInterface::STATUS_CRITICAL`, returns a `CacheableJsonResponse` with
  `setCacheMaxAge(0)`, body `['count_failures' => count(failures)]`, status **500** when there
  is at least one failure else **200**.
- One route `monitoring_hrm.endpoint` (`monitoring_hrm.routing.yml`): path `/healthz`,
  `methods: [GET]`, requirement `_monitoring_hrm_endpoint_access: 'TRUE'` — a **custom access
  check**, not a permission (correct for a machine caller with no session).
- One access check `MonitoringHrmEndpointAccessCheck::access()`
  (`src/Access/MonitoringHrmEndpointAccessCheck.php`, service tag `access_check`
  `applies_to: _monitoring_hrm_endpoint_access`): reads config `monitoring_hrm.settings`
  `endpoint_key`, reads the `token` GET param, allows when the key is empty **or** the token's
  first 32 chars equal the key.
- Config object `monitoring_hrm.settings` with one key `endpoint_key`
  (install default **`'top secret'`**; schema in `config/schema/monitoring_hrm.schema.yml`).
  **No settings form / route** — set the key via config export or a `settings.php` override
  (`$config['monitoring_hrm.settings']['endpoint_key'] = '…';`).

## Deployment note

The caller is a probe, not a browser: authorize it with `?token=<endpoint_key>`. There is no admin
form, so the key lives in config. As with any such endpoint, be explicit in the deployment about who
can reach `/healthz` (e.g. restrict it at the reverse-proxy / network layer to the probing hosts).
