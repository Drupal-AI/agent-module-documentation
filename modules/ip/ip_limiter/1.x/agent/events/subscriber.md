<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events — enforcement subscriber, ban lifecycle, admin bans list

## The subscriber
`Drupal\ip_limiter\EventSubscriber\IpLimiterSubscriber` (service `ip_limiter.event_subscriber`,
constructed with `@config.factory`, `@database`, `@datetime.time`, `@ip_limiter.rule_manager`).

- **Subscribes:** `KernelEvents::REQUEST => ['onRequest', 512]`. Priority 512 is very high, so it runs
  **before routing, authentication, and access checks** — banned IPs are stopped early with minimal work.

## Client IP determination
`onRequest()` sets `$this->ipAddress = $this->request->getClientIp() ?? ''` and returns early if empty.
`Request::getClientIp()` returns the direct socket peer (`REMOTE_ADDR`) unless Drupal is configured
with trusted reverse proxies (`$settings['reverse_proxy']` + `reverse_proxy_addresses` /
`Request::setTrustedProxies()`), in which case Symfony resolves the real client from the trusted
`X-Forwarded-For` chain. Practical implication for operators: behind a proxy/CDN you must configure
Drupal's reverse-proxy settings, otherwise every request looks like it comes from the proxy IP and
bans hit the proxy. The module reads the resolved value from core; it does not parse raw forwarded
headers itself.

## Per-request evaluation flow
With `$this->ruleManager` present, `getConfiguredRules($settings)` returns the rule instances. For
each rule, in config order:
1. `$applies = $rule->applies($request)`; `$global = $rule->isGlobalRestrict()`.
2. If `!$applies && !$global` → `continue` (rule ignores this request).
3. If already banned (`isBanned($global, $applies)`) → `denyAccess($event, $rule->getResponseType())`
   and **return** (stops at the first blocking rule).
4. Else `logVisitAndCheckBanWithParams($period, $max, $duration)` — log the visit, count recent
   visits, ban if over threshold; then re-check `isBanned(TRUE, TRUE)` and deny if now banned.

If no rule blocks (or there are no rules / no manager) the request is allowed. `denyAccess()` calls
`$event->setResponse()` with a bare `Response` of the chosen status (403/404/429) — this genuinely
short-circuits the kernel; it is not merely logging.

`isBanned($global, $isVisitRestricted)` = a ban row exists AND `ban_end > REQUEST_TIME` AND
(`$global` OR `$isVisitRestricted`). So a `global_restrict` rule enforces an existing ban on **every**
request even where the rule's primary match does not apply.

## Counting & banning
- `logVisit()` inserts `{ip_address, timestamp}` into **`ip_limiter_log`** on each evaluated request.
- Count = rows for this IP with `timestamp > REQUEST_TIME - time_period`. Ban fires when
  `count >= max_requests`.
- `banIpAddressWithDuration($banDuration)` writes **`ip_limiter_ban`**. New ban: `multiplier=1`,
  `ban_end = now + banDuration`. Existing ban (re-offense): `multiplier *= 2`,
  `ban_end = now + banDuration * newMultiplier` (escalation). It also stores the `User-Agent` and
  `Referer` headers (truncated to 512 chars) for the admin bans list, and deletes that IP's
  `ip_limiter_log` rows.

## Cron decay/cleanup (`ip_limiter.module`)
`hook_cron` → `ip_limiter_cron()` uses `time_period`/`ban_duration` read from `ip_limiter.settings`
(top-level keys — legacy; normally absent post-migration, so these evaluate against NULL/0) with
`cleanup_threshold = REQUEST_TIME - time_period*2`:
- `ip_limiter_reduce_old_ban_multipliers()` — for expired bans with `multiplier > 1` not updated since
  the threshold, halves the multiplier (`max(1, floor(m/2))`) and re-sets `ban_end`.
- `ip_limiter_remove_old_bans()` — deletes expired `multiplier=1` bans older than the threshold.

## Tables (`ip_limiter.install` hook_schema)
- **`ip_limiter_log`**: `id` (serial), `ip_address` (varchar 45), `timestamp` (bigint). Rows for an IP
  are cleared when that IP is banned; the counting query only reads rows inside the window.
- **`ip_limiter_ban`**: `id`, `ip_address` (45), `created`, `updated`, `multiplier` (default 1),
  `ban_end`, `user_agent` (varchar 512, nullable), `referer` (varchar 512, nullable).

## Admin bans list & unban
- `IpLimiterController::bannedIps()` (route `ip_limiter.bans`,
  `/admin/config/system/ip-limiter/banned-ips`) renders a `#theme => 'table'` of all ban rows ordered
  by `ban_end DESC`, columns IP / Created / Updated / Multiplier / Ban Ends / User-Agent / Referer /
  Operations, dates via `date.formatter` `short`. Stored header strings sit in plain-string table
  cells, so they are rendered through the render system's auto-escaping (not raw HTML). Empty text:
  "No banned IPs found."
- Each row has an **Unban** link to route `ip_limiter.unban`
  (`/admin/config/system/ip-limiter/unban/{ip_address}`) →
  `IpLimiterUnbanConfirmForm` (a `ConfirmFormBase`, so a CSRF-token-protected POST confirmation) which
  `DELETE`s the `ip_limiter_ban` row for that IP and redirects back to the list.

All three routes require the `administer ip limiter configuration` permission (`restrict access: true`).
