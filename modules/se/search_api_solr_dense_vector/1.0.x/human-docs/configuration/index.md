# Configuration

The module is configured on the **Dense Vector processor** of a Search API index.
That is where you connect it to an AI provider and decide the shape of the vectors
stored in Solr.

## Open the processor settings

1. Make sure your Search API server uses Search API Solr against a Solr 9.6+
   backend, and that you have an index on it.
2. Go to your index's **Processors** page under **Configuration → Search and
   metadata → Search API** (`/admin/config/search/search-api`).
3. Enable the **Dense Vector** processor and open its settings.

## What you configure

- **AI provider** — choose which provider from the Drupal AI framework will
  generate the embeddings. Any provider the AI module supports can be used; the
  module has been tested with OpenAI and Ollama.
- **Embedding model** — pick one of the embedding models offered by the provider
  you selected.
- **Vector dimension** — the size of the embedding vectors. This must match the
  output size of the embedding model you chose, since different models produce
  different-sized vectors.
- **Similarity function** — how closeness between vectors is measured when Solr
  runs the nearest-neighbour search.

Save the processor settings, then reindex so embeddings are generated and stored.

## Important limitations to plan for

**Store only one dense-vector field.** Solr can currently support only a single
dense-vector field, so index just one field as a dense vector.

**Changing the provider or model is not a light edit.** Because different embedding
models produce different-sized vectors, changing provider or model — or resizing
the field — means you must **regenerate and re-upload your Solr configuration set
and reindex** for Solr to reflect the new dimensions. Plan a provider or model
change as a deliberate migration, not a quick toggle.

**Respect content access.** Semantic search indexes embeddings derived from your
content, so confirm that a search cannot surface content the requester should not
see. That is governed by Search API Solr's access handling and your index
configuration, not by the vector layer itself — verify it explicitly.
