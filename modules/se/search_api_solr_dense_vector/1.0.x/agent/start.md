<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Search API Solr: Dense Vector — agent index

Adds **Solr 9+ dense-vector field support** to Search API Solr (vector/semantic search — k-NN over embeddings;
Solr as the vector store for RAG/similarity). Depends on `ai`. Version **1.0.0-alpha9**. Core `^10.3||^11.0`.

Search/AI-infra — indexes embeddings from your content; semantic search must still **respect content access**
(don't surface restricted content — Search API Solr's access handling + index config govern this). No access
role of its own.
