# AI RAG Assistant — manual setup guide

**AI RAG Assistant** (`ai_rag_assistant`) adds an **AI chatbot that answers from
your own site content** using Retrieval‑Augmented Generation (RAG). Instead of
answering purely from an LLM's general knowledge, it first *retrieves* relevant
passages from your site and then feeds them to the AI provider as context — so
the chatbot's replies are grounded in what your site actually says.

The module builds on Drupal's **AI** module and works over your node content. A
visitor asks a question, the assistant finds the most relevant material, and the
configured AI provider composes an answer from it.

Because it is an AI feature, two things are worth knowing before you rely on it.
The content and the visitor's questions are **sent to the configured AI
provider** — external egress you should confirm is acceptable for your content.
And the provider's **API key is stored through the AI module's Key
configuration** as a secret, never in plain config. The module has no
access‑control role of its own beyond the permission it provides.

This guide is written for a **human**. If you want a terse, token‑cheap
reference for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

1. **Install and enable** the module (see [Installation](installation/index.md)).
2. **Set up an AI provider** in the AI module and store its API key as a Key —
   this is what the assistant calls to generate answers.
3. **Grant the assistant's permission** at **People → Permissions** to the roles
   that should be able to use the chatbot.
4. **Expose the chatbot** to visitors (for example by placing its block or using
   the page it provides) and ask a question — the answer is drawn from your
   indexed site content.
