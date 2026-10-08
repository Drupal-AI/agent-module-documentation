# Configuration

Bot Blocker is configured at **Configuration → System → Bot Blocker**
(`/admin/config/system/bot-blocker`). Everything the module does is driven by this
admin config — it never downloads a bot list or makes outbound requests.

## Open the settings form

Log in as a user with the **administer bot blocker** permission and go to
`/admin/config/system/bot-blocker`.

## Banned User-Agent substrings

This is the list of text fragments that, if found anywhere in a request's
(lowercased) User-Agent, cause the request to be blocked. Matching is
case-insensitive. The defaults are `Scrapy`, `HTTrack`, and `Go-http-client`.

Add substrings for the clients you want to reject, for example:

- `HTTrack` — site-mirroring tools.
- `Go-http-client` — default Go HTTP client traffic.
- `python-requests` or `curl` — scripted clients.
- any custom bad-bot User-Agent you have observed in your own logs.

If a substring causes false positives (blocking real visitors), remove it.

## Minimum browser versions

For each browser family — Chrome, Firefox, Safari, Edge, Opera, and Internet
Explorer — you can set a minimum major version. A request is blocked when its
detected version for that family is **at or below** the minimum. For example,
setting Internet Explorer's minimum high blocks all IE. Leave a family's field
**blank** to stop filtering that family entirely.

Two behaviours to keep in mind:

- Only the **first** matching browser-family pattern is evaluated, so a request is
  judged against one family, not several.
- **Raise the floors gradually as browsers age.** A floor set too high will block
  legitimate users still on a slightly older but perfectly capable browser.

## Response code and blocked-page HTML

Choose what a blocked client receives:

- **HTTP status** — keep the default **403 Forbidden**, or switch to **410 Gone**
  to signal permanent removal to crawlers.
- **Blocked-request HTML** — customise the page body shown to blocked clients.
  This HTML is admin-supplied and rendered as configured, so only trusted
  administrators should have the administer permission.

## Permissions

Under **People → Permissions** (`/admin/people/permissions`):

- **`administer bot blocker`** — grant to site administrators who manage this
  form.
- **`bypass bot blocker`** — grant to trusted roles or accounts that must never be
  blocked, such as uptime and monitoring bots, or an internal QA account used for
  old-browser testing. Anyone with this permission skips all filtering.

## A note on what this can and cannot do

Bot Blocker matches on the browser and version a client reports in its User-Agent
header, so treat it as one lightweight layer for shedding obvious junk traffic and
combine it with other measures such as rate limiting or a WAF. If your site is
behind a reverse proxy or CDN, confirm Drupal receives the real client's
User-Agent.

## Save and verify

Save the form, then test a block from the command line:

```bash
curl -A Scrapy https://your-site
```

You should receive your configured 403 or 410 response. If you enabled Memcache or
Redis, you can also watch the `bot_blocker.blocked_requests` counter and the
`bot_blocker.last_blocked_request` record grow; with the default database cache
those metrics are not recorded.
