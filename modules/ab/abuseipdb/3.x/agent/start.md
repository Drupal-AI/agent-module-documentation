<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AbuseIPDB (abuseipdb) — agent index

Connects Drupal to the **AbuseIPDB** threat-intel API (`https://api.abuseipdb.com/api/v2/`):
**checks** visitor IPs against the abuse-reputation database and optionally **reports** and
**bans** abusive IPs. Package `Other`. Core `^10 || ^11`. License GPL-2.0-or-later. No composer
runtime deps, no external libraries. `configure` route `abuseipdb.settings`.

- **Config object, schema, the six admin forms, routes & permission** → [config/settings.md](config/settings.md)
- **API client, Reporter, ban-manager service-collector, event subscribers, form hook** → [api/client.md](api/client.md)

## What it provides

- **Services** (`abuseipdb.services.yml`):
  - `abuseipdb.client` → `ApiClient` — Guzzle wrapper around AbuseIPDB `check`/`report`.
  - `abuseipdb.reporter` → `Reporter` — decision layer (isAbusive/ban/report/whitelist/bypass/shutdown).
  - `abuseipdb.reporter_factory` → `ReporterFactory` — resolves the active ban manager from config.
  - `abuseipdb.ban_manager_collector` → `AbuseipdbBanManagerCollector` — `service_collector` on tag
    `abuseipdb_ban_manager`.
  - `abuseipdb.empty_ban_manager` → `EmptyAbuseipdbBanManager` — default no-op ban manager (`- None -`).
  - `abuseipdb.request` → `EventSubscriber\Request` — `KernelEvents::REQUEST`, checks "check paths".
  - `abuseipdb.terminate` → `EventSubscriber\Terminate` — `KernelEvents::TERMINATE`, reports/bans
    "blacklist paths".
- **Extension point**: `AbuseipdbBanManagerInterface` (`banIp`/`isBanned`/`getId`/`getModuleName`).
  Any module can tag a service `abuseipdb_ban_manager` to add a ban backend (see the two submodules).
- **Permission** (`abuseipdb.permissions.yml`): `abuseipdb bypass check` — holders skip all
  checks/reports/bans.
- **Config**: one config object `abuseipdb.settings` (schema in `config/schema/`, defaults in
  `config/install/`). No config entities, no plugin types, no Drush.
- **Hook**: `abuseipdb_form_alter()` + `abuseipdb_form_validate()` in `abuseipdb.module` add the
  IP check to form IDs listed in `abuseipdb.forms`.

## Routes (all `_permission: 'administer site configuration'`, under `/admin/config/services/abuseipdb`)

`abuseipdb.settings` (API key + core settings), `abuseipdb.form_check` (`/form-check`),
`abuseipdb.paths_check` (`/paths-check`), `abuseipdb.paths_report` (`/paths-report`),
`abuseipdb.report` (`/report`, manual report), `abuseipdb.whitelist` (`/whitelist`).
Local tasks/menu links in `abuseipdb.links.task.yml` / `abuseipdb.links.menu.yml`.

## Submodules

- `abuseipdb_core_ban` — ban manager backed by core **Ban** (`ban.ip_manager`).
- `abuseipdb_advban` — ban manager backed by **Advanced ban** (`advban.ip_manager`).

Each has its own doc tree under `modules/<name>/3.x/`.

## Operator notes (from source)

- "Abusive" = AbuseIPDB `abuseConfidenceScore` ≥ `abuse_confidence_score` (default **75**; **0 bans
  every IP**). Reporter caches shutdown flag; whitelist is CIDR-aware (`IpUtils::checkIp`).
- The `KernelEvents::REQUEST` check calls the API synchronously; `check_timeout` default `'0'` =
  wait indefinitely. Do **not** put high-traffic paths in check/report lists.
- IP source is always `Request::getClientIp()` (real connection IP unless Drupal trusted-proxy is
  configured).
