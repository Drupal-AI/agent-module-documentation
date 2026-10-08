# AI Search - Semantic Chunking — manual setup guide

**AI Search - Semantic Chunking** (`ai_search_sc`) adds an alternative **chunking
strategy** to [AI Search](https://www.drupal.org/project/ai_search). Before content
can be embedded and indexed for semantic search, it has to be split into smaller
pieces ("chunks"). AI Search's default chunker splits text into fixed
token-length windows; this module instead groups **semantically related
sentences** using embedding similarity, so each chunk is a coherent unit of meaning
rather than an arbitrary slice.

Better-scoped chunks tend to produce better retrieval — and, for
retrieval-augmented generation (RAG), better-grounded answers. It is designed as a
**drop-in replacement** for the default chunker: you select it as the chunking
strategy on an AI Search index, with no other change to how AI Search works.

One cost to note: it computes embeddings while it decides where to split, so
**indexing incurs embedding cost** (through your AI provider) on top of the
embedding already done to index each chunk.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside AI Search.

## Where it lives in the admin menu

This module has **no settings page of its own**. It adds a *semantic chunking*
option that appears wherever AI Search lets you choose a chunking strategy — on the
AI Search backend/index configuration under **Configuration → Search and metadata →
Search API** (`/admin/config/search/search-api`). It also defines its own
permission, managed at **People → Permissions**.

## How to use it

With [AI Search](https://www.drupal.org/project/ai_search) already set up, enable
this module, then edit your AI Search server or index configuration and select
**semantic chunking** as the chunking strategy in place of the default token-based
one. Reindex so existing content is re-chunked with the new strategy. Because
splitting now uses embeddings, expect additional embedding calls during indexing.
