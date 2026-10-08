<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `/healthz` health endpoint

## Install & enable

```bash
composer require drupal/monitoring_hrm
drush en monitoring_hrm -y
```

The only dependency is the contrib **`monitoring`** module (`monitoring:monitoring`, Composer
`drupal/monitoring:~1.14`), which supplies the sensors. No submodules, no permissions of its own,
no Drush commands.

## The route

`monitoring_hrm.routing.yml` defines exactly one route:

```yaml
monitoring_hrm.endpoint:
  path: '/healthz'
  defaults:
    _controller: '\Drupal\monitoring_hrm\Controller\MonitoringHrmController::healthEndpoint'
  methods: [GET]
  requirements:
    _monitoring_hrm_endpoint_access: 'TRUE'
```

- Path is the conventional **`/healthz`**; **GET only**.
- Access is a **custom access check** keyed by `_monitoring_hrm_endpoint_access`, not an RBAC
  permission — appropriate for a sessionless machine caller (a permission check would force the
  probe to authenticate).

## What the controller returns

`MonitoringHrmController::healthEndpoint()` (`src/Controller/MonitoringHrmController.php`),
constructed with the `monitoring.sensor_runner` service (`SensorRunner`):

1. `$results = $this->sensorRunner->runSensors();` — runs Monitoring's sensors (results may be
   cached by the sensor runner itself).
2. Filters to failures: `array_filter(..., fn ($r) => $r->getStatus() === SensorResultDataInterface::STATUS_CRITICAL)`.
   Only **CRITICAL** sensors count as failures — warnings/info do not.
3. Builds a `CacheableJsonResponse` with `CacheableMetadata` `setCacheMaxAge(0)` (response is
   **uncacheable**), body `['count_failures' => count($failures)]`, and status code
   **500 when there is ≥ 1 failure, otherwise 200**.

Response shape:

```
GET /healthz?token=<endpoint_key>
→ 200  {"count_failures": 0}     # all sensors OK
→ 500  {"count_failures": 3}     # 3 CRITICAL sensors
```

The body is identical in both cases apart from the count; the meaningful signal is the **status
code**, which is what a load balancer / Kubernetes probe / Pingdom / Statuscake acts on.

## The token access check

`MonitoringHrmEndpointAccessCheck::access(Request $request)`
(`src/Access/MonitoringHrmEndpointAccessCheck.php`), registered in `monitoring_hrm.services.yml`
with the tag `access_check` `applies_to: _monitoring_hrm_endpoint_access`:

- `$expectedKey = config('monitoring_hrm.settings')->get('endpoint_key');`
- `$userKey = $request->query->get('token');` — the key comes from the **`token` GET parameter**
  (constant `KEY_NAME = 'token'`).
- Returns
  `AccessResult::allowedIf(empty($expectedKey) || (is_string($userKey) && substr($userKey, 0, 32) == $expectedKey))`,
  adding cache context `url.query_args:token` and a cacheable dependency on the settings config.
- `substr($userKey, 0, 32)` caps the compared length at 32 characters, so keys longer than 32
  chars are effectively truncated for comparison.

So the caller authorizes itself by appending `?token=<endpoint_key>` to the URL.

## Configuration

There is **no admin UI** — no settings form, no config route. The one setting lives in config
object **`monitoring_hrm.settings`**:

- `config/install/monitoring_hrm.settings.yml` ships `endpoint_key: 'top secret'` (the install
  default).
- `config/schema/monitoring_hrm.schema.yml` types it as a `config_object` with a single string
  `endpoint_key`.

Set the key by editing exported config or with a `settings.php` override (per the README):

```php
$config['monitoring_hrm.settings']['endpoint_key'] = 'mySecret32CharacterKeyABCDEF1234';
```

Then request:

```
https://example.com/healthz?token=mySecret32CharacterKeyABCDEF1234
```

## Dependency on Monitoring

All health data comes from the contrib **`monitoring`** module: the controller depends on its
`SensorRunner` (`monitoring.sensor_runner`) and its `SensorResult` / `SensorResultDataInterface`
classes. `monitoring_hrm` contributes **no sensors of its own** — it only aggregates the CRITICAL
count from whatever sensors Monitoring is configured to run. Configure which sensors exist and
what they check in the Monitoring module.
