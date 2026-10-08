# Cookie bot protection — manual setup guide

**Cookie bot protection** (`cookie_bot_protection`) is an HTTP middleware that
protects the URLs you choose behind a **cookie round‑trip challenge**, filtering out
crawlers and scripts that do not store and return cookies. It is aimed at cheap
scraping and AI‑bot traffic that ignores `robots.txt` and hammers expensive pages
(search, listings). Rather than fully blocking such traffic, it returns a quick
redirect or `401` without computing the page — and, crucially, without serving it
from the page cache — so the load on your origin drops sharply.

Here is how a request flows: when a request matches one of your protected URL
patterns (and is not whitelisted by User‑Agent or IP), the middleware redirects it
with a challenge cookie named `SESScookiebotprotection` and a `?drupal_cbp_check=1`
marker. A real browser follows the redirect, returns the cookie, gets an authorized
cookie, and is sent back to the clean URL. A client that never returns the cookie
is denied with a `401` — optionally with a `Refresh` header so a legitimate user
who tripped the challenge can retry. The challenge value is an HMAC keyed to your
site's `hash_salt`, so tokens cannot be forged offline.

The module is **inert until you configure it**: with no protected URL patterns it
does nothing at all. Its settings live at **`/admin/config/cookie_bot_protection/settings`**
behind the core **Administer site configuration** permission.

Two things to keep in mind. First, this only stops **cookie‑less** bots — any
client (including a capable headless bot) that follows redirects and stores cookies
will pass, so treat it as a coarse first‑line filter, not a CAPTCHA or
human‑verification control. Second, a poorly written regex can accidentally protect
your whole site and hurt SEO, so scope your patterns carefully and test them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add protected URL patterns,
   whitelists, and tune the retry behavior.

## Where it lives in the admin menu

Once enabled, configure the module at
**`/admin/config/cookie_bot_protection/settings`** (Administer site configuration).
