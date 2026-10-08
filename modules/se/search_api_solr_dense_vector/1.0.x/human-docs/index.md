# Search API Solr: Dense Vector — manual setup guide

**Search API Solr: Dense Vector** (`search_api_solr_dense_vector`) adds
dense-vector field support to Search API Solr for **Solr 9.6 and newer**, which
opens up **vector (semantic) search** — matching content by meaning rather than by
exact keywords. The goal is that a visitor can type a loose, natural-language query
and still get semantically relevant results, and that Solr can serve as the vector
store behind AI features such as RAG and similarity search.

It works through Drupal's core **AI** framework, so you are not tied to one
embedding provider: you can pick any AI provider the framework supports and choose
one of its embedding models. The vector dimension and the similarity function are
both configurable. Embeddings generated from your content are stored in the Solr
index, and a k-NN (nearest-neighbour) search finds the closest matches to a query's
embedding. It has been tested with the OpenAI and Ollama provider modules.

This is search/AI infrastructure and has no access-control role of its own.
Semantic search still has to **respect content access** — it indexes embeddings
derived from your content, so you must make sure a search does not surface content
the requester shouldn't see. Search API Solr's own access handling and your index
configuration are what govern that; verify it rather than assuming the vector layer
enforces anything. Note that this release (1.0.x) is an **alpha**.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module, and the Solr/AI prerequisites.
2. [Configuration](configuration/index.md) — set up the Dense Vector processor:
   provider, model, dimension and similarity.

## How it surfaces

There is no site-wide settings page. The feature appears as a **Dense Vector
processor** on your Search API index, where you select the AI provider and
embedding model and tune the vector settings. See
[Configuration](configuration/index.md).
