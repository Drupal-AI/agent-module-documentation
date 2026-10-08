<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — Turnstile Protect

Settings form: `src/Form/Settings.php` at `/admin/config/people/captcha/turnstile-protect`
(a task tab under the CAPTCHA settings; permission `administer turnstile`, provided by the
`turnstile` module). Config object: `turnstile_protect.settings`
(`config/install/turnstile_protect.settings.yml`, schema in `config/schema/`).

## Prerequisite
Configure the `turnstile` module first (Cloudflare **site key** + **secret key** at
`/admin/config/people/captcha/turnstile`). This module reuses that Turnstile CAPTCHA type; it stores
no keys itself.

## Keys

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `routes` | sequence of route names | `[]` | Route(s) to protect. The form lists **all registered routes** by machine name + path; multi-select (chosen.js widget). Matching is on the `_route` attribute, not the path. Required. |
| `bots` | sequence of strings | google/bing/duckduckgo/msn/archive.org/linkedin/facebook/instagram/twitter/x/apple/openalex/kagibot/googleusercontent (see install yml) | Parent domains of crawlers to let through. A client is allowed only if forward-confirmed reverse DNS of its IP yields one of these parent domains — a UA string is never trusted. One domain per line, parent domain only. |
| `protect_parameters` | boolean | `false` | If on, an allow-listed good bot hitting a protected route **with query parameters** gets a 403 (stops facet crawling) while clean URLs still pass. |
| `rate_limit` | boolean | `false` | If on, challenge only IP ranges seeing excess traffic; if off, every unmatched anonymous request on a protected route is challenged. |
| `threshold` | integer | `5` | Requests allowed per `window` per IP range before challenging. |
| `window` | integer (seconds) | `86400` | Rate-limit / flood window length. |
| `max_challenges` | integer | `5` | Max challenges a session may receive before the module returns 429 to further requests. Min 1. |
| `history_enabled` | boolean | `false` | If on, `hook_cron` snapshots flood counts per IP range into the `turnstile_protect_history` table for offline analysis. |

## Who is never challenged
Authenticated users; IPs in the CAPTCHA module's IP allow-list
(`/admin/config/people/captcha`, `captcha_whitelist_ip_whitelisted()`); sessions that already hold
`turnstile_protect_pass`; and forward-confirmed allow-listed bots (unless `protect_parameters`
tripped).

## Deployment note
Rate limiting and bot detection key off the client IP. Behind a reverse proxy or CDN, configure
`$settings['reverse_proxy']` and `reverse_proxy_addresses` in `settings.php`, or `getClientIp()`
returns the proxy address and the logic misbehaves.
