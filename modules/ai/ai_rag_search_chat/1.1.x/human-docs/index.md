# AI RAG Search Chat — manual setup guide

**AI RAG Search Chat** (`ai_rag_search_chat`) adds two front-end features that
answer questions from **your own site content**: an AI search page at
`/ai-search` and a conversational chat at `/ai-search/chat`. Both use
Retrieval-Augmented Generation (RAG) — the module retrieves the most relevant
passages from your Search API index, hands them to an AI provider as context,
and returns an answer with source citations rather than a guess from the LLM's
general knowledge.

Under the hood it queries your configured **Search API** indices for the
best-matching content chunks, packs them into a token budget (optionally adding a
keyword search), and calls the LLM through Drupal's **AI** provider system. Chat
sessions and messages are stored in the site's database so a conversation has
history. Anonymous visitors are supported through a secure cookie, and built-in
rate limiting (on by default) throttles how many messages and sessions each
visitor can create so the LLM cannot be run up as a cost.

Because it is an AI feature, questions and the matched content are **sent to your
configured AI provider** (confirm that egress is acceptable). No API keys are
stored by this module — provider credentials are delegated to the AI and Key
modules. It provides two permissions: one to *use* the search/chat, one to
*administer* it.

> **Access reminder.** Grant the **Access AI RAG search chat** permission to the
> roles that should use the feature (grant it to Anonymous only if you want
> unauthenticated visitors to use it), and keep **rate limiting enabled** so the
> AI-provider-billed endpoints stay throttled. Retrieved content and rendered
> sources respect each user's view access to the underlying entities. See the
> sibling [`agent/`](../agent/start.md) docs for the full detail.

This guide is written for a **human**. If you want a terse, token-cheap
reference for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and wire up its dependencies.
2. [Configuration](configuration/index.md) — the settings form: which indices to
   search, the LLM provider/model, the system prompt, retrieval tuning, history
   retention, and rate limits.

## Where it lives in the admin menu

The settings form sits at **Configuration → AI → AI RAG Search Chat**
(`/admin/config/ai/ai-rag-search-chat`) and requires the *Administer AI RAG
search chat* permission. The visitor-facing features live at `/ai-search` and
`/ai-search/chat`.
