# FlowDrop AI Search — manual setup guide

**FlowDrop AI Search** (`flowdrop_ai_search`) connects **FlowDrop**, the visual
workflow editor, to Drupal's **AI Search** and vector‑database stack. It adds FlowDrop
node processors for vector similarity search and Retrieval Augmented Generation (RAG),
plus a dedicated **AI Search** category in the FlowDrop editor sidebar so retrieval and
vector nodes are grouped together.

The centrepiece is a **VDB Search** node that runs semantic similarity searches
against a vector database. It supports two backend modes — Search API‑powered
retrieval, or direct vector‑database queries — and exposes the search query as a
FlowDrop input port, so a query can come from chat, plain text, or an AI‑generated
value earlier in the flow. To keep flows fast and cheap, it can reuse embeddings
already computed upstream instead of re‑embedding the same text. For agent‑driven
retrieval it can automatically discover compatible `ai_search:*` tools, configure them
for your chosen search indexes, and build the `tool_usage_limits` configuration that an
AI Agent Executor node expects. It works with the Drupal AI ecosystem's vector
database providers — Milvus, Pinecone, Postgres, and others.

This is an integration module with **no settings page of its own**. Your search
indexes and vector‑database backends are configured in Search API and the AI Search
module, and the retrieval nodes are placed and configured inside the FlowDrop editor.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module
   with its FlowDrop, AI, AI Search, and Search API dependencies.

There is **no configuration page** for this module. Configure your indexes and vector
backends in [Search API](https://www.drupal.org/project/search_api) and the
[AI](https://www.drupal.org/project/ai) module's AI Search submodule, then build
retrieval flows in the [FlowDrop](https://www.drupal.org/project/flowdrop) editor.

## How to use it

1. Enable the module (see [Installation](installation/index.md)) and set up a Search
   API index backed by a vector database provider in the AI Search stack.
2. Open a workflow in the FlowDrop editor and find the **AI Search** category in the
   sidebar.
3. Add a **VDB Search** node, choose a backend mode (Search API or direct vector
   query), pick the index, and connect the query input to an upstream chat/text/AI
   node.
4. Feed the retrieved results into your AI nodes to build a RAG pipeline, reusing
   upstream embeddings where possible to reduce latency and API cost.

> **Cost note.** Embedding and retrieval run through the configured AI provider, which
> usually bills per token. Reuse embeddings where you can, and set provider‑side spend
> limits — see [FlowDrop AI Provider](https://www.drupal.org/project/flowdrop_ai_provider).
