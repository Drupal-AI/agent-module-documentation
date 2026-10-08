<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI VDB Provider: OpenSearch adds OpenSearch (via its k-NN engine) as a vector-database backend for the AI module's AI Search submodule.

---

This module registers a single `AiVdbProvider` plugin (`opensearch`) that lets the AI Search submodule store content embeddings in an OpenSearch index and run approximate-nearest-neighbour (k-NN) vector searches over them. It does not talk to OpenSearch directly: it reuses **Search API OpenSearch** connector plugins for the OpenSearch PHP client, endpoint URL and authentication (credentials held in **Key** entities), and that project's `FilterBuilder` to turn Search API filter conditions into OpenSearch query DSL. Configuration lives in one config object (`ai_vdb_provider_opensearch.settings`): the chosen connector, its connector config, and the k-NN engine (FAISS/Lucene/NMSLIB). Collections map to OpenSearch indices whose `vector` field is a `knn_vector` mapping built with HNSW and a space type derived from the similarity metric. It is an experimental module in the "AI Vector Database Providers" package and requires AI, AI Search, Key and Search API OpenSearch.

---

- Use OpenSearch as the vector store behind AI Search / RAG.
- Store content embeddings in an OpenSearch k-NN index.
- Run semantic / vector similarity search over indexed content.
- Reuse an existing OpenSearch (or AWS OpenSearch Service) cluster for AI vector search.
- Pick the k-NN engine per site: FAISS (default), Lucene, or NMSLIB (deprecated, pre-OpenSearch 3).
- Choose the similarity metric via AI Search (Euclidean→`l2`, Cosine→`cosinesimil`, Inner product→`innerproduct`).
- Store OpenSearch credentials in Key entities rather than plain config.
- Connect through Search API OpenSearch connector plugins (standard, or AWS Signature v4 for AWS OpenSearch Service).
- Auto-create OpenSearch indices with HNSW mappings (`ef_construction` 128, `m` 16) when AI Search creates a collection.
- Index (upsert) embedding documents with a Drupal entity id and vector into OpenSearch.
- Delete embeddings by id or by `drupal_entity_id` when content is removed or reindexed.
- Filter vector search by indexed fields (converted to OpenSearch term/range filters) scoped to the current index.
- Ping / health-check the OpenSearch connection before indexing.
- List existing OpenSearch indices as available collections.
- Provide a vector backend for chatbots and question-answering over site content.
- Power "related content" and recommendation features from embeddings.
- Serve as a drop-in alternative to other AI VDB providers (Milvus, Qdrant, SQLite, Pinecone) for teams already running OpenSearch.
- Configure the backend at Admin → Configuration → AI → VDB Providers → OpenSearch.
- Support Drupal 10.2+ and Drupal 11.
