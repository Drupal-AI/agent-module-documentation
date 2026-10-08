# Configuring Facet Bot Blocker

Config object: **`facet_bot_blocker.settings`** (no `config/install`, no schema — values are
null until the settings form is saved). Edit at `/admin/config/system/facet-bot-blocker`
(route `facet_bot_blocker.settings_form`, permission `administer facet bot blocker`).

## Settings keys

| Key | Type | Default (form) | Effect |
|---|---|---|---|
| `facets_bot_blocker_limit` | int (min 1) | 1 | Block when the request has `f[<limit>]` set. Limit 1 blocks `f[1]` (the 2nd facet); limit 2 blocks `f[2]`, etc. If empty the subscriber falls back to 1. |
| `facet_bot_blocker_return_gone` | bool | false | If true, blocked requests get HTTP **410 Gone**; otherwise HTTP **403 Forbidden**. |
| `facet_bot_blocker_html` | string (HTML) | `<h1>Excessive crawling detected</h1><p>We have blocked your request.</p>` | Body returned to blocked clients. Rendered via `FormattableMarkup` with a `@path` placeholder available. |

Set via Drush:
```
drush cset facet_bot_blocker.settings facets_bot_blocker_limit 2 -y
drush cset facet_bot_blocker.settings facet_bot_blocker_return_gone 1 -y
drush cset facet_bot_blocker.settings facet_bot_blocker_html '<h1>Blocked</h1>' -y
```

## How the block decision works

`FacetBotBlockerEventSubscriber::onKernelRequest()` (KernelEvents::REQUEST, priority **101**):
1. Skips sub-requests and any user with `bypass facet bot blocker`.
2. Reads the limit (from cache if Memcache/Redis is on, else config).
3. `if (isset($_GET['f'][$limit])) { block }` — sets a `Response` (403/410) with the message
   and calls `stopPropagation()`, so the faceted page is never built.
4. Non-blocked requests that still carry `f` only bump an "allowed" counter (cache backends only).

Note the check is on the raw `$_GET['f']` array index, so it matches the conventional Facets
`f[0]`, `f[1]`, … query format.

## Dashboard & counters

`/admin/reports/facet-bot-blocker` (route `facet_bot_blocker.dashboard`, permission
`access facet bot blocker dashboard`) shows current limit, blocked/allowed totals, percent
blocked, time since metrics started, and the last blocked IP/path/User-Agent. **These counters
are stored in `cache.default` and only written when the Memcache or Redis module is enabled**;
on a plain DB-cache site the dashboard shows the limit but zeroed counters.
