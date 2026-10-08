OpenAI Text Embeddings generates vector embeddings for site content via OpenAI and stores them in a pluggable vector backend (Milvus or Pinecone) so you can compute similarity between strings and build semantic search, backed by the core `openai.api` service.

---

The submodule indexes content by turning field text into embeddings
(`openai.api->embedding()`) and pushing them to a vector database through a **`vector_client`**
plugin type (manager `plugin.manager.vector_client`, annotation
`\Drupal\openai_embeddings\Annotation\VectorClient`, interface `VectorClientInterface`, base
`VectorClientPluginBase`); two clients ship — `Milvus` and `Pinecone`. Indexing is queued via
an `EmbeddingQueueWorker`. Admin routes (all `administer site configuration`) provide a
settings form (`openai_embeddings.settings` — config `openai_embeddings.settings` holds the
embedding `model` default `text-embedding-ada-002` and a large `stopwords` list, schema
`openai_embeddings.schema.yml`), a **test search** form, a **vector database stats** page, and
a **delete items** confirm form. Stopwords are stripped before embedding to reduce noise/cost.
Requires the OpenAI API key on the parent and a configured/reachable vector backend.

---

- Build semantic (meaning-based) search over site content.
- Find content similar to a given string or node.
- Generate and store OpenAI embeddings for entities.
- Use Pinecone as the vector backend for embeddings.
- Use Milvus as the vector backend for embeddings.
- Compute relationships/similarity between text strings.
- Power "related content" suggestions via vector similarity.
- Queue embedding generation for large content sets.
- Strip stopwords before embedding to cut tokens and noise.
- Configure which embedding model is used.
- Test similarity search from an admin form.
- Inspect vector database statistics (counts, etc.).
- Bulk-delete indexed vectors from the backend.
- Add a new vector backend by writing a `vector_client` plugin.
- De-duplicate or cluster content by embedding proximity.
- Improve search relevance beyond keyword matching.
- Index content automatically as it is created/updated (via queue).
- Prototype RAG-style retrieval over Drupal content.
- Keep all embedding admin behind `administer site configuration`.
- Reuse the shared `openai.api` service and API key.
