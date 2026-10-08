# amazee.ai AI Provider — manual setup guide

**amazee.ai AI Provider** (`ai_provider_amazeeio`) plugs **amazee.ai** into
Drupal's **AI** (AI Core) module. It registers amazee.ai as an AI provider so
Drupal can call amazee.ai's private, data-sovereign LLM gateway for chat and
embeddings — and, unusually for an AI provider, it also ships a Postgres/pgvector
**vector-database** provider so you can store your embeddings in-region too.

Once configured, amazee.ai becomes available anywhere AI Core needs chat/text
generation or embeddings: the AI Chatbot, AI CKEditor, automators, agents, and
Search API RAG. The provider supports the full range of chat operation types
(plain chat, complex JSON, image/vision, structured responses, and tool/function
calling) plus embeddings. You never call it directly from code — you go through
AI Core's provider service, so vendor choice stays config-driven and you can run
amazee.ai alongside OpenAI or Anthropic and switch or fail over between them.

Authentication is different from most providers: instead of pasting an API key,
you use a multi-step **amazee.ai AI Authentication** form. It starts an anonymous
free trial or verifies your email against amazee.ai's management API, then
provisions an LLM key and a VectorDB key and writes them into two auto-created
**Key** entities — so the raw secrets stay out of your config export. On connect
it also records the resolved LLM endpoint and the Postgres connection details for
the vector database.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (AI Core and Key are required).
2. [Configuration](configuration/index.md) — the amazee.ai Authentication form
   step by step, the Key entities, the vector-database settings, and making
   amazee.ai your site default.

## Where it lives in the admin menu

- **Authentication / settings:** **Configuration → AI → AI Providers → amazee.ai
  Authentication** (`/admin/config/ai/providers/amazeeio`), gated by the
  **Administer AI providers** permission (defined by AI Core).
- **Keys:** the two provisioned Key entities are managed at **Configuration →
  System → Keys** (`/admin/config/system/keys`).
- **Site-wide default provider:** chosen at AI Core's own settings,
  **Configuration → AI → Settings** (`/admin/config/ai/settings`).

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to **Configuration → AI → AI Providers → amazee.ai Authentication** and
   walk through the connect flow — enter an email (or take the anonymous free
   trial), verify, pick or create a private key, and connect. See
   [Configuration](configuration/index.md) for the details.
3. Once connected, amazee.ai is seeded as a default provider for chat and
   embeddings where none was set. Confirm or change the defaults at
   **Configuration → AI → Settings**.
4. Use any AI Core feature (chatbot, CKEditor AI, automators, RAG) — it now runs
   through amazee.ai.
