# Search API Solr — manual setup guide

**Search API Solr** (`search_api_solr`) connects Drupal's **Search API** to an
Apache Solr server, giving you a high-performance backend for full-text, faceted,
and multilingual search over any content you index. It's the de-facto standard for
serious search on Drupal — suitable even for large, commercial sites — and handles
multilingual content correctly by design.

Technically, the module registers a Search API **backend plugin** that talks to
Solr through the Solarium PHP library. Connectivity is handled by pluggable
**Solr connector** plugins (Standard, Basic Auth, Solr Cloud, Basic-Auth Cloud), so
you can target a self-hosted Solr server, a SolrCloud cluster, or a hosted Solr
provider. It ships language-specific Solr field types and configuration that are
compiled into a downloadable **Solr config set** (`schema.xml`, `solrconfig.xml`,
and friends) that you install on your Solr server. On top of the basics it supports
faceting, spatial/location search, autocomplete, spellcheck, "more like this",
highlighting and snippets, and streaming expressions.

This module is **not configured through a settings page of its own**. Instead you
set it up through the standard Search API server and index forms: you create a
Search API *server* that uses the "Solr" backend, choose a connector, generate and
deploy the Solr config set, then add indexes as usual. It requires the **Search
API** module and core's **Language** module, plus several PHP libraries (Solarium
and others) that Composer installs. **Read the module's `README.md` before you
start** — Solr setup has moving parts on both the Drupal and the Solr side.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and choose the submodules you need.

There is **no dedicated configuration page** for this module — setup happens on the
Search API server and index forms, summarized in "How to use it" below.

## Where it lives in the admin menu

Everything is under **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`). You create a server there; the Solr-specific
settings and extra tabs live under each server at
`/admin/config/search/search-api/server/{id}/…`.

## How to use it

1. **Have a Solr server available.** You can run your own (there's a Solr plugin
   for DDEV for local development) or use a hosted Solr provider. Solr versions 7–9
   are directly supported; 3.6–6 need the `search_api_solr_legacy` submodule, and
   Solr 10 support is experimental.
2. **Create a Search API server** at *Search API → Add server*, choose the **Solr**
   backend, and pick a **connector** matching your setup (Standard, Basic Auth,
   Solr Cloud, or Basic-Auth Cloud). Enter the host, port, path, and any
   credentials.
3. **Generate and deploy the Solr config set.** From the server (or via the
   `search_api_solr_admin` submodule / Drush) download the config set zip and
   install it into your Solr core/collection so Solr understands the field types
   this module uses.
4. **Create an index** on that server, add the fields you want searchable, and run
   indexing (in the UI, on cron, or with Drush for parallel indexing).
5. **Build the search experience** with a Search API View, and optionally add the
   Facets, Search API Autocomplete, or spellcheck modules for richer features.

> **Security note:** When configuring a connector that uses Basic Auth or connects
> to a hosted provider, keep credentials out of version control — store them in an
> environment variable (via DDEV's dotenv) and reference them rather than committing
> them into configuration.
