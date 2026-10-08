# Token Url Plus — manual setup guide

**Token Url Plus** (`token_url_plus`) adds a few new `current-page` URL tokens that
*include the query string* — something core's built‑in `[current-page:url]` token
deliberately drops. That gap matters most for **canonical URLs**: on paged,
filtered, or faceted pages you often need the canonical tag to keep meaningful
parameters like `?page=2` while stripping tracking noise like `utm_source`.

The module gives you `[current-page:url-with-query]` (the current absolute URL,
query string and all) plus two filtered variants you can chain onto it: one that
**removes** a named list of parameters, and one that **keeps only** a named list.
So you can, for example, drop all your UTM parameters from a canonical URL, or
whitelist just the `page` and `category_id` parameters that actually make a page
distinct.

There's nothing to configure — the tokens simply become available anywhere Drupal
tokens work (the Metatag canonical / `og:url` fields being the main use case). The
module builds the URLs correctly from the live request and adds the right cache
metadata so cached output stays accurate per URL. It depends on the contributed
**Token** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

The module has no admin page and no settings. Its tokens appear in the standard
token browser (the "Browse available tokens" link next to token‑aware fields),
under the **Current page** group.

## How to use it

Use the tokens anywhere token replacement runs — most commonly a Metatag
**canonical URL** field. The available tokens are:

| Token | What it returns |
|---|---|
| `[current-page:url-with-query]` | The current page's absolute URL **including** its query string. |
| `[current-page:url-with-query:without-some-parameters:a,b,c]` | The current URL with the listed query parameters **removed** (everything else kept). |
| `[current-page:url-with-query:with-some-parameters:a,b]` | The current URL keeping **only** the listed parameters. |

Examples:

```
[current-page:url-with-query]
  → https://example.com/products?page=2&utm_source=news

[current-page:url-with-query:without-some-parameters:utm_campaign,utm_medium,utm_source]
  → https://example.com/products?page=2

[current-page:url-with-query:with-some-parameters:page,category_id]
  → https://example.com/products?page=2
```

A typical setup: in the Metatag defaults (or a per‑bundle Metatag config), set the
**Canonical URL** to
`[current-page:url-with-query:without-some-parameters:utm_source,utm_medium,utm_campaign]`
so paginated pages stay self‑referential while tracking parameters are stripped.
