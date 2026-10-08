# Elasticsearch Search API — manual setup guide

**Elasticsearch Search API** (`elasticsearch_search_api`) is a
[Search API](https://www.drupal.org/project/search_api) **backend** that indexes
content into Elasticsearch and serves search pages from it — an alternative to the
Solr backend for sites that want to run their search on an Elasticsearch cluster.
It provides a framework for building custom Elasticsearch-based search pages, with
features like Ajax-powered faceted search, pagination, autocomplete/search
suggestions, and "did you mean" spelling suggestions.

It slots into the standard Search API workflow: Search API manages your indexed
data, and this module (together with
[Elasticsearch Connector](https://www.drupal.org/project/elasticsearch_connector),
which handles the connection to your cluster) is what makes Elasticsearch the engine
behind it. Both Search API and Elasticsearch Connector are required dependencies,
and you need an Elasticsearch cluster to point at.

Two optional submodules ship with it: **Elasticsearch Search API Example**
(`elasticsearch_search_api_example`), a worked example of a custom search page you
can learn from or adapt, and **ESA Pager** (`esa_pager`), which adds pagination for
flipping through search results. There's also a small installation wrinkle — the
module needs a JavaScript library (blockui) that isn't a normal Composer package, so
you add a one-time repository entry to your project's `composer.json`; see
[Installation](installation/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — add the blockui library repository,
   install with Composer, and enable the module and any submodules.
2. [Configuration](configuration/index.md) — set up an Elasticsearch server in
   Search API and index your content.

## Where it lives in the admin menu

Configuration happens through **Search API** at **Configuration → Search and
metadata → Search API** (`/admin/config/search/search-api`), where you create the
server (choosing the Elasticsearch backend) and the index. The Elasticsearch
connection itself is configured through Elasticsearch Connector.
