<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Crowd Bruteforce Protection (cbp) — agent index

A hybrid brute-force / vulnerability-scanner defense. It **decorates the core `flood` service**
and **subscribes to 404 exceptions** to detect attacks, reports suspicious IPs to a central
threat-intelligence API asynchronously, and **bans confirmed threats through the core `ban`
module**. Package `Security`. Depends on core **`ban`**. Core requirement `^9 || ^10 || ^11`.
License GPL-2.0-or-later. Version 2.0.0. Configure route **`cbp.settings`**.

- **Install, the API key config object, routes, permissions and the watchlist UI** →
  [config/settings.md](config/settings.md)
- **The detection & reporting engine — flood decorator, 404 subscriber, queue worker, watchlist** →
  [api/detection.md](api/detection.md)

## What it actually is (from source)

- **No permissions of its own** and **no Drush**. All three routes are gated by the core
  permission **`administer site configuration`** (`cbp.routing.yml`).
- **One config object** `cbp.settings` — a single key `api_key` (schema in
  `config/schema/cbp.schema.yml`, install default in `config/install/cbp.settings.yml`).
- **One DB table** `cbp_watchlist` (`cbp.install`): `ip` (pk), `threat_score`, `added`.

## Services (`cbp.services.yml`)

- `cbp.flood_watcher` — `Flood\FloodWatcher`, **decorates `flood`** (priority 5). Watches
  `register('user.failed_login_ip', …)`; on exceeding the core `user.flood` ip_limit it queues the
  IP to `cbp_flood_reporter` (debounced 1h via keyvalue `cbp.flood_debounce`).
- `cbp.not_found_subscriber` — `EventSubscriber\CbpNotFoundSubscriber`, on `KernelEvents::EXCEPTION`
  (priority 50). Filters static-asset 404s and internal broken links; counts 404s per IP
  (keyvalue `cbp.404_tracking`, TTL 1h) and reports to the API at threshold 10; re-bans
  watchlisted IPs on any 404.

## Plugins / controllers / forms

- QueueWorker `cbp_flood_reporter` (`Plugin/QueueWorker/FloodReportWorker.php`, `cron time=60`) —
  posts flood reports to the API; bans on score ≥ 80; state-based circuit breaker.
- Controller `Controller\CbpReportController::watchlist` — route `cbp.reports`, the watchlist table.
- Form `Form\CbpSettingsForm` — route `cbp.settings`, edits `api_key`.
- Form `Form\CbpWatchlistDeleteForm` — route `cbp.watchlist_delete/{ip}`, confirm form that
  deletes the row and unbans the IP.

## External API

All reporting goes to a single hard-coded endpoint over HTTPS
(`https://responsiveweb.io/cbp-v2/monitor`), authenticated with the `api_key` sent as the
`X-CBP-KEY` header. Without a key the module is **local-only** (flood + 404 detection, no
reporting, no server-driven bans).
