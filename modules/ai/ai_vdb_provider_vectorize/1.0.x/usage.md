<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cloudflare Vectorize VDB Provider registers Cloudflare Vectorize as a vector-database backend for the Drupal AI module's Search API integration.

It exposes a `VdbProvider` plugin (`CloudflareVectorize`) that the AI Search stack uses to create indexes, insert/delete vectors, and run similarity queries against Vectorize, plus a `VectorizeMapper` that translates Search API fields into Vectorize metadata. The admin fills in Cloudflare account and index settings on the provider settings form at `/admin/config/ai/vdb_providers/vectorize`; credentials are handled through the underlying cloudflare_* SDK modules rather than stored by this module directly. The settings route is gated on `administer ai providers`, and the module performs no anonymous or mutating public endpoints.

Use it when you want Drupal semantic search whose embeddings live in Cloudflare Vectorize instead of a self-hosted vector store, keeping the vector index at the edge alongside other Cloudflare AI services.
---
Registers Cloudflare Vectorize as a Search API vector-database provider for the Drupal AI module.
---
- Install alongside ai, ai_search, search_api and the cloudflare_ai/sdk/api stack
- Configure the Vectorize provider at /admin/config/ai/vdb_providers/vectorize
- Select the Cloudflare Vectorize provider when creating an AI Search index
- Store document embeddings in Cloudflare Vectorize
- Run semantic / similarity queries backed by Vectorize
- Map Search API fields to Vectorize vector metadata
- Create a Vectorize index for a Drupal content type
- Delete vectors when source entities are removed
- Re-index content into Vectorize after content changes
- Combine Vectorize vector search with keyword Search API backends
- Keep vector storage at the Cloudflare edge instead of self-hosting
- Grant the "administer ai providers" permission to configure the backend
- Point AI RAG / chat pipelines at Vectorize-backed retrieval
- Tune the Vectorize namespace / index name per environment
- Validate connectivity to Cloudflare from the provider settings
- Use as a drop-in VDB provider alongside other AI vector backends
- Support multilingual semantic search via embedded content
