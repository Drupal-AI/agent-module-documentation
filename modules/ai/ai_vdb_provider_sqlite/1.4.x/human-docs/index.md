# SQLite VDB Provider — manual setup guide

**SQLite VDB Provider** (`ai_vdb_provider_sqlite`) lets Drupal's AI module keep
its vectors in a local **SQLite** database using the
[`sqlite-vec`](https://github.com/asg017/sqlite-vec) extension, instead of
running a separate vector‑database service. The AI module turns your content into
embeddings; this module gives it a lightweight place to store and query them, so
retrieval‑augmented generation (RAG) and semantic search work without you having
to install and operate something like Qdrant, Milvus, or a cloud vector store.

Because the store is an embedded SQLite file rather than a network service, there
are **no credentials, host, or endpoint to configure** — which makes it a good
fit for local development, small sites, or a quick proof of concept before
committing to a heavier backend. It is marked **experimental**, so treat it
accordingly on production sites.

Like any vector store, it holds embeddings derived from your content. When you
build search on top of it, make sure that search **respects content access** —
don't let semantic search surface restricted content to users who shouldn't see
it. The module itself has no access‑control role; that responsibility lives with
how you configure AI Search.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the SQLite vector‑store settings
   form, and selecting it for an AI Search index.

## Where it lives in the admin menu

The provider's own settings form is registered at
`ai_vdb_provider_sqlite.settings_form`, reached under the AI module's
configuration (**Configuration → AI**). You then select "SQLite" as the
vector‑database backend when creating an **AI Search** index.

## How to use it

1. Enable the module (it needs the AI module and its search stack).
2. Open the SQLite VDB provider settings and confirm the local store details.
3. Create an AI Search index and choose the SQLite VDB provider.
4. Index your content and run semantic / RAG queries — the vectors live in a
   local SQLite database.
