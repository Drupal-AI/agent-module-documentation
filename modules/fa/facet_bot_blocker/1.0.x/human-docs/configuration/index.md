# Configuration

The settings form is at **Configuration → System → Facet Bot Blocker**
(`/admin/config/system/facet-bot-blocker`), gated by the **Administer facet bot
blocker** permission. Values are stored in the `facet_bot_blocker.settings` config
object. Note that **no configuration ships by default** — until you save the form,
the blocker uses a sensible fallback limit of 1.

## Settings

- **Facet limit** (`facets_bot_blocker_limit`, minimum 1, default 1) — how deep a
  visitor may drill before being blocked. The check is on the raw `f[]` query array,
  which matches the standard Facets URL format:
  - **Limit 1** blocks a request that has `f[1]` set — i.e. the **second** active
    facet onward (only one facet allowed).
  - **Limit 2** blocks `f[2]` — allowing two facets but blocking the third.
  - …and so on. Choose the shallowest depth that still lets real users filter
    usefully.
- **Return 410 Gone** (`facet_bot_blocker_return_gone`, default off) — when on,
  blocked requests receive **HTTP 410 Gone**; when off, they receive **HTTP 403
  Forbidden** (the default). Prefer **410** if your goal is to get search engines to
  drop those deep-facet URLs from their index; **403** is a plain "not allowed".
- **Block message HTML** (`facet_bot_blocker_html`) — the HTML body returned to
  blocked clients. The default is
  `<h1>Excessive crawling detected</h1><p>We have blocked your request.</p>`. You can
  brand it or add guidance; a `@path` placeholder is available in the message.

Save the form to apply your settings. You can also set them via Drush:

```bash
drush cset facet_bot_blocker.settings facets_bot_blocker_limit 2 -y
drush cset facet_bot_blocker.settings facet_bot_blocker_return_gone 1 -y
drush cset facet_bot_blocker.settings facet_bot_blocker_html '<h1>Blocked</h1>' -y
```

## How the block decision works

An early request listener runs on every main request. It skips sub-requests and any
user with **Bypass facet bot blocker**, reads the configured limit, and if the
request has `f[<limit>]` set it returns the configured 403/410 response with your
message and stops further processing — so the expensive faceted page is never built.
Requests that carry `f` but stay under the limit are allowed (and, on Memcache/Redis
sites, bump an "allowed" counter).

## Permissions

Grant these at **People → Permissions** (`/admin/people/permissions`):

- **Administer facet bot blocker** — access the settings form (a restricted
  permission; trusted admins only).
- **Access facet bot blocker dashboard** — view the read-only metrics report.
- **Bypass facet bot blocker** — exempts the user from blocking entirely, regardless
  of facet depth. Give it to authenticated/staff roles that legitimately browse deep
  facets, or to keep logged-in editors unaffected. No permission is granted by
  default, and blocking itself needs none — it applies to every non-bypassing
  visitor, including anonymous crawlers, which is the whole point.

## The metrics dashboard

At **Reports → Facet Bot Blocker** (`/admin/reports/facet-bot-blocker`, gated by
*Access facet bot blocker dashboard*) you can see the current limit, blocked/allowed
totals, the percentage blocked, how long metrics have been running, and the last
blocked IP, path, and User-Agent — handy for tuning the limit.

> **Counters need Memcache or Redis.** These metrics are stored in the default cache
> and are only written when the **Memcache** or **Redis** module is enabled. On a
> plain database-cache site the dashboard still shows the current limit, but the
> counters stay at zero.
