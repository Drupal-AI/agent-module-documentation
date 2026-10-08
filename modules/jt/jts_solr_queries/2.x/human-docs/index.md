# JTS Solr Queries — manual setup guide

**JTS Solr Queries** (`jts_solr_queries`) extends Search API's Solr integration so
your site can run **geospatial searches using polygon geometries**, not just the
usual point-plus-radius distance queries. That lets you answer questions like "is
this location inside any of these indexed regions?" — for example finding which
delivery zone, catchment area, or service region contains a user-supplied point.

It is a developer-oriented module that plugs into the Solr indexing and query
pipeline; there is no admin settings form. Concretely, it does three things:

- **Allows shapes in the Solr index** — it overrides Search API Solr's `rpt`
  (spatial) data type so the index is not restricted to a `lat,lon` pair, letting
  you index polygon shapes as well as points. It does this by subscribing to the
  data-types event Search API dispatches and swapping in its own, less restrictive
  RPT class.
- **Adds a Views filter** — it provides a Views filter plugin that tests whether a
  user-input point is **contained by** the indexed polygons (with room for more
  spatial predicates in future).
- **Adds the required schema configuration** — it contributes the spatial-query
  configuration to the `schema.xml` that Search API Solr generates, so the Solr
  core is set up to support these queries.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside its Search API dependencies.

This module has **no configuration page** of its own — it works through Search API
Solr's indexing/schema and a Views filter, described under "How to use it" below.

> **Note:** this module is based on a Search API Location feature request to allow
> indexing polygons, so its behaviour may change if that patch is accepted
> upstream. It is a `2.x-dev` release.

## How to use it

1. Have a working **Search API Solr** setup with **Search API Location** and
   **Geofield**, and enable this module (see
   [Installation](installation/index.md)).
2. Because the module changes the Solr `schema.xml` and the RPT data type,
   **regenerate and redeploy your Solr configuration** so the Solr core is set up
   for shape indexing, then reindex your content. Follow Search API Solr's normal
   config-generation workflow.
3. Index a Geofield containing polygon geometries on the relevant entity.
4. In a **View** against that Solr index, add the filter this module provides to
   test whether a user-supplied point is contained by the indexed polygons.

Developers can also alter a Search API query through
`hook_search_api_solr_converted_query_alter()` to customise the generated Solr
query.
