# Search API OpenSearch — manual setup guide

**Search API OpenSearch** (`search_api_opensearch`) provides an **OpenSearch
backend** for the Search API module. It lets Drupal index your content into an
OpenSearch cluster and run full‑text search, faceted search, "More Like This"
related‑content queries, spellcheck, and autocomplete against it — using the
official OpenSearch PHP client. If you have outgrown the database backend and want
OpenSearch (or are migrating from Elasticsearch), this is the plugin that connects
the two.

You use it the standard Search API way: create a Search API **server**, choose the
**OpenSearch** backend, and configure a **connector** that knows how to reach your
cluster. Three connectors are available — **standard** (no authentication),
**basicauth** (HTTP basic auth), and **aws_signature** (for Amazon OpenSearch
Service, from a submodule). Then you create a Search API **index**, point it at the
server, add fields, and index your content.

On top of the basics, the module adds several search data types (ngram, edge_ngram,
search‑as‑you‑type, rank feature, date range, object, spellcheck) and analysers, and
exposes a rich set of events and a hook so developers can customize field mappings,
index/query parameters, and client options. It defines two plugin types —
**OpenSearch connectors** and **OpenSearch analysers** — so bespoke auth schemes or
tokenizers can be added.

Note that this module needs a **real, running OpenSearch cluster** plus a few PHP
libraries (the OpenSearch PHP client, php‑lucene, and Guzzle), which Composer
installs for you.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, the required
   libraries, and the optional submodules.
2. [Configuration](configuration/index.md) — create the server, choose a connector,
   set advanced options, and build an index.

## Where it lives in the admin menu

There is no dedicated settings page for the module itself. You configure everything
through Search API at **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`) — first the server (with the OpenSearch
backend), then the index.

## How to use it

Point a Search API server at your OpenSearch cluster via a connector, attach an
index to that server, add the fields you want searchable, and index your content.
The full walkthrough is in [Configuration](configuration/index.md).
