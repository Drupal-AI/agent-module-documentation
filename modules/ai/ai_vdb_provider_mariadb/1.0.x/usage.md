<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Registers MariaDB's native VECTOR type as a vector-database provider for the Drupal AI module.

---

MariaDB VDB Provider lets the Drupal AI module and its AI Search submodule use MariaDB's native `VECTOR`
column type and VECTOR index (MariaDB 11.7+) as a vector-database backend — so embeddings are stored and
queried inside a MariaDB database instead of an external vector service. By default it reuses Drupal's own
active database connection (giving full transactional roll-back with entity changes and zero extra
infrastructure); a dedicated MariaDB instance can instead be configured through a `settings.php` config
override. It creates a table per collection with an `embedding VECTOR(n)` column and a distance index
(cosine or Euclidean), maps Search API fields to columns (multi-value fields get their own relation tables),
and runs similarity queries with MariaDB's `VEC_DISTANCE_*` functions. It also throttles embedding API calls
during indexing to respect the embedding provider's rate limits, and ships Drush commands for testing OpenAI
rate limits. It provides a single admin info page and no permissions of its own.

---

- Store AI embeddings natively in MariaDB (11.7+) with the `VECTOR` column type.
- Register the "MariaDB vector DB" provider (plugin id `mariadb`) for AI Search.
- Run semantic / vector similarity search without an external vector database.
- Reuse Drupal's existing MariaDB connection for transactional vector writes.
- Point at a separate MariaDB instance via a `settings.php` config override.
- Choose cosine or Euclidean distance for the VECTOR index.
- Create one table per collection with an HNSW-style VECTOR index.
- Map single-value Search API fields to columns and multi-value fields to relation tables.
- Scope every query to its Search API index via a mandatory `index_id` filter.
- Support retrieval-augmented generation (RAG) over content in MariaDB.
- Throttle embedding API calls during indexing to avoid provider rate limits.
- Compute a per-call delay from configured RPM / TPM / average-tokens values.
- Retry indexing with exponential backoff when a provider rate limit is hit.
- Log per-call embedding timing and token usage when debug mode is enabled.
- Diagnose OpenAI rate limits with the `ai-vdb:test-rate-limits` Drush command.
- Simulate batch indexing load with the `ai-vdb:test-batch-indexing` Drush command.
- Auto-create/alter the collection table when a Search API index is updated.
- Pre-fill sensible MariaDB defaults on the Search API server form.
- Surface a MariaDB version / vector-support check on the status report.
- Swap MariaDB in for another VDB provider without changing your Views.
