# Lunr — manual setup guide

**Lunr** (`lunr`) gives your Drupal site full‑text search that runs **entirely in
the visitor's browser**, powered by [Lunr.js](https://lunrjs.com). Instead of
querying a live Drupal backend or an external service like Solr, Lunr pre‑builds
a compact JSON search index and serves it to the browser, where a JavaScript web
worker loads it and answers searches locally. That makes it a natural fit for
**static Drupal sites** — for example sites exported with
[Tome](https://www.drupal.org/project/tome) — or any site that wants client‑side
search for performance reasons.

Lunr uses **Views** to define what gets indexed and to build the pages of search
results, which are delivered to the browser as needed. The search page it
provides supports paging, browser history, and lazy‑loading of results. It offers
no‑configuration multilingual support for all installed languages, configurable
field boosting, and optional facet/field searches driven either through the form
or via URL query parameters.

> **Important security caveat — the index is public and client‑side.** Because
> the whole search index is generated and served to the browser, everything in it
> is readable by anyone who loads the page, and there is **no server‑side access
> check at search time**. Only index content you are happy to make public:
> exclude unpublished or access‑restricted content, and do not index fields that
> should not be exposed. Treat the Lunr index as public data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (its dependencies, Serialization and Views, are in core).
2. [Configuration](configuration/index.md) — build a Lunr search entity, index
   it, and reach the search page.

## Where it lives in the admin menu

Lunr's search entities are managed under **Configuration → Search and metadata**,
at paths beginning `/admin/config/lunr_search`. If the Node module was enabled
before Lunr, a default search entity is created for you and can be indexed at
`/admin/config/lunr_search/default/index`, with the search page served at
`/search`.

## How to use it

1. Install and enable Lunr (see [Installation](installation/index.md)).
2. Either use the default search entity (created automatically if Node was
   already enabled) or create a new Lunr search page. Configure which content and
   fields it indexes — remembering the public‑index caveat above.
3. Click **Index** to build the JSON index, then visit the search page.
4. When deploying a **static** site, include the generated
   `public://lunr_search` directory in your deployment so the index ships with
   the site. If you use **Tome**, those files are included automatically.
