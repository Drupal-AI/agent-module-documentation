<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Milvus/Zilliz VDB Provider registers a `milvus` Vector Database provider plugin for Drupal's AI module, so AI Search (and other AI features) can store and query embeddings in a self-hosted Milvus instance or Zilliz Cloud.

---

The module plugs into the AI ecosystem: it defines one `VdbProvider` plugin (`MilvusProvider`, extending `AiVdbProviderClientBase`) that the `ai`/`ai_search` modules discover and use to create collections, insert vectors, and run similarity/vector searches against a Milvus 2.x REST API (v2 endpoints). A thin service `milvus_v2.api` (`MilvusV2`) wraps Guzzle and implements the concrete REST calls (`createCollection`, `dropCollection`, `insertIntoCollection`, `deleteFromCollection`, `query`, `search`, plus `listCollections`/`describeCollection`). Connection settings live in one config object `ai_vdb_provider_milvus.settings` with three keys: `server` (a full URL), `port`, and `api_key` (the machine name of a **Key** entity, not the secret itself). The single config form at `/admin/config/ai/vdb_providers/milvus` (permission `administer ai providers`) validates the server URL, pings the server through the provider plugin before saving, and normalises the URL. Authentication, when a key is set, is sent as a `Bearer <token>` header; for Milvus the key value is expected in `username:password` form. The provider auto-detects Zilliz Cloud from the host name (`zillizcloud.com`/`cloud.zilliz.com`) and adjusts request shapes accordingly. `hook_install` migrates settings from the older in-tree `ai_provider_milvus`/`vdb_provider_milvus` submodule and uninstalls it. The module is marked `experimental`.

---

- Store AI Search index embeddings in a self-hosted Milvus vector database instead of a SaaS.
- Point Drupal AI Search at a Zilliz Cloud endpoint for managed vector storage.
- Run semantic / similarity search over content indexed by the AI Search module.
- Back a Retrieval-Augmented Generation (RAG) pipeline with a Milvus collection.
- Spin up a local Milvus in DDEV (via the shipped docker-compose example) for development.
- Create and drop Milvus collections programmatically from Drupal code.
- Insert vector embeddings plus metadata fields into a collection.
- Delete vectors from a collection by id.
- Query a collection with scalar filters, output-field selection, limit and offset.
- Perform a nearest-neighbour vector search returning ranked matches.
- List and describe collections on a Milvus/Zilliz server.
- Authenticate to Milvus with a `username:password` credential stored as a Key entity.
- Authenticate to Zilliz Cloud with an API token stored as a Key entity.
- Keep the vector-DB credential out of config by referencing a `key` (env/file provider).
- Validate connectivity from the admin UI (a ping is run before settings save).
- Use a specific database name within a Milvus deployment for multi-tenant separation.
- Choose the distance metric type (e.g. cosine, L2, IP) when creating a collection.
- Migrate from the deprecated in-`ai` Milvus submodule to this standalone module automatically.
- Provide vector storage for a custom AI feature that consumes the `ai.vdb_provider` plugin manager.
- Separate the search backend (Solr/DB) from the vector store (Milvus) in a hybrid setup.
