# OpenAI Text Embeddings (openai_embeddings) — agent index

Generates embeddings for content and stores them in a pluggable vector backend (Milvus /
Pinecone) for semantic search, over the parent `openai.api` service. Parent:
[../../../../1.0.x/agent/start.md](../../../../1.0.x/agent/start.md).

- **The `vector_client` plugin type + Milvus/Pinecone clients** → [plugins/vector-client.md](plugins/vector-client.md)

Key facts:
- Config `openai_embeddings.settings`: `model` (default `text-embedding-ada-002`) + a large
  `stopwords` list (stripped before embedding). Schema `openai_embeddings.schema.yml`.
- Admin routes (all **`administer site configuration`**): `openai_embeddings.settings`
  (SettingsForm), `openai_embeddings.search` (SearchForm test), `openai_embeddings.stats`
  (`VectorDatabaseStats::index`), `openai_embeddings.delete_confirm` (DeleteConfirmForm).
- Plugin type **`vector_client`**: manager `plugin.manager.vector_client`
  (`VectorClientPluginManager`, dir `Plugin/openai_embeddings/vector_client`), annotation
  `\Drupal\openai_embeddings\Annotation\VectorClient`, interface `VectorClientInterface`, base
  `VectorClientPluginBase`. Ships `Milvus` and `Pinecone`.
- Indexing runs through `EmbeddingQueueWorker` (`openai.api->embedding()`).
- Requires the parent's API key and a reachable vector backend.
