<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Registers OpenAI's hosted Vector Store as a vector-database backend for Drupal AI Search.

---

OpenAI VDB Provider integrates OpenAI's hosted Vector Store API with the Drupal AI module's AI Search /
Search API stack, giving semantic search without running a vector database. Instead of storing embeddings
locally, it uploads each Search API item to OpenAI as a Markdown file and lets OpenAI perform the chunking,
embedding and vector storage; searches are then run with a plain-text query (OpenAI embeds it server-side,
so the backend skips its own embedding call). The module keeps an item-to-file mapping table, deduplicates
re-uploads with a content checksum, polls each file until OpenAI reports it processed, and on cron reconciles
drift — retrying remote deletions that failed and re-queuing items whose files disappeared. Search API
"Filterable Attributes" map to OpenAI attribute filters (up to 16 per file, one reserved for the index
scope). It requires the OpenAI AI provider (`ai_provider_openai`) and AI Search, with the API key stored via
the Key module. It is experimental / alpha and explicitly not production-ready.

---

- Use OpenAI's hosted Vector Store as an AI Search backend (plugin id `openai_vector_store`).
- Get semantic search without operating your own vector database.
- Upload each Search API item to OpenAI as a Markdown file.
- Let OpenAI handle chunking, embedding and vector storage server-side.
- Search with a natural-language text query rather than a pre-computed vector.
- Skip the redundant local embedding call at query time.
- Map Search API "Filterable Attributes" to OpenAI attribute filters.
- Scope every search to its index via a reserved `index_id` attribute.
- Warn when more than 15 filterable attributes are configured (OpenAI's 16 cap minus one).
- Track item-to-file mappings in a local database table.
- Deduplicate uploads with an SHA-256 content+attributes checksum.
- Poll each uploaded file until it reaches a terminal (completed/failed) status.
- Re-poll a still-processing file on the next run instead of re-uploading it.
- Retry failed remote deletions on cron via the reconciler.
- Reconcile drift daily between the mapping table and OpenAI, re-queuing vanished files.
- Configure a per-server OpenAI Vector Store ID (e.g. `vs_...`).
- Pass an OpenAI chunking strategy derived from the embedding strategy config.
- Apply an "AI Search Score Threshold" as OpenAI's search score threshold.
- Optionally enable OpenAI's query rewriting via the `openai_rewrite_query` processor.
- Store the OpenAI API key via the Key module and the OpenAI AI provider.
