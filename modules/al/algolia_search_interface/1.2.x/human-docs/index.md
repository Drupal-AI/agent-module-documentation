# Algolia Search Interface — manual setup guide

**Algolia Search Interface** (`algolia_search_interface`) adds a fast,
"as-you-type" search box to your site, powered by
[Algolia](https://www.algolia.com/) — a hosted search service. Instead of results
appearing after you submit a form, the interface uses Algolia's **InstantSearch**
JavaScript to update results live while the visitor types.

The module provides the front-end search interface; Algolia itself stores the
search index and answers the queries. That means your searchable content is
indexed in Algolia, an external service, and connecting to it needs your Algolia
**Application ID** and an **API key**.

Because the search runs in the visitor's browser, the key you expose to the
front end must be the **search-only** key — never your admin or write key. Keep
the write key server-side only. And remember that Algolia's index is not governed
by Drupal's access system, so index only content that is safe to be publicly
searchable.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

This module provides the InstantSearch front-end interface rather than a large
admin settings screen. Its role is to render the search UI on the site.

## How to use it

1. Create an Algolia account and an index, and note your **Application ID** and
   your **search-only API key**.
2. Index the content you want searchable into Algolia. (Only include content that
   is safe to be public — Algolia's index is not filtered by Drupal permissions.)
3. Enable this module to render the InstantSearch interface backed by that index,
   supplying the Application ID and the **search-only** key to the front end.

Keep any admin/write API key strictly server-side — for example in an environment
variable — and never place it in front-end JavaScript.
