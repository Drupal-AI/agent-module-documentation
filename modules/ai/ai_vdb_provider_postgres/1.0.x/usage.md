<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Postgres VDB Provider lets the Drupal AI module store and similarity-search embeddings in a PostgreSQL database using the pgvector extension, instead of a dedicated vector service.

---

Retrieval-augmented generation and semantic search need somewhere to keep embeddings and query them by similarity, and the usual answer is a managed vector service — another vendor, credential and backup. If your stack already runs PostgreSQL, the pgvector extension turns it into a competent vector store that lives inside the same database boundary and backups as the rest of your data. This module registers a `postgres` provider against the AI module's vector-database abstraction (`ai.vdb_provider`), so AI Search and any RAG pipeline built on that abstraction can use Postgres without knowing which backend is underneath, and switching later is configuration. Under the hood the `PostgresPgvectorClient` service creates a per-Search-API-server table holding the native columns (`content`, `drupal_entity_id`, `drupal_long_id`, `server_id`, `index_id`, `embedding vector(N)`), adds extra columns or `<collection>__<field>` relation tables for the fields you index, and runs vector search with pgvector's distance operators, choosing an index strategy — `none` (exact), `hnsw`, or `ivfflat` — which is the main recall-versus-speed lever. Configuration happens in two places: a global connection at `/admin/config/ai/vdb_providers/postgres` (host, port, username, a **Key entity** for the password via the required `key` module, and a default database), and per-server settings (database, collection, similarity metric, index strategy) on the AI Search backend. **The database password is stored as a Key id, not in plain config**, and the settings form runs a live connection test on save. Two caveats: the module is `lifecycle: experimental` at release `1.0.0-alpha3`, so treat the API as unsettled; and the pgvector `vector` extension must already be enabled on the Postgres server (this module does not install it, and the connection test is where a missing extension shows up). The `pgsql` PHP extension is also required on the web server.

---

- Store AI/RAG embeddings in PostgreSQL with pgvector.
- Run semantic search without a separate vector service.
- Keep embeddings inside an existing database and backup boundary.
- Register Postgres as an AI Search vector-database backend.
- Choose an index strategy (none / HNSW / IVFFlat) for recall vs speed.
- Pick a similarity metric (cosine, Euclidean/L2, inner product).
- Configure an external Postgres host, port, user and default database.
- Store the database password in a Key entity rather than plain config.
- Test the database connection from the settings form before use.
- Verify the pgvector extension is available on the server.
- Swap vector backends later through configuration alone.
- Index multi-value fields via automatic relation tables.
- Filter vector searches on indexed field conditions.
- Power a RAG chatbot or assistant over site content.
- Build a "related content" or similarity feature on existing infrastructure.
- Avoid a second vendor and credential for vector storage.
- Override the default database per Search API server.
- Evaluate an experimental provider before committing to it.
- Compare pgvector cost and performance against a managed vector DB.
