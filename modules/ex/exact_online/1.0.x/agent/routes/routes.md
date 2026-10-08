<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, controllers, forms & permissions

All admin UI lives under `/admin/config/services/exact-online` (menu links in
`exact_online.links.menu.yml`: Connection / Settings / Logs under Configuration › Services).

## Permissions (`exact_online.permissions.yml`)

- `administer exact online configuration` — configure the integration settings (`restrict access: true`).
- `access exact online dashboard` — dashboard and basic connection operations.
- `access exact online logs` — view the integration log view.

## Routes (`exact_online.routing.yml`)

| Route | Path | Handler | Purpose |
| --- | --- | --- | --- |
| `exact_online.dashboard` | `/admin/config/services/exact-online` | `ExactOnlineDashboardController::dashboard` | Connection status, action buttons, last 10 log entries. |
| `exact_online.settings` | `/admin/config/services/exact-online/settings` | `ExactOnlineSettingsForm` | Settings form. |
| `exact_online.authorize` | `/admin/config/services/exact-online/authorize` | `ExactOnlineAuthController::authorize` | Starts the OAuth2 flow (redirects to Exact). |
| `exact_online.callback` | `/exact-online/callback` | `ExactOnlineAuthController::callback` | OAuth2 return endpoint; exchanges the code for tokens. |
| `exact_online.reset` | `/admin/config/services/exact-online/reset` | `ExactOnlineAuthController::reset` | Resets the connection (clears stored tokens); reached from the dashboard's "Reset / logout" action. |
| `exact_online.logs` | `/admin/config/services/exact-online/logs` | `ExactOnlineLogsController::overview` | Log view with filter form. |

Admin UI routes live under `/admin/config/services/exact-online` and use the permissions listed above; the OAuth2 `callback` is the provider's return endpoint.

## Controllers

- **`ExactOnlineDashboardController`** (`src/Controller/ExactOnlineDashboardController.php`)
  — builds the dashboard: warns (via `messages` markup) when `client_id` (config) or
  `client_secret` (State) is unset, otherwise shows connection status from
  `exact_online.service::getConnectionStatus()`, plus Configure/Logs/Authorize/Reset action
  links and a table of `getRecentLogs()`.
- **`ExactOnlineAuthController`** (`src/Controller/ExactOnlineAuthController.php`) —
  `authorize()` returns a `TrustedRedirectResponse` to `getAuthorizationUrl()`; `callback()`
  calls `handleCallback()` and redirects to the dashboard; `reset()` renders an AJAX
  confirmation modal and calls `resetConnection()` once confirmed.
- **`ExactOnlineLogsController`** (`src/Controller/ExactOnlineLogsController.php`) —
  `overview()` embeds `ExactOnlineLogsFilterForm`, reads query filters, and renders
  `exact_online.service::getLogs($filters)` as a sortable table (resolves the `user` id to a
  display name).

## Forms

- **`ExactOnlineSettingsForm`** — see [../config/settings.md](../config/settings.md).
- **`ExactOnlineLogsFilterForm`** (`src/Form/ExactOnlineLogsFilterForm.php`, form id
  `exact_online_logs_filter_form`) — a GET filter form (`#method: get`) with a `type` select
  (info/warning/error) and start/end date fields; `submitForm()` redirects to
  `exact_online.logs` with the chosen filters as query params.
