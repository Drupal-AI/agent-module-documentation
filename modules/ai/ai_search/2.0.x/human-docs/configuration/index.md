# Configuration

AI Search is configured through **Search API**, not a settings page of its own. The
work is: pick an embeddings provider, create a Search API server that uses the AI
Search backend, create an index, and then verify access control.

## 1. Make sure an embeddings provider is ready

In the AI module, confirm you have a provider configured that offers **embeddings**
— either a hosted one (which sends content out to be embedded, at a per-item and
per-query cost) or a local one such as Ollama (which keeps content on your
infrastructure). AI Search uses this provider to turn content and queries into
vectors.

## 2. Create an AI Search server

1. Go to **Configuration → Search and metadata → Search API**
   (`/admin/config/search/search-api`).
2. Click **Add server**.
3. Give it a name, and choose the **AI Search** backend.
4. In the backend settings, select the **embeddings provider / model** and the
   **vector database** the server should use.
5. Save.

## 3. Create and populate an index

1. From the Search API page, click **Add index**.
2. Choose the content (for example the **Content** / node datasource) you want to
   be searchable and attach it to your AI Search server.
3. Add the fields to index.
4. Save, then run indexing (via the UI or `drush search-api:index`). Each item is
   embedded at this point — on a large site this is where the embedding cost is
   incurred, so estimate it first.

## 4. Verify access control (do not skip this)

A vector index returns nearest neighbours regardless of who is asking. Ensuring
restricted or unpublished content does not surface depends on **Search API's access
handling being applied and verified** — not on the backend. Test explicitly: index
a restricted item, then search as an anonymous or low-permission user and confirm
it does **not** appear.

## 5. Use the index

Point a search page, a view, or an AI assistant's retrieval step at the index. For
RAG, this index is what the assistant queries to find relevant passages before it
generates an answer.
