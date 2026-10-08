<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CBP detection & reporting engine

Three cooperating pieces detect attacks, report them to the API, and ban confirmed threats.
Shared state: DB table `cbp_watchlist`, keyvalue collections `cbp.404_tracking` and
`cbp.flood_debounce`, `state` keys `cbp.api_failure_count` / `cbp.circuit_breaker_until`, queue
`cbp_flood_reporter`. All API traffic is a Guzzle `POST` to `https://responsiveweb.io/cbp-v2/monitor`
over HTTPS with header `X-CBP-KEY: <api_key>`.

## 1. Flood decorator — `Flood\FloodWatcher`

Decorates core `flood` (`decorates: flood`, priority 5), implements `FloodInterface` and delegates
every method to `$inner`.

- `register($name, $window, $identifier)` — calls `inner->register()` first (never blocks core),
  resolves the IP from the request stack when `$identifier` is NULL, and **only for
  `name === 'user.failed_login_ip'`** checks `inner->isAllowed()` against the `user.flood`
  `ip_limit` (default 50). If over the limit → `queueReport()`.
- `queueReport($ip, $event)` — debounced via keyvalue `cbp.flood_debounce`: if `has($ip)` returns,
  otherwise creates a `cbp_flood_reporter` queue item `{ip, event, timestamp}` and sets a 1h flag.
- `clear($name, $identifier)` deletes the debounce flag so an IP can be re-reported after an admin
  clears its flood.

## 2. Queue worker — `Plugin/QueueWorker/FloodReportWorker` (id `cbp_flood_reporter`, `cron time=60`)

`processItem($data)`:

1. **Circuit breaker**: if `time() < state('cbp.circuit_breaker_until')` throws
   `SuspendQueueException` (pauses the whole queue).
2. Returns early if no `ip` in the item, or if `cbp.settings.api_key` is empty.
3. `POST`s `{m:'bruteforce', u:'flood_event', ip, event, t}` (timeout 5s). On success deletes
   `cbp.api_failure_count`.
4. If the response is `{status:'threat_detected', threat_score >= 80}`: bans via
   `ban.ip_manager->banIp()` (if not already) **and** `MERGE`s the IP into `cbp_watchlist`, then
   logs a notice.
5. On any exception: increments `cbp.api_failure_count`; at `FAILURE_THRESHOLD` (5) sets
   `cbp.circuit_breaker_until = now + 600s` and throws `SuspendQueueException` (fail-open).

## 3. 404 subscriber — `EventSubscriber\CbpNotFoundSubscriber` (EXCEPTION, priority 50)

`onNotFound()` runs only for `NotFoundHttpException`; IP from `request->getClientIp()`:

1. **Strike-two**: if the IP `isWatchlisted()` (a `SELECT` on `cbp_watchlist`) and not already
   banned → `ban.ip_manager->banIp()` and return.
2. **False-positive filters**: skip if the request path extension is in `IGNORED_EXTENSIONS`
   (css/js/images/fonts/map…). Skip if the `Referer` host equals the current host **and** the
   schemes match (internal broken link → logged as a warning, not counted); a scheme mismatch
   (http→https) is treated as bot behaviour and still counted.
3. **Velocity**: increment a per-IP counter in keyvalue `cbp.404_tracking` (TTL 3600s).
4. At `REPORT_THRESHOLD` (10) → `processVulnerabilityReport()` then delete the counter.

`processVulnerabilityReport($ip, $request)` — returns early if no `api_key`. Builds a "scan map"
by reading the last 20 `watchdog` rows where `type = 'page not found'` and `hostname = $ip`
(`unserialize($row->variables)`, pulling `@uri`/`%location`), adds the current URI, and `POST`s
`{m:'vuln_scan', ip, paths, ua, t}` (timeout 2s). If the JSON response has
`threat_score >= 50` it `addToWatchlist()` (MERGE into `cbp_watchlist`) and logs a warning.
The IP is **not** immediately banned here — it is banned on its next 404 by the strike-two rule.

## Operating notes

- Enable the core **`ban`** module (dependency) — all banning goes through `ban.ip_manager`.
- Reports require a valid `api_key`; server-driven bans only occur when the endpoint returns a
  qualifying `threat_score`. With no key, only local flood/404 counting happens (no bans).
- Run cron regularly so `cbp_flood_reporter` drains; the circuit breaker keeps a dead API from
  stalling the site (queue is suspended, not failed).
- Watchlist entries are inspected/removed at `/admin/config/services/cbp/reports` (see
  [../config/settings.md](../config/settings.md)); removing a row also unbans the IP.
