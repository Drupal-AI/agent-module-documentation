<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# JSON:API Search API — manual setup guide

**JSON:API Search API** (`jsonapi_search_api`) lets a decoupled or headless front-end
run [Search API](https://www.drupal.org/project/search_api) queries over JSON:API. It
exposes each **enabled** Search API index as a JSON:API resource at
`/jsonapi/index/{index_id}`, so a React, Next.js, or mobile client can send fulltext,
filter, sort, and pagination requests and get standard JSON:API documents back — no
custom controllers required.

The clever part is that there is nothing to configure. The module works entirely off
your existing Search API indexes: it registers one route per enabled index
automatically, and a newly enabled index gets its endpoint with no extra code. Each
request runs a real Search API query behind the scenes (so relevance, access, and your
chosen backend all still apply) and returns only the results as a JSON:API collection,
complete with `meta.count` and first/prev/next/last pager links for infinite scroll.

It maps familiar JSON:API query parameters onto Search API: `page[offset]` and
`page[limit]` for pagination, `sort` for sorting, `filter[...]` for conditions, and a
special `filter[fulltext]=...` to set the search keywords. An optional submodule,
**JSON:API Search API Facets** (`jsonapi_search_api_facets`), adds facet data to the
response `meta` for building faceted search UIs.

This is a developer-facing module — you use it by building an index in Search API and
then calling its JSON:API endpoint from your client. There is no admin settings form,
so this guide folds the "how to use it" details into this page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and (optionally) the facets submodule.

## Where it lives in the admin menu

The module adds no admin page of its own. You configure your **indexes** in Search API
(**Configuration → Search and metadata → Search API**); this module simply exposes each
enabled index as a JSON:API endpoint.

## How to use it

### Expose an index

There is nothing to switch on per index — every **enabled** Search API index is
exposed automatically. To make an index available at `/jsonapi/index/{index_id}`:

1. In Search API, make sure the index has a **server** and is **enabled**. (Search API
   forces an index with no server to be disabled, and disabled indexes are not
   exposed.)
2. Rebuild caches (`drush cr`) so the new route registers.

The endpoint then appears at `/jsonapi/index/<your-index-id>` (the `/jsonapi` prefix
is your site's JSON:API base path).

### Query it

Send JSON:API-style query parameters:

| Parameter | Effect |
|---|---|
| `filter[fulltext]=climate` | Fulltext keyword search. |
| `filter[status][value]=1` | A filter condition on an indexed field. |
| `sort=-created` | Sort results (prefix `-` for descending). |
| `page[offset]`, `page[limit]` | Pagination. |

For example:

```
GET /jsonapi/index/content?filter[fulltext]=climate&filter[status][value]=1&sort=-created&page[limit]=10
```

The response is a JSON:API collection of the matching entities, with `meta.count` and
pager links.

**Supported filter operators:** `=`, `<>`, `>`, `>=`, `<`, `<=`, `IN`, `NOT IN`,
`BETWEEN`, `NOT BETWEEN`, `IS NULL`, `IS NOT NULL`, plus grouped AND/OR conditions.
**Not supported:** `STARTS_WITH`, `CONTAINS`, `ENDS_WITH` — Search API cannot express
these, so use `filter[fulltext]` for partial-text matching instead.

### Facets

Enable the **JSON:API Search API Facets** submodule (and the Facets module) to have
facet data returned under `meta.facets` in the response, for building category and
filter UIs. Developers can also add their own keys to the response `meta` by
subscribing to the `jsonapi_search_api.add_search_meta` event — which is exactly how
the facets submodule works.
