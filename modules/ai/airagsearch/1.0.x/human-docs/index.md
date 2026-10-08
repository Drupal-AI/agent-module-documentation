# AI RAG Search — manual setup guide

**AI RAG Search** (`airagsearch`) makes site search return *answers* instead of
just result lists. It combines an AI chat model (such as ChatGPT) with Search API
in a retrieval‑augmented generation (RAG) pattern: it retrieves the most relevant
indexed content for a question, then asks the AI to answer using that content as
grounding. The result is a contextual answer backed by your own site's material
rather than a plain list of links.

It builds on Search API for the retrieval side and calls the AI chat model
through the configured provider, which carries that provider's per‑call cost.
Grounding the answer in retrieved content is what keeps it relevant to your site
and reduces the model inventing things — but the quality of the answers still
depends on how well your Search API index is built.

Access is controlled by two permissions: one for administering the search
settings and one for using the search API the module exposes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The feature is gated by two permissions (set under **People → Permissions**):
`administer ai search settings` for configuration and `access ai search api` for
using the search. Retrieval is configured through your **Search API** index, and
the AI chat model is configured in the AI provider layer.

## How to use it

1. Build a **Search API** index over the content you want the answers grounded
   in.
2. Make sure an AI chat provider/model is available.
3. Enable AI RAG Search and grant:
   - `administer ai search settings` — to administrators who configure it.
   - `access ai search api` — to the users/roles who may query.
4. Ask questions through the search; the module retrieves relevant content and
   returns an AI answer grounded in it.

> **Cost:** each query calls your AI provider and incurs that provider's per‑call
> cost.
