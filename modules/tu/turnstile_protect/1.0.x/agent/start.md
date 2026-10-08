<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Turnstile Protect (turnstile_protect) — agent index

Puts chosen **routes** behind a **Cloudflare Turnstile** challenge for anonymous visitors, with an
optional per-IP-range rate limit and a verified-crawler allow-list. Requires `captcha` and
`turnstile`. Challenge form at `/challenge`; settings at
`/admin/config/people/captcha/turnstile-protect` (`administer turnstile` permission). Version
**1.0.5**, core `^10 || ^11`, license GPL-2.0-or-later. No permissions or Drush commands of its own.

## The problem is load, not spam
A CAPTCHA on a *form* does not help when the cost is in the **GET** — a search page, a faceted
listing or an expensive view hit thousands of times a day is a performance incident that looks like
traffic. Turnstile suits this because it is usually **invisible**, verifying in the background.

## How it works (`src/EventSubscriber/Challenge.php`)
`KernelEvents::REQUEST` subscriber, `protect()`. `applies()` decides whether to challenge:
1. Skip if session flag `turnstile_protect_pass` is set (visitor already solved a challenge).
2. Skip if the request `_route` name is not in config `routes` (route-name match — aliases, case,
   trailing slash already normalised by the router).
3. Skip authenticated users; skip IPs allow-listed via `captcha_whitelist_ip_whitelisted()`.
4. **Forward-confirmed reverse DNS good-bot check** (done properly, deserves credit): `gethostbyaddr()`
   on the client IP, `gethostbyname()` back, require a match; take the parent domain (last two
   labels); if it is in config `bots`, let through — unless `protect_parameters` is on and the URL
   has query params, then return **403**. A `User-Agent` claim is never trusted.
5. If `rate_limit` is on, challenge only when the client's IP range (`/16` IPv4, `/64` IPv6, core
   `flood` table, `threshold`/`window`) exceeds the threshold; otherwise challenge every unmatched
   anonymous request.

`protect()` increments a per-session `turnstile_protect_submission_count`; over `max_challenges`
(default 5) it returns **429** (logs every 10th failure). Otherwise redirects to
`/challenge?destination=<original-uri>`.

## The challenge (`src/Form/Challenge.php`, `js/challenge.js`)
Form renders a single `#type => captcha`, `turnstile/Turnstile` widget (skipped if
`captcha.enable_globally`). **Verification is delegated entirely to the `turnstile`/`captcha`
modules — this module never calls Cloudflare `siteverify` itself, and holds no secret key.** A JS
callback (`turnstileProtectAutoSubmit`) auto-submits 1s after the widget succeeds. Submit sets the
session pass flag and redirects to `destination` via `Url::fromUserInput()`.

## Config keys (`turnstile_protect.settings`)
`routes[]`, `bots[]`, `protect_parameters` (bool), `rate_limit` (bool), `threshold` (int),
`window` (int, seconds), `max_challenges` (int), `history_enabled` (bool). Defaults ship a good-bot
list (google/bing/duckduckgo/etc.), `window` 86400, `threshold` 5, `max_challenges` 5. See
[config/settings.md](config/settings.md).

## Optional history (`turnstile_protect.install`, `hook_cron`)
When `history_enabled`, cron snapshots flood counts per IP range into the
`turnstile_protect_history` table (`timestamp`, `ip_range`, `requests`).

## Two operational gotchas
1. **Client IP must be right.** Behind a CDN, `getClientIp()` returns the **proxy** unless
   `reverse_proxy` is set in `settings.php` — otherwise you challenge everyone or rate-limit the
   whole site as one visitor.
2. **Two blocking DNS lookups per unmatched request**, on exactly the routes under load. Measure and
   cache.
