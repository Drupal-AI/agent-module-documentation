# Cloudflare Vectorize VDB Provider — manual setup guide

**Cloudflare Vectorize VDB Provider** (`ai_vdb_provider_vectorize`) plugs
**[Cloudflare Vectorize](https://developers.cloudflare.com/vectorize/)** into the
Drupal AI module's Search API integration as a vector‑database (VDB) backend. The
AI module turns your content into embeddings; this module keeps those embeddings
in Cloudflare's Vectorize service, at the edge, so semantic search and
retrieval‑augmented generation (RAG) run their similarity queries there instead
of against a self‑hosted vector store.

Under the hood it exposes a `CloudflareVectorize` VDB provider plugin that the AI
Search stack uses to create indexes, insert and delete vectors, and run
similarity queries, plus a `VectorizeMapper` that translates Search API fields
into Vectorize metadata. Cloudflare account and index settings are entered on the
provider's settings form; the actual **credentials are handled by the underlying
`cloudflare_*` SDK modules**, not stored by this module directly.

Reach for it when you want Drupal semantic search whose vector index lives at the
Cloudflare edge alongside other Cloudflare AI services, rather than running your
own vector database. The admin settings route is gated on the
`administer ai providers` permission, and the module exposes no anonymous or
mutating public endpoints.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Cloudflare
   dependency stack with Composer, then enable it.
2. [Configuration](configuration/index.md) — connect Cloudflare, set the
   Vectorize index details, and select it for an AI Search index.

## Where it lives in the admin menu

The provider settings form lives at **Configuration → AI → Vector DB Providers →
Vectorize** (`/admin/config/ai/vdb_providers/vectorize`), gated on the
`administer ai providers` permission. You then choose the Cloudflare Vectorize
provider when creating an **AI Search** index.

## How to use it

1. Set up Cloudflare account and API access through the `cloudflare_*` modules.
2. Configure the Vectorize provider (index / namespace details) on its settings
   form.
3. Create a Search API server/index and pick the Cloudflare Vectorize VDB
   provider.
4. Index your content, then run semantic / RAG queries through AI Search.
