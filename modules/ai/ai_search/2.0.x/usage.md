<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Search is a Search API backend that indexes content as **vector embeddings** in a vector database, enabling semantic search — matching on meaning rather than on words — and providing the retrieval layer for RAG.

---

Keyword search fails predictably: someone searching "how do I cancel my membership" finds nothing because the page says "ending your subscription". Vector search fixes this by embedding both content and query into a space where semantic closeness is measurable, so related meaning matches even when vocabulary does not. Install it with `composer require drupal/ai_search` and `drush en ai_search`; it needs the **`ai`** module (for an embeddings provider and a vector-database provider such as Milvus, Pinecone, Qdrant or MySQL-vector) and **Search API** `>=8.x-1.40`. You then work entirely inside Search API's own admin UI: add a **server** using the **AI Search** backend and pick a VDB, an embeddings engine (`provider__model`) and an **embedding strategy** (`contextual_chunks` for multiple context-enriched vectors per item, or `average_pool` for one composite vector); add an **index** with the **AI Search Chunked Tracker**; then on the index **Fields** tab (which the module overrides) mark each field as **Main Content** (chunked and embedded), **Contextual Content** (added to every chunk) or **Filterable Attribute** (VDB metadata). Content is split into overlapping **chunks** so long pages embed accurately, and a preview tool shows what will be vectorized before you index. Three things to weigh: embedding **costs money per item indexed and per query** on hosted providers, **content leaves the site** to be embedded unless the provider is local (e.g. Ollama), and **entity access is enforced by the backend by default** — each match is re-checked with `entity access('view')` for the current user, with over-fetching to backfill the limit. It also powers **hybrid search** (Boost-by-AI-Search processors prepend semantic hits to a Database or Solr index) and **RAG** (a `ai_search:rag_search` function-call tool and a `rag_action` assistant action) so chatbots and agents can pull relevant passages.

---

- Search by meaning rather than keywords.
- Match "cancel membership" to "end subscription".
- Provide retrieval for an AI assistant or chatbot (RAG).
- Improve search on a documentation or support site.
- Reduce zero-result searches.
- Find related/similar content by embedding vector.
- Support natural-language and sentence-form queries.
- Build a RAG pipeline over site content.
- Index content as chunked embeddings in a vector database.
- Enrich each chunk with contextual content for accuracy.
- Use a single composite vector per item to save storage (average pool).
- Combine semantic and keyword search (hybrid Database/Solr boost).
- Use a local embeddings model (e.g. Ollama) to keep content on-site.
- Support multilingual semantic matching.
- Filter results by a minimum relevance score threshold.
- Filter by VDB metadata attributes.
- Expose a search tool to an AI agent via function calling.
- Give an AI assistant one or more configurable RAG databases.
- Enforce per-entity view access on semantic results by default.
- Preview exactly what will be vectorized before indexing.
- Write a custom embedding strategy for content with natural boundaries.
- Re-rank or boost results with a hook.
