<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Pinecone Serverless VDB Provider registers Pinecone as a vector-database backend for the Drupal AI module's AI Search (Search API) stack, so embeddings can be stored in and queried from a Pinecone serverless index.

---

The module is an experimental `ai` sub-ecosystem provider: it implements the AI module's `AiVdbProvider` plugin (`PineconeProvider`, id `pinecone`) on top of `AiVdbProviderClientBase`, and wraps the `scotteuser/pinecone-php` (`Probots\Pinecone\Client`) PHP SDK in a thin `Pinecone` service (`pinecone.api`). Configuration is a single form at `/admin/config/ai/vdb_providers/pinecone` (permission `administer ai providers`) that stores only the name of a **Key** entity holding the Pinecone API key — the key value is resolved at runtime via the Key module, and the form validates it by listing the account's indexes. Once configured you select Pinecone as the vector database on an AI Search index (Search API server) and the provider handles create/list/describe index, upsert vectors into a namespace, fetch/query by vector with metadata filters, and delete by id / delete-all for a namespace. Index host lookup is dynamic (each call resolves the index's host from Pinecone's own `describe`/`list` response and sets it on the client), and index lists are cached under a key derived from a hash of the API key. Errors are surfaced via the messenger and logged to the `ai_search` channel. This module has no UI of its own beyond the key selection; the actual embedding, chunking and search UX comes from `ai`, `ai_search` and `search_api`.

---

- Use Pinecone serverless as the vector store behind Drupal AI Search / RAG.
- Store content embeddings in a Pinecone index instead of a local/self-hosted VDB.
- Run semantic similarity search over site content via Search API + AI Search.
- Configure the Pinecone API key through a Key entity (env/file/config provider) rather than plaintext.
- Validate Pinecone connectivity from the settings form (lists indexes on save).
- Upsert vectors with metadata into a named Pinecone namespace.
- Query Pinecone by vector with `topK` and metadata filters, optionally returning values/metadata.
- Fetch specific vectors by id from a namespace.
- Delete specific vector ids from a namespace, or clear an entire namespace.
- Retrieve index statistics (per-namespace vector counts).
- Partition one index across multiple namespaces for multi-tenant or per-bundle separation.
- Power an AI chatbot/assistant that grounds answers in embedded Drupal content.
- Build a "related content" or semantic recommendations feature backed by Pinecone.
- Offload vector storage to a managed serverless service to avoid running Milvus/other locally.
- Swap the AI Search VDB backend to Pinecone without changing the Search API index definition.
- Cache the list of available Pinecone indexes to reduce API calls.
- Choose the target Pinecone index/namespace per Search API server configuration.
- Centralise the Pinecone credential so multiple AI features share one Key entity.
