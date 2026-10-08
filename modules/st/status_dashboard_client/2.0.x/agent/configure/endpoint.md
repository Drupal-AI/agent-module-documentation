# The reporting endpoint, access check, and settings

## Endpoint

- Route `status_dashboard_client.check` → path `/status_dashboard/check`, `GET` only,
  `options: no_cache: TRUE`.
- Controller: `StatusDashboardClientController::doCheck()`.
- Access requirement: `_status_dashboard_access_check: 'TRUE'` (custom access check, below).

## Access check (shared secret)

`StatusDashboardClientAccessCheck::access(Request $request)`:

```php
$secret = $this->configFactory->get('status_dashboard_client.settings')->get('secret');
return AccessResult::allowedIf($request->headers->get('x-dashboard-secret') === $secret);
```

The caller (the base Status Dashboard site) must send header `x-dashboard-secret: <secret>`
matching the stored value. There is no permission on this route; the shared secret is the
gate. No default secret ships (no `config/install`), so set one after enabling.

## Settings form

- Route `status_dashboard_client.settings_form` → `/admin/config/development/status-dashboard-client`.
- Permission: `administer status_dashboard_client configuration` (`restrict access: true`).
- Menu link under *Configuration → Development*.
- `SettingsForm` (a `ConfigFormBase`) exposes a single `secret` textfield stored in
  `status_dashboard_client.settings:secret`.

Set the secret with Drush instead of the UI:

```
drush config:set status_dashboard_client.settings secret 'SOME-LONG-RANDOM-STRING' -y
```

## JSON payload (`doCheck`)

Runs `update_get_available(TRUE)`, loads `update.compare.inc`, then
`update_calculate_project_data()`. Builds:

| Key | Value |
|---|---|
| `date` | current timestamp (`datetime.time`) |
| `core` | `\Drupal::VERSION` |
| `modules` | map of extension display name → `info['version']` (all modules in the extension list) |
| `security_updates` | map of project title → recommended version, for projects with `security updates` and status ≤ `NOT_SUPPORTED` |
| `feature_updates` | map of project title → recommended version, when recommended ≠ existing and not a security update |
| `sitename` | `system.site:name` |
| `url` | `$request->getSchemeAndHttpHost()` |
| `error_count` | number of `system.manager` requirement lines with `severity > 1` (errors only) |

Then invokes `hook_status_dashboard_json_response_alter()` (see `hooks/alter.md`) and returns
a `JsonResponse` (HTTP 200). The base module stores each client's URL + secret and polls this
endpoint to aggregate status and (optionally) email notifications.
