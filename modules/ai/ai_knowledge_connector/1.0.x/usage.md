AI Knowledge Connector turns Drupal content entities into chunked, embedded knowledge documents stored in a vector store, and hands RAG consumers a semantic-retrieval API.

---

AI Knowledge Connector is a self-contained RAG indexing pipeline for Drupal 11. On entity insert/update it queues the entity, a queue worker extracts its text, splits it into fixed-size chunks, generates an embedding per chunk (through a Drupal AI provider when configured, otherwise a deterministic local hash embedding), and upserts each vector into a pluggable vector store (a local database table ships by default). A hash of each entity's content is tracked in `ai_knowledge_connector_index` so unchanged content is skipped on re-index. Other modules call the `ai_knowledge_connector.retrieval_manager` service to run a semantic search and build a context string for a prompt. Everything is plugin-driven: vector stores, entity extractors, chunk strategies, and retrieval strategies are all annotation plugin types you can extend. The module depends only on core `system`; the Drupal AI provider manager is an optional soft dependency used only when a non-local embedding provider is configured. Admin surfaces are an settings form, a manual reindex form, an index-status report, and a vector-store health report, each gated by its own permission.

---

- Build a Retrieval-Augmented Generation (RAG) knowledge base from existing Drupal nodes, taxonomy terms, and media without exporting content elsewhere.
- Automatically index new and updated content: entity insert/update hooks queue the entity for embedding.
- Automatically remove vectors for deleted entities via the entity delete hook.
- Restrict indexing to specific content entity types (nodes, terms, media, custom entities) from the settings form.
- Index only published entities (default) or include unpublished content by toggling `index_published_only`.
- Skip re-embedding unchanged content using SHA-256 content-hash tracking in the index table.
- Chunk long documents into fixed-size character windows with configurable size and overlap.
- Generate embeddings through any Drupal AI provider plugin (OpenAI, Mistral, Hugging Face, etc.) by setting the provider id and model.
- Run fully offline in development using the built-in deterministic `local-hash-256` embedding and the local-database vector store.
- Store vectors in the Drupal database (`ai_knowledge_connector_vectors`) for local development and small sites.
- Swap in a production vector store (Qdrant, PgVector, Pinecone, Weaviate, Milvus) by implementing a `VectorStoreInterface` plugin.
- Provide a semantic-search API (`RetrievalManager::search()`) to chatbots, agents, MCP servers, or custom controllers.
- Build a ready-to-inject prompt context string with `RetrievalManager::buildContext()`.
- Queue a full reindex of all enabled entity types from the Manual reindex admin form.
- Scale indexing through Drupal's Queue API and cron (queue workers with a 30s cron time budget).
- Monitor which entity revisions are indexed, their document ids and hashes, from the AI index status report.
- Check vector-store connectivity and document counts from the vector store health report.
- Extend the pipeline with a custom entity extractor to control exactly which fields become knowledge text.
- Add a custom chunk strategy (for example sentence- or token-based splitting) as a plugin.
- Add a custom retrieval strategy (for example hybrid keyword + vector search) as a plugin.
- Attach cache tags, cache contexts, language, workspace, and publish-state metadata to every stored document for downstream filtering.
- Keep Drupal as the single source of truth while treating LLMs as consumers rather than dependencies.
- Support multilingual sites by indexing each entity translation as its own document keyed by langcode.
