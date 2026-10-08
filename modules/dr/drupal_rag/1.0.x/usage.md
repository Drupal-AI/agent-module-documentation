<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drupal RAG turns a Drupal 11 site into a self-hosted Retrieval-Augmented Generation system: it indexes selected content/media as vector embeddings in pgvector via a local Ollama server, then serves natural-language retrieval and LLM-answer endpoints — without sending content to third-party AI vendors.

---

When an entity of an enabled type is inserted, updated, or deleted, `drupal_rag.module` hooks delegate to the `EntityHooks` service, which pushes only *published* entities of *configured* types onto the `drupal_rag_entity_processing` queue. The `DrupalRagEntityProcessingWorker` (cron-run) processes each item: `EntityExtractor` renders the entity in the configured view mode and strips HTML (or, for `file` entities, `FileTextExtractor` parses TXT/CSV/JSON/XML/MD/DOCX/XLSX/PPTX/ODF/PDF), `Chunker` splits the text into overlapping sentence-aware chunks (`chunk_size`/`chunk_overlap`), `EmbeddingService` sanitizes each chunk and calls `OllamaClient::embed` (`POST /api/embed`, model e.g. `nomic-embed-text`), and `VectorStorage` upserts the chunks and their vectors into the `drupal_rag_embeddings` table (native `vector(768)` column, HNSW cosine index) on a dedicated `pgvector` PostgreSQL connection. At query time three POST endpoints (permission `access rag query`, `_format: json`) drive the same embedding model over a sanitized `search_query:`-prefixed input: `/api/rag/query` runs a pgvector cosine search (`1 - (embedding <=> :vector::vector)`) and returns matching chunks with similarity scores; `/api/rag/prompt` (via `AugmentService::buildPrompt`) fills the configurable `{{context}}`/`{{query}}` template and returns the assembled prompt plus sources; `/api/rag/augment` (via `AugmentService::generate`) sends that prompt to Ollama chat (`/api/chat`) and returns the generated answer, sources, and prompt. Everything is configured on one form at `/admin/config/search/drupal-rag` (`drupal_rag.settings`), an admin status page at `/admin/reports/drupal-rag` reports the total indexed chunk count, and `drush drupal-rag:queue-all` (alias `rag:qa`) backfills all existing published content. Requires PostgreSQL + pgvector and a reachable Ollama server (external infrastructure, not Drupal modules); the documented `1.0.0-alpha5` is a pre-release alpha.

---

- Build an internal, privacy-preserving knowledge base that answers questions from your own Drupal content without a hosted AI vendor.
- Add natural-language semantic search over articles, documentation, or records instead of keyword search.
- Return the most relevant content chunks (with similarity scores and source entity IDs) to a custom front end via `POST /api/rag/query`.
- Have the module assemble a ready-to-send RAG prompt (context + question) for any external LLM via `POST /api/rag/prompt`.
- Get a fully generated answer plus cited sources from a local model via `POST /api/rag/augment`.
- Index technical documentation, policy documents, or public-administration records for staff Q&A.
- Make an archive of uploaded PDFs, Word, Excel, PowerPoint, and OpenDocument files searchable by meaning by indexing the `file` entity type.
- Power a customer-support assistant grounded in your published help content.
- Keep all embeddings and generation on-premises (Ollama + your own PostgreSQL) for data-residency or compliance requirements.
- Choose exactly which entity types are indexed on the settings form so only relevant content is embedded.
- Tune retrieval granularity with configurable chunk size (100–10000 chars) and overlap (0–5000 chars).
- Swap embedding models (e.g. `nomic-embed-text`, `all-minilm`) by selecting from models fetched live from your Ollama server.
- Use a separate chat model for answer generation while keeping a dedicated embedding model.
- Customize the system prompt/answer format by editing the `{{context}}`/`{{query}}` prompt template.
- Render entities for extraction through a specific view mode (Full/Teaser/RSS) to control what text gets indexed.
- Backfill an existing site's content in bulk with `drush drupal-rag:queue-all` after first configuring enabled types.
- Re-index automatically on content edits (entity update re-queues; old chunks are deleted before re-insert, an upsert).
- Remove embeddings automatically when content is deleted (delete events queue an embedding removal).
- Monitor indexing progress from the admin status page at `/admin/reports/drupal-rag`.
- Verify Ollama connectivity from the settings form with the built-in "Test connection" button.
- Process large content sets in the background via Drupal cron and the dedicated processing queue.
- Serve multilingual corpora — each chunk stores its `langcode` alongside the vector.
- Point Drupal at an Ollama instance elsewhere on the network by setting the Ollama base URL (e.g. `http://172.17.0.1:11434` for a Docker host).
