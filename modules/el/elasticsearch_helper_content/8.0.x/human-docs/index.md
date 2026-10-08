# Elasticsearch Helper Content — manual setup guide

**Elasticsearch Helper Content** (`elasticsearch_helper_content`) lets site builders
define Elasticsearch indices for **any Drupal content entity type through the admin
UI** — choosing which fields get indexed and how each one is shaped — without
hand-writing an `ElasticsearchIndex` plugin. It turns the developer-oriented
[Elasticsearch Helper](https://www.drupal.org/project/elasticsearch_helper)
foundation into something a site builder can drive from a form.

It works by adding an **`elasticsearch_content_index` config entity** with add/edit/
delete forms. Each index you create is realised behind the scenes as a derived
`ContentIndex` plugin that Elasticsearch Helper understands. When you build an index
you pick the entity type and bundle, then choose fields and assign a **normalizer**
to each — a small plugin that decides how a field's value is written into
Elasticsearch. A large library of field normalizers ships with the module (text,
keyword, date, boolean, integer, float, email, entity-reference by id or label,
link uri/label, file/image path, rendered entity/field, address, and more), and you
can add your own normalizer plugins for bespoke field types.

It depends on both the base **Elasticsearch Helper** module and the
[Index Management](https://www.drupal.org/project/elasticsearch_helper_index_management)
module — the latter provides the list where you actually **set up** (create) each
index in Elasticsearch after defining it. All configuration is gated by the
**Administer site configuration** permission; there are no anonymous or web-service
endpoints, and the connection to Elasticsearch itself is handled by the base
Elasticsearch Helper module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Elasticsearch Helper and Index Management.
2. [Configuration](configuration/index.md) — create a content index, pick fields
   and normalizers, and set it up in Elasticsearch.

## Where it lives in the admin menu

Content indices are managed at **Configuration → Search and metadata →
Elasticsearch Helper → Index** (`/admin/config/search/elasticsearch_helper/index`),
where an **Add content index** action link appears. The underlying Elasticsearch
connection is configured on the base Elasticsearch Helper settings form.
