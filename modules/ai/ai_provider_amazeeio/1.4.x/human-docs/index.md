# amazee.ai AI Provider — manual setup guide

**amazee.ai AI Provider** (`ai_provider_amazeeio`) plugs the
[amazee.ai](https://www.amazee.ai) private AI service into Drupal's **AI** module
ecosystem. It's a provider plugin: once configured, it makes amazee.ai's large
language models available to the AI module for chat, embeddings, text-to-image, and
text translation — and, uniquely among Drupal AI providers, it also provisions a
**vector database** (Postgres/pgvector) for you, enabling semantic search and
retrieval-augmented generation out of the box.

amazee.ai's pitch is privacy-first, data-sovereign AI: you choose the region where
your AI workloads and data are hosted (Germany, UK, Switzerland, US, Australia, and
more on request). It can be used **free for the first 30 days with no credit card**,
after which it's a paid subscription (tiers start around $15/month).

Setup is unusual for an AI provider: there is **no "paste your API key" field**.
Instead the settings form walks you through a small signup/verification flow —
enter an email, confirm a verification code, then pick or create an amazee.ai
private key — and the module writes the resulting credentials into **Key** entities
for you. Because of that, this module **requires the AI module and the Key module**
(and, for the vector database features, the PHP PostgreSQL PDO extension and Search
API).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, meet the AI/Key
   requirements, and enable the module.
2. [Configuration](configuration/index.md) — the connect/signup flow, the dashboard,
   and making amazee.ai your default AI provider.

## Where it lives in the admin menu

The provider's settings form is at **Configuration → AI → AI Providers →
amazee.ai** (`/admin/config/ai/providers/amazeeio`, route
`ai_provider_amazeeio.settings_form`), gated by the **Administer AI providers**
permission (defined by the AI module). It sits alongside the other AI provider
settings.

## How to use it

Connect the provider through its settings form (the guided flow below), which seeds
the AI module's default provider/model choices. From then on, any AI-module feature
can use amazee.ai's models, and its provisioned vector database is available for AI
Search / semantic search. A cost note: this is a paid, metered service after the
free trial — every chat, embedding, and image call consumes your amazee.ai
allowance.
