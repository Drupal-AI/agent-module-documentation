# Pinecone Serverless VDB Provider — manual setup guide

**Pinecone Serverless VDB Provider** (`ai_vdb_provider_pinecone`) plugs
[Pinecone](https://www.pinecone.io/) — a managed, serverless vector database — into Drupal's
[AI](https://www.drupal.org/project/ai) module as a backend for **AI Search**. Once
configured, the embeddings generated for your content are stored in and queried from a
Pinecone index instead of a local or self-hosted vector store, which is handy if you'd rather
not run Milvus (or similar) yourself. This powers semantic similarity search, "related
content" features, and RAG-style chatbots that ground their answers in your Drupal content.

The module itself is small and focused: it registers a `pinecone` vector-database provider
for the AI module and wraps the Pinecone PHP SDK so AI Search can create and describe
indexes, upsert vectors into a namespace, query by vector with metadata filters, fetch and
delete vectors, and read index statistics. The actual embedding, chunking and search UX come
from the `ai`, `ai_search` and `search_api` modules — this provider is only the Pinecone
connection.

Its one piece of configuration is the **API key**, and it is handled the safe way: the
settings form stores only the **name of a Key entity** (from the Key module), never the raw
secret. The key value is resolved at runtime, and the form validates your credentials by
listing your Pinecone indexes when you save. This is an **experimental** provider in the AI
ecosystem.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its dependencies with
   Composer, and enable them.
2. [Configuration](configuration/index.md) — store the Pinecone API key as a Key entity,
   connect the settings form, and select Pinecone on an AI Search index.

## Where it lives in the admin menu

The settings form sits at **Configuration → AI → VDB Providers → Pinecone**
(`/admin/config/ai/vdb_providers/pinecone`), gated by the **Administer AI providers**
permission (provided by the AI module). The module adds no permissions of its own.
