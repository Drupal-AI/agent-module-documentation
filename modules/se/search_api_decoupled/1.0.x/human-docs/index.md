# Search API Decoupled — manual setup guide

**Search API Decoupled** (`search_api_decoupled`) exposes a Search API index as a
plain JSON HTTP endpoint at `/api/search/{endpoint}`. That lets a headless or
JavaScript front-end (React, Vue, Next.js, and the like) query your search index
directly over HTTP — with keywords, pagination, sorting, filters, and facets — without
you having to build a Drupal View or load Drupal entities server-side.

You configure it by creating one or more **search endpoint** entities in the admin UI.
Each endpoint picks a Search API index and sets things like the default result limit,
the allowed page sizes, which fields are full-text searched, which fields to exclude
from the output, the default sort, and whether clients may change the sort. You can
attach preset filter conditions that constrain every query, or expose filters that the
client can drive from the query string. A read-only `GET` request returns scored,
paginated results as JSON.

Access is controlled per endpoint: each one gets its own permission, so you decide
which roles (including anonymous, for a public search) may query it. There is an
important security note that goes with that — the endpoint returns indexed field
values directly and does not apply per-entity view access, so you must configure the
underlying Search API index appropriately (index only published content, add the
"Content access" processor, exclude internal fields) before opening an endpoint to the
public.

The module ships several optional submodules: a front-end **UI** builder, **Facets**
integration, **Autocomplete** integration, and a **demo**. It requires the **Search
API** module (`^1.28`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (note the
   composer-merge requirement), enable the module, and pick submodules.
2. [Configuration](configuration/index.md) — create a search endpoint, set its
   fields and filters, grant its permission, and query it.

## Where it lives in the admin menu

Endpoints are managed under **Configuration → Search and metadata → Search API →
Endpoints** (`/admin/config/search/search-api/endpoints`), which requires the
**Administer search_api_endpoint** permission. Each endpoint is then queried at its own
URL, `/api/search/{endpoint-id}`.
