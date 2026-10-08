# Elasticsearch Helper Views — manual setup guide

**Elasticsearch Helper Views** (`elasticsearch_helper_views`) bridges
[Elasticsearch Helper](https://www.drupal.org/project/elasticsearch_helper) and
Drupal's **Views** module, so a View can query an Elasticsearch index (using the
Elasticsearch Helper connection) and render the results with Views' familiar fields,
filters, and formatting. In short, it lets you build listings and search pages over
Elasticsearch data using the Views UI.

It depends on the base Elasticsearch Helper module and, like the rest of that
family, it's aimed at sites that talk to Elasticsearch directly rather than through
Search API. Building a working Elasticsearch View involves some developer work: you
create an **`ElasticsearchQueryBuilder` plugin** in a custom module that generates
the Elasticsearch Query DSL for the View, and, if you want exposed filters, custom
Views filter plugins registered for the `elasticsearch_result` data type. The Views
UI then ties those pieces together.

One thing to keep front of mind: querying an external Elasticsearch index means the
results **come from Elasticsearch, not from Drupal's entity access system**. A Views
listing over Elasticsearch can surface documents that Drupal's node/entity access
would normally hide, unless you index and filter for access yourself. Be deliberate
about what you index and expose. The module has no access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Elasticsearch Helper.

This module doesn't add a settings form of its own — you configure an Elasticsearch
View in the Views UI (with supporting plugins in code), described in "How to use it"
below.

## Where it lives in the admin menu

There's no dedicated settings page. You work entirely in the Views UI at
**Structure → Views** (`/admin/structure/views`), choosing **Elasticsearch result**
as the View's data type.

## How to use it

1. Make sure **Elasticsearch Helper** is installed and configured, and that you have
   created indices via `ElasticsearchIndex` plugins (in a custom module or via
   [Elasticsearch Helper Content](https://www.drupal.org/project/elasticsearch_helper_content)).
2. In a custom module, create an **`ElasticsearchQueryBuilder`** plugin that
   generates the Query DSL for your View.
3. If you want **exposed filters**, create custom Views filter plugins and register
   them via `hook_views_data_alter()` for the `elasticsearch_result` data type.
4. Create a new **View** and select **Elasticsearch result** as the data type.
5. In the View configuration, open the **Query settings** link and select the
   query-building plugin (your `ElasticsearchQueryBuilder`) that should generate the
   Query DSL for this View.
6. Add fields, filters, and formatting as usual, then save the View.

Remember to index and filter for access where the underlying documents shouldn't be
publicly visible — Views won't apply Drupal's entity access to Elasticsearch
results.
