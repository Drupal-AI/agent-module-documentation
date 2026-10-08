<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Uptime monitoring endpoint

A stable, token-protected URL that external uptime monitors (UptimeRobot, StatusCake, NewRelic,
etc.) can poll to check the site is up. Deliberately cheap and cache-bypassing so a poll always
executes a real Drupal bootstrap.

## Route

`cm_tools.monitoring` (`cm_tools.routing.yml`):

```yaml
cm_tools.monitoring:
  path: '/cm_tools/monitoring/{token}'
  defaults:
    _controller: '\Drupal\cm_tools\Controller\CmToolsMonitoringController'
  requirements:
    _custom_access: '\Drupal\cm_tools\Controller\CmToolsMonitoringController::access'
  options:
    _maintenance_access: TRUE
```

- The controller is invokable (`__invoke`); the class is the `_controller`.
- `_maintenance_access: TRUE` means the endpoint answers even while the site is in maintenance
  mode, so monitors do not false-alarm during a maintenance window.

## The token

`cm_tools_get_uptime_path_token()` (`cm_tools.module`) returns a per-site secret stored in State
under `cm_tools_uptime_path_token`. On first read it is generated with
`Crypt::randomBytesBase64(64)` (64 random bytes, high entropy) and persisted. It is a **stable**
value — it does not rotate — so the monitoring URL can be configured once in an external tool.

The full URL (with token substituted) is shown to admins on the status report via
`hook_requirements()` in `cm_tools.install` (title "CM Tools - Monitoring"). There is no UI to
regenerate it; delete the State key with `drush state:delete cm_tools_uptime_path_token` (or
`\Drupal::state()->delete(...)`) to force a new one on next access.

## Access check

`CmToolsMonitoringController::access(string $token)`:

```php
if ($token === cm_tools_get_uptime_path_token()) {
  return AccessResult::allowed();
}
return AccessResult::forbidden();
```

The `{token}` path segment must exactly equal the stored secret. A wrong/absent token yields 403.
No permission or role is involved — knowledge of the token is the sole gate (a "capability URL").

## Response

`__invoke()`:

```php
$this->pageCacheKillSwitch->trigger();               // never page-cached
$output  = Crypt::hashBase64(__FUNCTION__ . cm_tools_get_uptime_path_token()) . "\n";
$output .= date('c');                                // current server date/time, ISO-8601
return new Response($output);
```

- The page-cache kill switch (`page_cache_kill_switch` service, injected) guarantees each request
  is served fresh — the body's timestamp is always current, proving the site actually responded.
- Body is two lines: a stable base64 hash (constant per site, derived from the token — lets a
  monitor assert on fixed content that Apache/nginx error pages would not emit) and the live
  `date('c')`.
- Returns a bare `Symfony\Component\HttpFoundation\Response` (plain text), HTTP 200.

## Agent notes

- Treat the monitoring URL as a secret; anyone with it can poll the endpoint (it only reveals a
  site-constant hash + the current time — no site data).
- To find the URL programmatically: `Url::fromRoute('cm_tools.monitoring', ['token' => cm_tools_get_uptime_path_token()], ['absolute' => TRUE])`.
