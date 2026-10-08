<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DropWatch (dropwatch) — agent index

Client module that reports site update/telemetry data to the external **DropWatch** SaaS
(`https://dropwatch.sh`). On cron and on demand it builds a JSON payload (core version + available
updates, PHP/web-server/database details, contrib project list with versions/recommended releases,
optionally watchdog PHP logs) and POSTs it to the DropWatch API. Package **DropWatch**.
Depends on core **`update`** (Update Manager). Core `^10 || ^11`. License GPL-2.0-or-later.
Installed version **1.0.0-beta7** (pre-release). No composer.json, no config schema, no Drush,
no submodules, no plugin types.

## What it provides

- **Service `dropwatch.service`** → `DropWatchService` — collects site data, builds the payload,
  and calls the client. Entry point `sendApiRequest()`. → [api/service.md](api/service.md)
- **Service `dropwatch.client`** → `DropWatchApiClient` — the HTTP client that POSTs the payload
  to the DropWatch endpoint with a Bearer token. → [api/client.md](api/client.md)
- **Settings form** `DropWatchSettingsForm` (config `dropwatch.settings`) — Site URL + per-category
  tracking checkboxes. → [config/settings.md](config/settings.md)
- **Manual-sync form** `DropWatchManualSyncForm` — one submit button that runs a sync now.
  → [config/manual-sync.md](config/manual-sync.md)
- **Routes, permission, menu & local tasks** — three admin routes, one permission
  `administer dropwatch`. → [routes/routing.md](routes/routing.md)
- **`hook_cron()`** in `dropwatch.module` — calls `dropwatch.service::sendApiRequest()` every cron run.

## Key facts (from source)

- API token is read at call time from Drupal core **`Settings::get('dropwatch_api_token', '')`**
  (i.e. `$settings['dropwatch_api_token']` in `settings.php`) — not a config field, not a Key entity,
  not `getenv`. The settings form only *displays* the settings.php snippet to copy.
- Outbound URL is **hard-coded** to `https://dropwatch.sh/api/v1/update` (not request/config-supplied).
- HTTP call uses the injected `@http_client` (Guzzle) with default TLS behavior.
