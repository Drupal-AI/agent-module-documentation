<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Qdrant VDB Provider adds Qdrant as a vector-database provider for the Drupal AI module, letting AI Search store and query embeddings in a Qdrant instance.

---

Qdrant VDB Provider registers a single `AiVdbProvider` plugin (`qdrant`) that the AI module's AI Search backend can select as its vector store. It talks to a Qdrant server over the HTTP REST API through a thin `QdrantClient` service (built on Guzzle via `http_client_factory`), handling collection creation/drop, point upsert/delete, scroll (`querySearch`) and vector similarity search (`vectorSearch`). Search API query condition groups are translated into Qdrant's `must` / `should` / `must_not` filter structure by the provider plugin. Connection settings (host, port, optional API key referenced through the Key module) live in the `ai_vdb_provider_qdrant.settings` config object and are edited at `/admin/config/ai/vdb_providers/qdrant` (permission `administer ai providers`). It is an experimental integration module with no content-facing features of its own.

---

- Add Qdrant as a vector-database provider for AI Search.
- Back Drupal RAG / semantic search with a Qdrant instance.
- Store Search API index embeddings as Qdrant points.
- Run vector similarity search over indexed content.
- Run filtered scroll queries against a Qdrant collection.
- Auto-create a Qdrant collection when an index is first populated.
- Drop a Qdrant collection when an index/server is cleared.
- Upsert points keyed by an MD5 of the Drupal long id.
- Delete points for specific Drupal entity ids on re-index.
- Translate Search API `=`, `<>`, `<`, `>`, `IN`, `NOT IN`, `BETWEEN` conditions into Qdrant filters.
- Map AND/OR condition groups to Qdrant `must` / `should` / `must_not`.
- Filter on multi-value fields via Qdrant `match.any`.
- Connect to a local Qdrant (default port 6333) for development.
- Connect to a remote or cloud Qdrant endpoint over HTTPS.
- Authenticate to Qdrant with an API key stored as a Key entity.
- Run Qdrant without an API key for an open local instance.
- Choose cosine, dot-product or Euclidean similarity via the AI Search server config.
- Test the connection from the config form (ping) before saving.
- Provide config schema so settings are exportable via CMI.
- Serve embeddings for AI assistants / chatbots that query indexed site content.
- Keep vector data on your own infrastructure by self-hosting Qdrant.
- Use the docker-compose example under `docs/` to spin up a local Qdrant.
