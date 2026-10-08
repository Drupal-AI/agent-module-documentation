<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides an Elasticsearch backend for the Drupal AI module's AI Search using native dense_vector kNN.

---

Elasticsearch VDB Provider registers an "Elasticsearch (Native kNN)" vector-database provider for the Drupal
AI module and its AI Search submodule, storing embeddings in Elasticsearch's native `dense_vector` field with
HNSW-accelerated approximate kNN. Semantic search and RAG then run directly against an existing Elastic Stack
with no separate vector database to operate. It uniquely supports hybrid search — combining kNN vector search
with BM25 keyword matching in one request, merged via Reciprocal Rank Fusion (RRF) on Elasticsearch 8.8+.
Credentials are read from Key module entities (an API key, or a Basic Auth username plus a keyed password);
the cluster host, an index-name prefix and the similarity metric are set on a provider settings form. The
module also bundles an optional pure-PHP PDF text extractor for Search API Attachments and an event
subscriber that registers extra text/document MIME types so Markdown, YAML, AsciiDoc and similar files index
as text. It is experimental, uses the official `elasticsearch/elasticsearch` 8.x PHP client, and provides no
routes beyond one admin settings form.

---

- Use an existing Elasticsearch/OpenSearch-compatible 8.x cluster as the AI Search vector store.
- Register the "Elasticsearch (Native kNN)" VDB provider (plugin id `elasticsearch`).
- Store embeddings in a native `dense_vector` field with HNSW indexing.
- Run approximate kNN similarity search from Search API / AI Search.
- Run hybrid kNN + BM25 search merged with Reciprocal Rank Fusion (ES 8.8+).
- Tune the RRF rank constant to balance vector vs keyword scoring.
- Pre-filter kNN results by entity type, bundle or language for access control.
- Choose the similarity metric (cosine, L2 norm, dot product) at index creation.
- Namespace indices with a configurable prefix to share a cluster across sites.
- Authenticate with an Elasticsearch API key stored in a Key entity.
- Fall back to HTTP Basic Auth (username + keyed password) when no API key is set.
- Connect to an unauthenticated local dev cluster (e.g. DDEV) when security is disabled.
- Bulk-index embedding chunks in a single request via the Elasticsearch Bulk API.
- Delete a Drupal entity's vector chunks by resolving their document IDs.
- Index PDFs with the bundled pure-PHP `php_pdfparser_extractor` (no external binary).
- Index Markdown, YAML, AsciiDoc, Org, RST and similar files by registering their MIME types.
- Swap Elasticsearch in for another VDB provider without changing your Views.
- Back an AI Assistant / chatbot with Elasticsearch-hosted semantic search.
- Surface missing PHP libraries at install time via hook_requirements.
- Restrict configuration to users with the "administer ai providers" permission.
- Support Drupal 10.3+ and Drupal 11.
