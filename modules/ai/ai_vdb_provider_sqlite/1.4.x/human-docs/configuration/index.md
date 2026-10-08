# Configuration

Unlike network‑based vector databases, SQLite VDB Provider needs **no host, port,
or API key** — the vector store is a local SQLite database. Configuration is
therefore short: confirm the store settings, then select the provider for an AI
Search index.

## Open the settings form

The provider registers a settings form at `ai_vdb_provider_sqlite.settings_form`,
reached under **Configuration → AI** (the AI module's provider settings). Open it
to review the local SQLite vector‑store options the form exposes.

## Use it for an AI Search index

1. Go to your AI Search / Search API server configuration.
2. Choose the **SQLite** vector‑database provider for the index.
3. Add your content to the index and let it build embeddings into the local
   SQLite store.
4. Run semantic or RAG queries through AI Search.

## Keep search access‑aware

The store holds embeddings of your content, including content that may be
restricted. When you configure AI Search on top of it, make sure results
**respect content access** so semantic search does not surface restricted content
to users who should not see it. The module has no access‑control role of its own —
this is governed by your AI Search configuration.
