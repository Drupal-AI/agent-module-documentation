# Qdrant VDB Provider — manual setup guide

**Qdrant VDB Provider** (`ai_vdb_provider_qdrant`) lets Drupal's AI module store
and search its vectors in **[Qdrant](https://qdrant.tech/)**, an open‑source
vector database. On its own the AI module knows how to turn your content into
embeddings; it needs somewhere to keep those embeddings so it can find the
closest matches at query time. This module is that "somewhere" — it registers
Qdrant as a **vector‑database (VDB) provider** that the AI Search stack can pick,
so features such as retrieval‑augmented generation (RAG) and semantic search run
their similarity queries against a Qdrant instance you point it at.

You can run Qdrant as a managed cloud service or self‑host it on your own
infrastructure. Self‑hosting keeps your indexed content and its embeddings inside
your own network; the managed cloud sends that data to Qdrant's servers. Either
way the module talks to Qdrant over the network using an **API key**, and it
integrates with the **Key module** so that key is stored as a secret (from an
environment variable) rather than in plain configuration.

It is a piece of AI infrastructure, not a user‑facing feature: it adds no blocks,
no content, and no access‑control rules. It only becomes useful once the AI and
AI Search modules are installed and you build a Search API index on top of it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies with Composer, then enable it.
2. [Configuration](configuration/index.md) — point the provider at your Qdrant
   endpoint, store the API key as a Key, and select it when building an AI Search
   index.

## Where it lives in the admin menu

The provider is configured alongside the AI module's other vector‑database
providers under **Configuration → AI** (the AI module groups its vector‑DB
providers there). You then choose "Qdrant" as the backend when you create an
**AI Search** server/index. There is no separate top‑level menu item of its own.

## How to use it

1. Stand up a Qdrant instance (self‑hosted or cloud) and note its HTTPS endpoint
   and API key.
2. Store the API key as a **Key** (env‑backed) — see the configuration guide.
3. Point the Qdrant provider at your endpoint and key.
4. Create an AI Search index and select the Qdrant VDB provider as its backend.
5. Index your content, then run semantic / RAG queries through AI Search.
