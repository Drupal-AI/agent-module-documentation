# Elasticsearch Helper Index Management — manual setup guide

**Elasticsearch Helper Index Management** (`elasticsearch_helper_index_management`)
adds an **admin UI for managing the Elasticsearch index plugins** defined through
the [Elasticsearch Helper](https://www.drupal.org/project/elasticsearch_helper)
module. Instead of reaching for the Elasticsearch API or a command line, an
administrator can set up, reindex, and drop indices from a page in Drupal.

It depends on the base Elasticsearch Helper module, and it's the companion piece
several other Elasticsearch Helper modules rely on — for example
[Elasticsearch Helper Content](https://www.drupal.org/project/elasticsearch_helper_content)
uses this module's index list as the place where you actually create (set up) the
indices you've defined.

The operations it exposes are impactful: reindexing rebuilds an index and dropping
one deletes it. Because of that, access should be restricted to **trusted
administrators only**. The module has no content-access role of its own, and the
Elasticsearch connection and credentials live in the base Elasticsearch Helper
module — protect those separately.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Elasticsearch Helper.

This module provides an operations UI rather than a settings form, so there's no
separate configuration page — how to use the operations is covered in "How to use
it" below.

## Where it lives in the admin menu

Index plugins are managed at **Configuration → Search and metadata → Elasticsearch
Helper → Index** (`/admin/config/search/elasticsearch_helper/index`).

## How to use it

From the index list at `/admin/config/search/elasticsearch_helper/index`, each index
plugin offers several operations:

- **Setup** — create in Elasticsearch the indices managed by the plugin.
- **Reindex** — queue the plugin's content items for re-indexing (for example after
  a mapping change).
- **Drop** — delete the indices managed by the plugin.

Because reindexing and dropping are destructive or heavy operations, use them
deliberately and make sure only trusted administrators can reach this page.
