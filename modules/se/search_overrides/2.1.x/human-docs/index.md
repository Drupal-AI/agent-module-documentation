# Search API Solr Overrides — manual setup guide

**Search API Solr Overrides** (`search_overrides`) lets editors manually tune
Solr search results: for a given search term you can **elevate** specific content
to the very top of the results, or **exclude** content so it does not appear at
all. It is the friendly, in-Drupal way to do what Solr calls query elevation —
without hand-editing Solr's `elevate.xml` or reindexing.

Each rule is a **search override** entity, keyed by the exact search string it
applies to. On the override you list the nodes to elevate and the nodes to
exclude. Behind the scenes, when a matching Solr query comes in, the module adds
Solr's native `elevateIds` and `excludeIds` parameters built from those nodes, so
Solr itself does the re-ranking. Overrides are stored in the database (not in
Solr config), which keeps your manual tuning portable across environments.

This is ideal for curating "best bets" — pinning an official announcement or a
campaign landing page above organic results for a high-value keyword, boosting
seasonal content during a sale, or hiding a deprecated page from a product-name
search without unpublishing it. Editors can preview the effect, and appending
`?ignore_overrides=1` to a search URL shows the un-overridden ranking so an admin
can compare. Because overrides are language-aware, elevate/exclude only affects
the current interface language's documents.

> **Requires Solr.** This module only works with a Search API **Solr** backend —
> it hooks a Solr-specific event and relies on Solr's elevate/exclude mechanism.
> It does nothing for the database backend.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Search API
   Solr dependency with Composer, and enable it.
2. [Configuration](configuration/index.md) — set the global options, create
   overrides, and preview results.

## Where it lives in the admin menu

- Overrides are managed at **Configuration → Search → Search overrides**
  (`/admin/config/search/search_override`).
- The global settings are one level down at
  `/admin/config/search/search_override/settings`.

## How to use it

1. Make sure you have a working Search API **Solr** index.
2. Set the [global options](configuration/index.md) (preview path, whether to
   match the whole search string, and where content is picked from).
3. Add an override: enter the search string, then pick the nodes to elevate
   and/or exclude.
4. Run that search and confirm the elevated content appears on top and excluded
   content is gone. Add `?ignore_overrides=1` to the URL to see the original
   ranking for comparison.
