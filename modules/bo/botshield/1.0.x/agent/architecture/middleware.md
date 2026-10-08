<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BotShield enforcement pipeline (`BotShieldMiddleware::handle`)

`src/StackMiddleware/BotShieldMiddleware.php` — tagged `http_middleware` priority **250**
(`botshield.middleware`). It `implements HttpKernelInterface` and delegates to the wrapped kernel.
Decision order for a request (returns early = request passes through unmodified):

1. **Sub-requests** (`$type !== MAIN_REQUEST`) → pass.
2. `botshield.settings:enabled` false → pass.
3. `isStaticAssetPath($path)` (extensions like css/js/png/woff, prefixes `/core/`, `/themes/`,
   `/modules/`, `/sites/default/files/`, `robots.txt`, …) → pass.
4. `isInternalUtilityPath()` (`/history/{n}/read`, `/account/*?check_logged_in=1`) → pass.
5. Resolve `$ip = resolveClientIp($request)` and an effective account (see below).
6. **Account/role bypass is disabled**: `isBypassUser()`, `isBypassUid()`, `isRuntimeBypass*()`,
   signed-cookie checks all resolve to FALSE by construction — the large session/cookie/runtime
   "bypass" machinery is dormant in 1.0.x.
7. **`/admin` paths → pass** (Phase 1 admin-usability carve-out; response still recorded).
8. `traffic_scope === 'anonymous'` and the request is authenticated **without** a session cookie → pass.
9. `$ip === ''` → pass.
10. **Override file** (`override_ips_path`, default `private://botshield/botshield-overrides.txt`):
    IP present → pass.
11. **Alert allow-lists** (state `botshield.alert.allow_ips` + config `alert_allow_ips`): IP present → pass.
12. **Whitelist** (`whitelist_ips`, newline-separated): IP present → pass.
13. Classify UA: `$bot = botClassifier->classify(UA)` → `{label, confidence}`. Resolve path group
    (`resolvePathGroup(path_group_rules, path)`, default `page`). `alert_allow_bots` match → pass.
14. **Resolve policy** — `custom_bots` regex rows first (`@preg_match('~'.$regex.'~i', $ua)`,
    confidence 70), else `bot_actions[label]`. Action ∈ `allow|rate_limit|block` (invalid/`log`→`allow`;
    `rate_limit` with no positive `rpm`→`allow`).
15. **Manual IP policy** (`ip_policies`, exact IP or CIDR via `ipInCidr`, IPv4/IPv6): `allow` logs+passes;
    `rate_limit` registers a Flood counter (`ip_policy` group) and on breach `blocks->block(...)` for
    `ip_policy_block_seconds` (default 3600); `block` blocks immediately. Blocked → **429** (`tooMany`).
16. **Active blocklist**: `blocks->remainingSeconds($ip) > 0` → **429**.
17. **Bot policy `block`** → `blocks->block($ip, block_seconds≥60, 'bot_policy_block', …)` → **429**.
18. **Unknown-bot flood** (`unknown_flood_control_enabled` && label `unknown`): Flood group
    `flood_unknown`, breach → block `unknown_flood_block_seconds` (default 1800) → **429** + alert.
19. **Site-wide flood** (`flood_control_enabled`): Flood group `flood_sitewide`, breach → block
    `flood_control_block_seconds` (default 3600) → **429** + alert.
20. **Per-group / per-bot rate limit**: threshold from `resolveGroupOverrides(group_overrides, group,
    threshold_per_minute, block_seconds)`; if bot policy is `rate_limit`, threshold=`rpm` and the
    limiter group becomes `group:bot:<slug>`. `rateLimiter->registerAndCheck(ip, group, threshold,
    window_seconds)`; breach → block + **429** + `alerts->notifyFlood('rate_limit', …)`.
21. Otherwise **pass**: optionally log an `allowed` event (per-bot log flag, or sampled
    `log_unknown_allowed`), run the kernel, and record bot/site stats from the response status.

## Client-IP resolution (`resolveClientIp`)

Starts from `Request::getClientIp()`. If the request carries `cf-connecting-ip` **or** `cf-ray`, it
walks a header list (`cf-connecting-ip, true-client-ip, x-real-ip, x-forwarded-for, x-client-ip,
x-forwarded, forwarded`) and returns the first **public** IP found. Otherwise, when
`getClientIp()` is private/reserved it falls back to that same header list. This resolved IP is the
**sole key** for every allow/deny/rate-limit/block/log decision above. As with any IP-based control,
deploy behind correctly configured Symfony trusted proxies (`$settings['reverse_proxy']` /
`trusted_proxies`) so `getClientIp()` is authoritative. (A helper
`botshield_resolve_client_ip()` in `botshield.module` mirrors this logic, and `Service\IpResolver`
is a thinner `getClientIp()` wrapper.)

## The 429 response (`tooMany`)

Headers: `Retry-After`, `X-BotShield-Reason`, no-store cache headers. `Accept: application/json`
callers get a JSON body `{message, reason, retry_after}`. Otherwise, when `error_429_enabled`, a
small HTML page from `error_429_title`/`error_429_body` (limited-HTML, run through
`Xss::filter` with an allowed-tag list; `[Company]`/`%site_name%` and `%retry_after%`/`%reason%`
placeholders substituted; optional JS countdown and a `mailto:` contact button). Falls back to plain
text. Block duration and Flood counters are cleared on block so the client is re-evaluated cleanly
after expiry.
