<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Runtime mechanism: throttle, DB schema, crypt, hooks

## The event subscriber (`AttackProtection`)

`src/EventSubscriber/AttackProtection.php`, service `ddos_security.attack_protection`, tagged
`event_subscriber`. Subscribes to `KernelEvents::REQUEST` with method `ddosSecurity` at **priority 300**.
Constructor injects `request_stack`, `config.factory`, `logger.factory`, `database`, `current_user`,
`session_manager`, `path.current`, `date.formatter`, `language_manager`; it captures the client IP via
`$request_stack->getCurrentRequest()->getClientIp()`.

`ddosSecurity()` only acts when **`current_user` is anonymous** and `enable_ddos == 1`. Flow:

1. Computes the redirect target from `redirect_url` (language-prefixed for non-English via
   `URL::fromUserInput()`), and reads the current IP's latest status via
   `ddos_security_user_access_status()`.
2. If the request is already on the alert page and the IP is not `blocked`, redirects to the front page.
3. If `enable_malicious_requests == 1`: denies access when `HTTP_USER_AGENT` contains `bot`/`crawler`/
   `spider`, or when `detectDdosAttackUrl($_SERVER['REQUEST_URI'])` returns true.
4. **Rate counting**: builds a per-minute window (`$frm_time` = now-1min, `$t_time` = now, both as
   `ymdHis` strings). `ipHitCount()` counts this IP's `status='allowed'` rows inside that window.
   - If the count is **below** `total_hits`, and this minute has no newer `sno` for the IP, it inserts a
     new `allowed` row — **unless** the IP is in `whitelisted_ip_addresses` or the current path's basename
     is in `whitelisted_pages` (parsed by `explode("\r\n", trim(...))`).
   - If the count **reaches** `total_hits`, it updates every row for that IP to `status='blocked'` and
     redirects the visitor to the alert page.

`detectDdosAttackUrl($url)`: `parse_url`s the request, splits `malicious_requests_list` (config, comma-
separated; default has `<script`/`<?php`/`alert(`/URL-encoded forms) and returns true if any substring is
`strpos`-found in the URL; also returns true if any query parameter value exceeds 1024 chars.

`denyAccess()`: prints an HTML 403 page built around the configured `403_message` value and `die`s (this
short-circuits the kernel for filtered requests).

## Helper: `ddos_security_user_access_status()`

In `.module`. Selects the latest `status` for the current request's client IP from `ddos_security`
(ordered by `sno DESC`, range 0,1). Returns the status string (`allowed`/`blocked`) or `FALSE`. Used by
the subscriber and by `DdosSecurityPage` to decide which message to render.

## DB schema (`ddos_security.install`)

`hook_schema` defines table **`ddos_security`**: `sid` (serial, PK), `sno` (varchar 128, the `ymdHis`
per-minute serial), `ip_address` (varchar_ascii 128), `status` (varchar 64: `allowed`/`blocked`),
`created_date` (int unix ts). Indexes on `sno`, `ip_address`, `status`. `hook_uninstall` deletes the
`ddos_security.settings` config (the table is dropped by core on uninstall).

## Crypt service (`DdosCrypt`)

`src/Services/DdosCrypt.php`, service `ddos_security.crypt`. `encryptString()`/`decryptString()` wrap
`openssl_encrypt/openssl_decrypt` with **AES-256-CBC**. It is used only to obfuscate the
`action`/`ip`/`search_keyword` values embedded in the admin entry-list action URLs (block/unblock/delete
links and the search redirect) — it is a URL-value obfuscator, not an authentication or integrity
mechanism, and should not be relied on as one.

## Hooks & theming (`ddos_security.module`)

- `hook_theme` → `ddos_alert_message` (template `templates/ddos-alert-message.html.twig`, variable
  `html_data`). The template outputs the admin-configured message.
- `hook_cron` → daily (24h via state `ddos_security.next_execution`) mail-log run when `enable_mail_log`
  is on (see config/settings.md).
- `hook_mail` (`ddos_security` key) → builds the HTML report-link mail (from = `log_mail_id` or site mail).
- `hook_preprocess_page` → on the `redirect_url` alert page, unsets every `page` region except `content`
  so the blocked page renders bare.

## Operating notes

- Only **anonymous** traffic is throttled; authenticated users are never counted or blocked.
- Blocking is per source IP as seen by `Request::getClientIp()` — behind a reverse proxy, configure
  Drupal's trusted-proxy/`reverse_proxy` settings or every request appears to share the proxy IP.
- This runs inside PHP after bootstrap, so it mitigates only floods small enough to reach PHP; it is
  **not** a substitute for edge/WAF/CDN DDoS protection. The project is security-advisory **not-covered**.
