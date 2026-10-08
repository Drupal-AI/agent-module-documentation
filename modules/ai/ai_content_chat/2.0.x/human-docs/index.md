# AI Content Chat — manual setup guide

**AI Content Chat** (`ai_content_chat`) provides an AI chatbot that answers
questions **grounded in your own website content**. It indexes your site's content
and then answers visitors' questions from that index (a retrieval‑augmented, or
"RAG", approach) using the [AI](https://www.drupal.org/project/ai) module — so
answers stay tied to what your site actually says rather than the model's general
knowledge.

It ships with a **block** for placing the chat widget wherever you want it, and an
**ask** API endpoint that the widget uses to get answers. Answers run through your
configured AI provider, so each question incurs a per‑request cost.

Access is controlled. The ask endpoint is **not** open to anonymous visitors by
default — it is gated by a *use* permission — and reindexing and administration
are gated by an *administer* permission. That means you decide who can chat and
who can manage the index.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm an AI provider is configured.
2. [Configuration](configuration/index.md) — permissions, placing the chat block,
   the ask endpoint, and reindexing your content.

## Where it lives in the admin menu

Administration and reindexing are gated by the **Administer AI content chat**
permission (`administer ai content chat`); using the chatbot is gated by **Use AI
content chat** (`use ai content chat`). The chat widget itself is placed through
Drupal's **Block layout** (`/admin/structure/block`). See
[Configuration](configuration/index.md) for the details.

Depends on core **Block** and the **AI** module (`ai`). Works on Drupal 10 and 11.
