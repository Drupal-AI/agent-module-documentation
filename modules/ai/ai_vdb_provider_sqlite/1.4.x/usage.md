<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SQLite VDB Provider adds SQLite (via the sqlite-vec extension) as a vector-database backend for the Drupal AI module's AI Search, storing and querying embeddings in a local SQLite file with no separate database service.

---

This module registers a `sqlite` VDB provider plugin (`SQLiteProvider`) with the AI module so that a Search API server using the AI Search backend can persist embeddings in a plain SQLite database file. It relies on the open-source sqlite-vec (`vec0`) extension loaded into PHP's SQLite3 driver to create `vec0` virtual tables for vectors and companion relation tables (`{collection}__{field}`) for filterable attributes. It supports collection create/drop, item insert/delete, KNN vector search (cosine/L2/inner-product via AI Search), post-filtered vector search, and plain metadata query search. Configuration lives in `ai_vdb_provider_sqlite.settings` (a database directory path plus the sqlite-vec extension filename), exposed at `/admin/config/ai/vdb_providers/sqlite` behind the `administer ai providers` permission. It depends on the AI module (and Key, plus AI Search and Search API at runtime); it is experimental. A `hook_file_download` implementation denies web download of files under the configured DB directory, and the config form warns if the chosen directory is publicly reachable.

---

- Use SQLite + sqlite-vec as the vector store for AI Search instead of Milvus/Pinecone/Postgres.
- Run a lightweight, serverless local vector database (one file, no extra service to deploy).
- Power Retrieval-Augmented Generation (RAG) over indexed Drupal content.
- Provide semantic / similarity search on nodes, media, or any Search API datasource.
- Store embeddings in a Drupal private:// directory kept out of the webroot.
- Create a vector collection (a `vec0` virtual table) automatically when saving an AI Search server.
- Index Search API items as embedding chunks with `indexItems()`.
- Delete indexed items (resolving Drupal ids to chunk ids) when content changes or is removed.
- Filter vector searches by native fields (content, entity id, server/index id) and by configured Filterable attributes.
- Support `=`, `!=`/`<>`, `IN`, and `NOT IN` filter operators across AND/OR condition groups.
- Handle multi-value filterable fields via per-value relation-table rows.
- Return raw embedding vectors when the AI Search backend enables `include_raw_embedding_vector`.
- Choose the similarity metric (cosine, L2, inner product) from the AI Search backend UI.
- Prototype AI Search locally without provisioning cloud vector infrastructure.
- Keep vector data portable — copy the single SQLite file between environments.
- Validate at install time that PHP's `sqlite3` extension is present (`hook_requirements`).
- Warn when `sqlite3.extension_dir` is unset so the vec0 extension can be located.
- Configure the DB directory and `vec0.so` filename through an admin settings form.
- Verify at save time that the DB directory exists, is writable, and is not web-accessible.
- Block direct file downloads of the vector database via `hook_file_download`.
- Recreate per-field relation tables on demand after a `search-api:clear`.
- Use as a drop-in alternative provider modeled on the Postgres VDB Provider.
