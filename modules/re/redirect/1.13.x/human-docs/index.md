# Redirect — manual setup guide

**Redirect** (`redirect`) manages **URL redirects** on your Drupal site. It stores
each redirect as a small record — an old path pointing at a new destination, served
with an HTTP status code (301 by default) — and forwards every matching request
*before* Drupal renders a page. Use it to send retired pages to their replacements,
consolidate duplicate URLs onto one canonical address, or forward short marketing
URLs to full campaign pages.

Redirect does more than store hand-entered rules. When a page's URL alias changes it
can **automatically create** a redirect from the old alias, so existing links and
search-engine ranking survive the change. Its **Redirect 404** submodule logs the
"page not found" requests your site receives and lets you turn frequent misses into
real redirects, and the route normalizer can enforce clean, canonical URLs (stripping
trailing slashes, redirecting `/node/123` to its alias, and so on).

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step and with screenshots, from installing the module to creating your first
redirect. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

![The Redirect list at Configuration → Search and metadata → URL redirects, with an Add redirect button and a filter](images/list.png)

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the site-wide options on the
   **Settings** page (auto-redirects, default status code, canonical URLs).
3. [Creating a redirect](creating-a-redirect/index.md) — add a redirect by hand from
   the admin UI.

## Where it lives in the admin menu

Everything in this guide sits under **Configuration → Search and metadata → URL
redirects**:

- Redirect list: `/admin/config/search/redirect`
- Add a redirect: `/admin/config/search/redirect/add`
- Global settings: `/admin/config/search/redirect/settings`

Managing redirects requires the **Administer URL redirects** permission; changing the
global settings requires the separate **Administer redirect settings** permission.
