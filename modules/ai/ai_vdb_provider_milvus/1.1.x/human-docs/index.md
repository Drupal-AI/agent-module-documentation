# Milvus/Zilliz VDB Provider — manual setup guide

**Milvus/Zilliz VDB Provider** (`ai_vdb_provider_milvus`) connects Drupal's **AI**
module to a [Milvus](https://milvus.io/) vector database — either a self-hosted
Milvus instance or the managed **Zilliz Cloud** service. Once configured, the AI
**Search** module (and other AI features) can store and query text embeddings in
Milvus: creating collections, inserting vectors, and running similarity searches.
That makes it a storage backend for semantic search and Retrieval-Augmented
Generation (RAG) pipelines built on Drupal AI.

Concretely, the module registers a `milvus` vector-database provider that the AI
ecosystem discovers automatically, backed by a small HTTP client that talks to the
Milvus v2 REST API. You configure the connection once — a server URL, a port, and
(optionally) an authentication key — and then choose this provider as the vector
store when you set up an AI Search server/index. The embedding generation and
indexing themselves are driven by the `ai` / `ai_search` modules; this module just
supplies the place the vectors live.

> **Credentials.** The connection can authenticate with a key: for a self-hosted
> Milvus this is a `username:password` credential, and for Zilliz Cloud it's your
> API token. You store it as a **Key** entity (from the Key module), so the secret
> can live in an environment variable or file rather than in exported config. A
> local, unauthenticated Milvus can be used with no key at all.

The module is marked **experimental**. It also automatically migrates settings
from the older in-tree Milvus submodule if you were using that.

This guide is written for a **human** using the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (with AI, AI Search,
   and Key) and enable it.
2. [Configuration](configuration/index.md) — the connection settings, the Key
   credential, and a local Milvus with DDEV.

## Where it lives in the admin menu

The connection settings are at **Configuration → AI → Vector Database Providers →
Milvus** (`/admin/config/ai/vdb_providers/milvus`).
