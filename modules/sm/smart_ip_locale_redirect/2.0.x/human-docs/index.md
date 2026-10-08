# Smart IP Redirect to Locale (with Cookie) — manual setup guide

**Smart IP Redirect to Locale (with Cookie)** (`smart_ip_locale_redirect`)
overrides Drupal's language negotiation to actively redirect a visitor to the site
language that matches their IP-derived country — and then remembers that decision
in a cookie so it does not have to geolocate them again on every page. Where its
sibling module (`smart_ip_locale`) adds a detection *method* you slot into
negotiation, this module issues an actual **302 redirect** to the
language-prefixed URL.

Under the hood it runs a request subscriber very early in the request (before
routing). For each eligible request it looks up the country via Smart IP, resolves
the language you mapped to that country, rebuilds the destination path through the
alias manager, and redirects. The choice is stored in a `smart_ip_hl` cookie
(set HttpOnly), so subsequent requests skip the lookup and just honour the cookie.

It is deliberately careful about *which* requests it touches: only `GET`/`HEAD`
front-controller requests are redirected, and it automatically skips admin routes,
node edit forms, maintenance mode, files under `/sites/default/files/`, and any
user-agents you exclude (handy for crawlers and uptime monitors). The redirect
target is always your own site's scheme, host, and base path with the langcode and
path appended — it is never taken from a request parameter — so it cannot be
abused as an open redirect to an external domain. Page cache is disabled only while
a page is actually negotiating; once the visitor is on the correct prefix the
subscriber returns early.

One important behavioural note: because the `smart_ip_hl` cookie keeps redirecting
to the stored language, you cannot change the site language just by editing the
URL in your browser. To switch, either use the site's **language switcher** or add
`update_hl=LANGCODE` to the path, which rewrites the cookie.

It depends on **Smart IP**, **Redirect**, **Locale**, and **Path alias**, provides
its own permission, and runs on Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies, then enable it and grant the permission.
2. [Configuration](configuration/index.md) — set the country-to-language mapping,
   the cookie behaviour, and excluded user-agents.

## Where it lives in the admin menu

Its settings form sits at **Administration → Configuration → Search and metadata →
Smart IP Locale Redirect** (`/admin/config/search/smart_ip_locale_redirect`),
behind the **access smart IP locale redirect settings** permission. The underlying
Smart IP geolocation data source is configured separately at
`/admin/config/people/smart_ip`.
