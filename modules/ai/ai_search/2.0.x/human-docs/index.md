# AI Search — manual setup guide

**AI Search** (`ai_search`) is a [Search API](https://www.drupal.org/project/search_api)
backend that indexes your content as **vector embeddings** in a vector database,
enabling **semantic search** — matching on meaning rather than on the exact words.

Keyword search fails in a predictable way: someone searching "how do I cancel my
membership" finds nothing because the page says "ending your subscription". Vector
search fixes that by turning both the content and the query into points in a space
where semantic similarity can be measured, so related meaning matches even when the
vocabulary does not. It is also the *retrieval* half of **retrieval-augmented
generation (RAG)** — an on-site AI assistant needs exactly this to find the
relevant passages before it answers — which is why it lives in the AI family. It
depends on the [AI module](https://www.drupal.org/project/ai) for the embedding
provider and on `search_api (>=8.x-1.40)`.

> **Weigh these before putting it in your search path.** Its info file declares
> **`lifecycle: experimental`** and the release is **2.0.0-alpha2** — both signals
> to take seriously for something that sits in the search path.

Three things belong in any evaluation:

- **Cost.** Embedding is billed per item indexed *and* per query with a hosted
  provider. A large site's full reindex is a real invoice — estimate it first.
- **Data flow.** Content leaves the site to be embedded unless the provider is
  local (for example Ollama through the AI module). For unpublished or sensitive
  content that is the deciding question.
- **Access control is the hard part.** A vector index returns nearest neighbours;
  ensuring restricted content does not surface depends on **Search API's access
  handling being applied and verified**, not on the backend. Test with a restricted
  item explicitly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside the AI and Search API modules.
2. [Configuration](configuration/index.md) — create an AI Search server, attach a
   vector database, and build an index.

## Where it lives in the admin menu

AI Search is not a standalone settings page — it is a Search API backend. You
configure it under **Configuration → Search and metadata → Search API**
(`/admin/config/search/search-api`), where you create a server that uses the AI
Search backend and then add an index to it.

## How to use it

Make sure you have a working AI provider that offers embeddings (and, typically, a
vector database it can write to). Then in Search API create a **server** whose
backend is AI Search, point it at your embeddings provider and vector database,
create an **index** of the content you want searchable, and index it. Wire that
index into a search page or an AI assistant's retrieval step.
