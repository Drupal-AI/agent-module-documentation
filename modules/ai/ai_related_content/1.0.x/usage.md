AI Related Content provides a configurable Views block that surfaces related/recommended content by semantic (vector) similarity to the current node, using the AI Search submodule of the drupal/ai project.

---

The module attaches three Search API Views plugins — a filter, a contextual argument, and a results-cache plugin — to any AI-Search-backed index, plus a helper form that scaffolds the ready-made view. Given the current node as the contextual argument, the filter finds the most similar content: it either reuses an already-indexed embedding vector for that node (retrieved from a chosen vector database and average-pooled across chunks) or, in the default mode, renders the node in a selected view mode and generates a fresh embedding on demand through the drupal/ai abstraction. The current node is excluded from its own results, and Search API's post-query per-result access check keeps unpublished or access-restricted nodes out. Because LLM vector search has a per-call cost, the project is built around caching: the generated view uses time-and-tag caching keyed by node grants and the source node, a custom cache plugin stores only entity ids (not raw vectors) per row, and rendered output is invalidated when the source node changes. Site builders control the view mode, the source-vector index (or on-demand generation), the number of items, and the display view mode by editing the view like any other.

---

- Add a "related content" / "you might also like" block to node pages driven by semantic similarity rather than shared taxonomy terms.
- Recommend content across content types using vector embeddings from an AI Search index.
- Scaffold the ready-to-use view automatically from /admin/config/ai/ai-related-content-setup for a chosen compatible index.
- Reset the generated view back to the shipped template when configuration drifts.
- Place the related-content block via the Block UI, or render it in a node template with Twig Tweak (`{{ drupal_view('ai_related_content', 'default_block') }}`).
- Exclude the current node from its own related-content list (requires an indexed `nid` set as a Filterable Attribute).
- Reuse already-generated embedding vectors from a chosen source index to avoid paying for new embeddings on each view.
- Average-pool multiple chunk vectors for a node so related content reflects the whole item, not one chunk.
- Fall back to on-demand embedding generation (opt-in) when a source index has no vector for the node.
- Always generate fresh vectors on demand (default) when you have not set up a dedicated source-vector index.
- Curate which text feeds the similarity search by choosing the node view mode used to render the source content.
- Control how many related items appear and which display view mode renders them by editing the view.
- Keep LLM/embedding costs down with time-and-tag results caching that survives across page views.
- Cache related content per node and per node-grant context so different users and nodes get correct, cache-safe results.
- Avoid storing raw embedding vectors in the Views results cache by using the entity-id-only cache plugin.
- Automatically invalidate a node's cached related content when that node is edited.
- Get proactive configuration warnings on the Views edit page (missing `nid` Filterable Attribute, missing contextual filter, source index without raw embedding vectors enabled).
- Preview related content for a specific node in the Views UI by entering its node ID as a contextual filter argument.
- Restrict who can run the setup/reset form with the dedicated "administer AI Related Content" permission.
- Work with any AI Search vector-database backend (Postgres, MariaDB, Milvus, Pinecone, and others) that extends the AI Search backend base.
- Combine a large-chunk "whole node" source index for finding related content with a finely chunked index for normal search.
