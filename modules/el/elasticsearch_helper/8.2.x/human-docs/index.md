# Elasticsearch Helper — manual setup guide

**Elasticsearch Helper** (`elasticsearch_helper`) is the connection, index
management, and document-building layer for talking to **Elasticsearch directly**,
without going through Search API. Where modules like Elasticsearch Connector and
Search API try to abstract Elasticsearch away behind a generic "search backend"
concept, Elasticsearch Helper does the opposite: it embraces Elasticsearch's own
API and gives you index definitions, document builders, and a client to build your
own integration on.

It's a developer-oriented foundation. The module defines an **`ElasticsearchIndex`
plugin type** with a base implementation for you to extend — and, importantly,
**until you define your own index plugin (or add one of the companion modules), it
does nothing on its own**. The bundled `elasticsearch_helper_example` module shows
example plugins. Its one dependency is core's Serialization module.

Choose this approach when Elasticsearch's own capabilities are the actual
requirement — a document shape that isn't a Drupal entity, aggregations driving a
dashboard, an index consumed by another application, or a mapping needing specific
Elasticsearch features. The trade-off is the Search API ecosystem: no facets
module, no processors, and no swapping backends later without a rewrite. If you just
want site search with the option to change backends, Search API is the better fit.

Three operational points belong in any direct Elasticsearch integration: the
connection credential has **index-write access** (keep it out of exported config);
the cluster is a **network dependency**, so decide what happens when it's
unreachable, because an unhandled indexing failure during a content save is a failed
content save; and **indexed documents leave Drupal's access model behind** —
anything reading the index directly sees everything in it, which is fine for a
public site search but is the thing to think hardest about when the index holds
anything restricted. Companion modules build on this base:
[Index Management](https://www.drupal.org/project/elasticsearch_helper_index_management)
(a UI to set up/reindex/drop indices),
[Content](https://www.drupal.org/project/elasticsearch_helper_content) (define
indices for content entities in the UI),
[Views](https://www.drupal.org/project/elasticsearch_helper_views), and
[Preview](https://www.drupal.org/project/elasticsearch_helper_preview).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, mind the
   Elasticsearch PHP library version, and enable it.
2. [Configuration](configuration/index.md) — point the module at your Elasticsearch
   cluster and secure the connection.

## Where it lives in the admin menu

The connection settings form is at **Configuration → Search and metadata →
Elasticsearch Helper** (route
`elasticsearch_helper.elasticsearch_helper_settings_form`). Everything else —
defining indices — happens in code (your own `ElasticsearchIndex` plugins) or via
the companion modules listed above.
