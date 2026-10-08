# Configuration

A search endpoint is a config entity that points at a Search API index and defines how
it is queried and what it returns. You manage endpoints under **Configuration → Search
and metadata → Search API → Endpoints**
(`/admin/config/search/search-api/endpoints`), which requires the **Administer
search_api_endpoint** permission.

## Before you start

Build and enable a **Search API server and index** first (**Configuration → Search and
metadata → Search API**), and add the fields you want to search on and return. The
endpoint just exposes an existing index.

## Create an endpoint

Click **Add endpoint** and set:

- **Label / machine name / description** — the machine name becomes part of the URL
  (`/api/search/<id>`) and of the endpoint's permission, so choose it carefully.
- **Index** — the Search API index this endpoint queries.
- **Default results per page** *(default 10)* and **allowed items-per-page options** —
  the page size, and the list of `limit` values a client is allowed to request (a
  `?limit=` value is honoured only if it is in this list).
- **Searched fields** — which index fields the full-text keyword query (`?q=`) runs
  against.
- **Excluded fields** — index fields to strip from each returned result.
- **Parse mode** — the Search API parse mode for keywords (for example `direct`,
  `terms`, `phrase`).
- **Default sort** and **default sort order**, and **Expose sort** — whether clients
  may override sorting with `?sort=`/`?order=`.
- **Skip field extraction** — when on, the endpoint does not load the source entity
  and returns only the raw indexed values (faster, but no derived data).
- **Ensure result item URL** — build a canonical `url` for entity results that lack
  one.
- **Filters** — preset conditions applied to every query, or exposed filters the
  client can drive (see below).

## Filters

On an endpoint's **Filters** tab you can add filter plugins. A **preset** (non-exposed)
filter always constrains results. An **exposed** filter adds an accepted query-string
parameter, validates and transforms the client's input, and can limit which operators
the client may use (handy for things like accepting `now` or `-1 day` for a date).
Developers can add custom filter behaviour with a `search_api_decoupled_filter` plugin
— see the sibling `agent/` docs.

## Grant access (permissions)

Each endpoint has its own permission. Under **People → Permissions**:

- **Use search with *(label)* endpoint** — grant this to the roles allowed to query
  that specific endpoint. To make an endpoint **public**, grant it to the **anonymous**
  role — there is no default-open endpoint; opening one is always an explicit choice.
- **Administer search_api_endpoint** — lets a user create/edit/delete endpoints and
  also acts as a master key to query any endpoint. Treat it as an admin permission.

Note that access is also gated on the endpoint's index being **enabled**.

> **Security — read before going public.** The endpoint returns indexed field values
> directly and does **not** apply per-entity view access (especially with *skip field
> extraction* on). Before granting an endpoint permission to anonymous, harden the
> underlying **index**: index only published content, add the **Content access**
> processor, and use **excluded fields** to keep internal/sensitive fields out of the
> JSON.

## Query the endpoint

Make a `GET` request to `/api/search/{endpoint-id}` with query parameters:

- `q` — full-text keywords.
- `page` (0-based) or `offset` — pagination; `offset` takes precedence.
- `limit` — page size (honoured only if in the allowed list).
- `sort` / `order` — sort field and `asc`/`desc`, when sorting is exposed.
- `<field>=value` — any indexed field becomes a filter condition; add
  `operator[<field>]=` with values like `equal`, `gt`, `lt`, `in`, or `between` for
  richer comparisons.

The response is JSON with a `search_results` array (each item's field values plus
`id`, `score`, `excerpt`, and optional `url`), pagination counts (`search_results_count`,
`search_results_page`, `search_results_pages`, `search_results_per_page`), `max_score`,
`took`, and `facets`. Full parameter and response details are in the sibling
[`agent/`](../agent/start.md) docs.
