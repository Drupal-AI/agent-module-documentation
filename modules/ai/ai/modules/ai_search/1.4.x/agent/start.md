# ai_search (AI Search) 1.4.x — agent index

A **Search API backend** (`search_api_ai_search`) that indexes content into a **vector
database** and answers queries with semantic / RAG similarity search. It is a submodule of
AI Core (`ai`) and requires `search_api`.

Mental model: a Search API **server** using the AI Search backend delegates vector storage
to an **`AiVdbProvider`** plugin from AI Core (Milvus, Pinecone, pgvector — install one
separately), generates vectors through AI Core's **`embeddings`** operation type on any AI
provider, and chunks content via an **`EmbeddingStrategy`** plugin (this module's own plugin
type). At query time the search string is embedded the same way and compared by distance.

- **Set up a vector search server + index** (backend, VDB provider, embeddings engine, chunking, field indexing options) → [configure/ai_search.md](configure/ai_search.md)
- **Implement an EmbeddingStrategy plugin** (how content is chunked/vectorized) → [plugins/ai_search.md](plugins/ai_search.md)
- **RAG / query API** (function-call tool, query options, services, boost processors) → [api/ai_search.md](api/ai_search.md)

No permissions, Drush commands, hook API (`*.api.php`), or dedicated config route — setup is
done through Search API's own server/index UI.
