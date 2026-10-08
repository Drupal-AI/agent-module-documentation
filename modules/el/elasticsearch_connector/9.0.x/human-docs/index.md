# Elasticsearch Connector — manual setup guide

**Elasticsearch Connector** (`elasticsearch_connector`) adds an **Elasticsearch
backend** to the Search API module, so your Drupal site can index and search its
content on a real Elasticsearch (8 or 9) cluster instead of the built-in Database
Search or a Solr server. It is aimed at sites that have outgrown database search and
want the speed, scale, and relevance features of a dedicated search engine.

It is a backend, not a search interface of its own: you still build your indexes,
fields, and result pages through the normal **Search API** UI. What this module adds
is the "ElasticSearch" backend option for a Search API *server*, plus a family of
**connector** plugins that handle *how* Drupal talks to your cluster — a plain URL,
HTTP Basic Auth, or Elastic Cloud (by Cloud ID or by endpoint, using an API key).
The server's advanced settings add query fuzziness, an index name prefix/suffix (so
several environments can share one cluster), and synonyms. Two optional Search API
processors ship alongside it — one for boosting results by content type, one for
Elasticsearch-generated excerpts.

The one hard prerequisite: you must have a reachable Elasticsearch 8/9 cluster and
the required PHP libraries — this module bundles **no** search engine of its own. It
works on Drupal 10.5+ and 11 with PHP 8.1.34+.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its libraries
   with Composer, and note the external cluster requirement.
2. [Configuration](configuration/index.md) — create a Search API server on the
   Elasticsearch backend, choose a connector, and set the advanced options.

## Where it lives in the admin menu

Elasticsearch Connector has **no configuration page of its own** — you configure it
entirely through Search API's server screens at **Configuration → Search and
metadata → Search API** (`/admin/config/search/search-api`). It adds the
**ElasticSearch** backend choice (and its connectors) to the add/edit-server form
there. It defines no permissions of its own and ships no Drush commands.
