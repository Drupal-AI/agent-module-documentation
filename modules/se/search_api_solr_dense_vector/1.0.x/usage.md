<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API Solr: Dense Vector provides an implementation of Dense Vector field support for Solr 9.x+ in Drupal.

---

Search API Solr: Dense Vector adds dense-vector field support to Search API Solr for Solr 9.x+ — enabling
vector/semantic search (k-NN over embeddings) in Solr, so AI-powered search (RAG, similarity) can use Solr as
the vector store. It depends on the AI module, in the Search package.

Use it for vector/semantic search backed by Solr. It is a search/AI-infrastructure feature; it indexes
embeddings derived from your content, and — importantly for access — semantic/vector search must still
**respect content access** (ensure the search doesn't surface content the requester shouldn't see; Search API
Solr's access handling and your index configuration govern this). It has no access-control role of its own.
Configure the Solr dense-vector fields and index.

---

- Add Solr 9+ dense-vector support.
- Enable vector/semantic search in Solr.
- Support k-NN over embeddings.
- Depend on the AI module.
- Use Solr as the vector store.
- Support RAG/similarity search.
- Ensure semantic search respects content access.
- Not surface restricted content.
- Have no access-control role of its own.
- Configure Solr dense-vector fields.
- Index embeddings.
- Handle vector search.
- Configure the index.
- Enable semantic search.
- Support AI search.
- Handle dense vectors.
- Configure Solr vectors.
- Index vectors.
- Configure vector fields.
- Enable vector search.
