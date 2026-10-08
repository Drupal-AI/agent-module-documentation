# Bot Blocker — manual setup guide

**Bot Blocker** (`bot_blocker`) rejects HTTP requests from clients it recognises
as scraping bots or dangerously outdated browsers, based on the **User-Agent
header**, before Drupal does real page work. It exists to shed abusive crawling
and scraping traffic (and requests from obsolete browsers, which are often
automation or attack tooling), which is why it sits in the "Performance and
scalability" package.

It is a plain allow/deny gate — there is no CAPTCHA, no challenge, and no
rate-limiting. On every main request it checks the User-Agent: if the lowercased
string contains one of your banned substrings (defaults include `Scrapy`,
`HTTrack`, and `Go-http-client`) the request is blocked. Otherwise it reads the
major browser version from the User-Agent for Chrome, Firefox, Safari, Edge,
Opera, and Internet Explorer, and blocks the request if that version is at or
below the minimum you set for that browser family. Blocked requests get a
configurable HTML page returned as either **403 Forbidden** or **410 Gone**.

Bot Blocker matches on the browser and version a client reports in its
User-Agent header. It does **not** look at IP addresses, do reverse DNS, or
download any remote bad-bot list (it makes no outbound connections), so treat it
as one lightweight layer for shedding obvious junk traffic and combine it with
other measures such as rate limiting or a WAF. If your site sits behind a
reverse proxy or CDN, make sure Drupal sees the real client's User-Agent header,
and remember that blocking here happens in PHP, after the request reaches
Drupal. Also mind the version floors: set them too high and you will block
legitimate visitors on slightly old browsers.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form: banned
   substrings, minimum browser versions, response code, blocked-page HTML, and
   permissions.

## Where it lives in the admin menu

Its settings form is at **Configuration → System → Bot Blocker**
(`/admin/config/system/bot-blocker`). It also defines two permissions,
`administer bot blocker` and `bypass bot blocker`, set under **People →
Permissions**.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Open the settings form and tune the banned-substring list and minimum browser
   versions for your traffic.
3. Grant `bypass bot blocker` to any trusted automation (uptime or monitoring
   bots) that must never be blocked, and `administer bot blocker` to your admins.
4. Verify a block works, for example with `curl -A Scrapy https://your-site` —
   you should get a 403 or 410 back.
