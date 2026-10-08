# Search API OpenSearch Semantic — manual setup guide

**Search API OpenSearch Semantic** (`search_api_opensearch_semantic`) adds
vector-based *semantic* search on top of the existing Search API OpenSearch
integration. Ordinary search matches keywords; semantic search matches by
*meaning*, using vector embeddings, so a query can surface relevant content even
when it doesn't share the exact words. This module makes that possible by using
the **semantic field** introduced in OpenSearch 3.1.

It is an extension, not a standalone backend: it depends on both the **Search API**
module and the **Search API OpenSearch** module, and it plugs its vector search
capability into that existing OpenSearch setup. This is an experimental,
under-active-development module, and using it assumes you already know how to set
up OpenSearch to run ML models. Crucially, the model itself is expected to be
configured **outside** this module — you integrate the ML model in OpenSearch,
obtain its model ID, and then set that ID in this module's settings. It works on
Drupal 10.4+ and 11.

Two data-handling points are worth keeping in mind. Generating embeddings may
involve sending your content to an **embedding model or service**, so confirm that
egress is acceptable for the content you're indexing. And the content is indexed
into **OpenSearch**, so respect Search API's access handling — make sure semantic
results can't surface content a user shouldn't see. The module itself has no
access-control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Search API OpenSearch.
2. [Configuration](configuration/index.md) — set the OpenSearch ML model ID and
   enable semantic (vector) search on your index.

## How to use it

Once your OpenSearch cluster has an ML model integrated and you have its model ID,
enter that ID in this module's settings and enable vector search on your Search API
OpenSearch index. Queries can then match by semantic similarity rather than exact
keywords. See [Configuration](configuration/index.md) for the specifics.
