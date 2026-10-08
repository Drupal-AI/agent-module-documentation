<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the health endpoint

Admin form: **Configuration → Development → Health Check URL settings**
(`admin/config/development/health`, route `health_check_url.admin`, permission
`health_check_url administration`).

## Config object `health_check_url.settings`

| Key | Meaning | Default |
|---|---|---|
| `type` | Response format (see below) | `timestamp` |
| `string` | The text used by string formats | `Passed` |
| `endpoint` | Endpoint path, must start with `/` | `/health` |
| `maintainence_access` | Respond during maintenance mode (note spelling) | `false` |

### `type` values (body produced by `HealthCheckController`)

- `timestamp` → `time()` (unix seconds)
- `string` → the `string` value verbatim
- `stringWithTimestamp` → `"<string> - <time()>"`
- `stringWithDateTime` → `"<string> at H:i:s on m/d/Y"`
- `stringWithDateTimestamp` → `"<string> at H:i:s on m/d/Y (<time()>)"`

The response is always `Content-Type: text/plain` and the route is `no_cache`.

## Reading / writing config

```bash
drush config:get health_check_url.settings
drush config:set health_check_url.settings endpoint /healthz -y
drush config:set health_check_url.settings string   HCU-OK  -y
drush config:set health_check_url.settings type      string  -y
```

```php
\Drupal::configFactory()->getEditable('health_check_url.settings')
  ->set('type', 'string')
  ->set('string', 'HCU-OK')
  ->set('endpoint', '/healthz')
  ->set('maintainence_access', FALSE)
  ->save();
```

## How the endpoint route is registered

`health_check_url.routing.yml` declares `route_callbacks: ['health_check_url.route_service:routes']`.
`RouteService::routes()` reads `health_check_url.settings`, trims the `endpoint` of slashes
(fallback `health`), and adds route `health_check_url.content` at `/<endpoint>` with
`_access: 'TRUE'`, `no_cache`, and `_maintenance_access` from `maintainence_access`. It also
adds the admin form route `health_check_url.admin`.

Because the path lives in a route built from config, **a changed `endpoint` only takes
effect after a router rebuild** — the settings form calls
`\Drupal::service('router.builder')->rebuild()` on submit; if you set the config directly,
run `drush cr` (or rebuild routes) so the new path is served. Endpoint validation requires
a leading `/` (empty falls back to `/health`).
