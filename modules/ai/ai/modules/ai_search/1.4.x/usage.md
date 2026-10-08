AI Search is a submodule of AI Core that provides a Search API backend (`search_api_ai_search`) which indexes content into a vector database and answers queries with semantic / RAG-style similarity search instead of keyword matching.

---

AI Search plugs into the contributed Search API module as a server backend, so you build vector search the same way you build any Search API index: create a server, add an index, choose fields. Under the hood the backend delegates vector storage to an `AiVdbProvider` plugin supplied by AI Core (Milvus, Pinecone, Postgres pgvector, etc. — you install one separately) and generates embeddings through AI Core's `embeddings` operation type on any configured AI provider. Before storing, content is chunked: an `EmbeddingStrategy` plugin (this module's own plugin type) decides how each item's fields are grouped into title / contextual / main content and split into token-sized chunks, then vectorized. Two strategies ship — `contextual_chunks` (Enriched Embedding Strategy, the default, one vector per chunk) and `average_pool` (Enriched Composite Embedding, a single averaged vector per item). At query time the search string is embedded with the same engine and compared by mathematical distance to the stored vectors, with optional per-entity `view` access checking and score-threshold filtering. The module also ships Search API processors that boost a normal database/Solr search using AI Search relevance, a RAG function-call tool (`ai_search:rag_search`) and an AI Assistant RAG action for retrieval-augmented chat, and an override of the Search API index Fields form that adds per-field indexing options (main content, contextual, filterable metadata) and chunk length controls. It is experimental and requires both `ai` and `search_api`.

---

- Add semantic (meaning-based) search to a Drupal site instead of keyword matching, via a Search API server using the AI Search backend.
- Index nodes, media, users or any Search API datasource into a vector database.
- Build a Retrieval-Augmented Generation (RAG) knowledge base that an LLM can query for grounded answers.
- Let the `ai_search:rag_search` function-call tool retrieve relevant content for an AI agent or chatbot.
- Enable the RAG action in an AI Assistant so chat responses cite indexed site content.
- Store embeddings in Milvus, Pinecone, pgvector or any installed `AiVdbProvider` without changing your indexing code.
- Generate embeddings through any AI provider's `embeddings` operation type (OpenAI, Mistral, Ollama, …) selected as the "Embeddings Engine".
- Chunk long field content into token-sized pieces automatically before embedding.
- Choose the `contextual_chunks` strategy for maximum accuracy (multiple enriched vectors per item).
- Choose the `average_pool` strategy for fewer vectors per item, trading accuracy for storage and query performance.
- Prepend a title and contextual content to every chunk so each vector keeps document context.
- Tune `chunk_size`, `chunk_min_overlap`, and `contextual_content_max_percentage` per server for indexing quality.
- Cap how much of each chunk is contextual metadata versus main content.
- Set embedding vector dimensions manually to trade quality against cost and speed.
- Configure per-field indexing options (main content, contextual content, filterable metadata) on the index Fields tab.
- Enforce entity `view` access on search results so users only see content they may read.
- Search on behalf of a bypassing service by setting the `search_api_bypass_access` query option.
- Return one result per source item, or per chunk, using the `search_api_ai_get_chunks_result` query option.
- Filter out weakly relevant hits with the `ai_search_score_threshold` processor.
- Boost an existing database Search API index with AI relevance using the `database_boost_by_ai_search` processor.
- Boost an existing Solr Search API index with AI relevance using the `solr_boost_by_ai_search` processor.
- Retrieve the raw embedding vector alongside results (for re-ranking) via the "Include raw embedding vector" setting.
- Implement a custom `EmbeddingStrategy` plugin to control exactly how content is chunked and vectorized.
- Count tokens accurately per chunk using AI Core's tokenizer with a selectable counting model.
- Preview how content will be chunked while configuring index fields.
- Re-index content after switching embedding strategy or engine (required when either changes).
