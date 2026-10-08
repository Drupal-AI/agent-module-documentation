# Search API Solr — manual setup guide

**Search API Solr** (`search_api_solr`) connects Drupal's Search API to an **Apache
Solr** server, giving you a high‑performance backend for full‑text, faceted, and
multilingual search over any content you index. It registers a Solr **backend** for
Search API, so you create a Search API server that talks to Solr through the Solarium
PHP library, then add indexes exactly as you would with any other Search API backend.

Connectivity is handled by pluggable **Solr connectors** — Standard, Basic Auth,
Solr Cloud, and Basic‑Auth Cloud — so you can point at a self‑hosted Solr node, a
SolrCloud cluster, or a hosted provider. The module ships language‑specific Solr field
types and configuration entities that it compiles into a downloadable Solr **config
set** (`schema.xml`, `solrconfig.xml`, and friends) that you install on your Solr
server. On top of that it supports faceting, spatial/location search, autocomplete,
spellcheck, "more like this", highlighting and snippets, streaming expressions, and
Solr's block‑join and multisite features. Multilingual sites get per‑language
analyzers and stemming out of the box.

This is a substantial module with real infrastructure requirements: it depends on the
**Search API** module and core's **Language** module, brings in several Composer
libraries (Solarium and others — installed automatically), and needs a running Apache
Solr server to connect to. There is no single "Search API Solr settings" page;
instead you configure everything on the Search API server and index forms, plus extra
Solr‑specific tabs on each server. Several optional submodules and a set of Drush
commands round it out.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its libraries with
   Composer, enable it, and choose submodules; plus the Solr server you'll connect to.
2. [Configuration](configuration/index.md) — create a Search API server with the Solr
   backend, pick a connector, generate and install the Solr config set, and manage the
   Solr config entities.

## Where it lives in the admin menu

Everything lives under **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`). You add a Solr‑backed **server** there, and each
Solr server gains extra tabs at
`/admin/config/search/search-api/server/{server}/…` for its Solr config entities and
downloadable config‑set files. All the Solr configuration screens are gated by the
**Administer Search API** permission (`administer search_api`). See
[Configuration](configuration/index.md) for the walk‑through.
