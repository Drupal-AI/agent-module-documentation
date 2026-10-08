# OpenAI Provider — manual setup guide

**OpenAI Provider** (`ai_provider_openai`) is the OpenAI plugin for the
[AI (AI Core)](https://www.drupal.org/project/ai) module. It teaches Drupal how
to talk to OpenAI — and to OpenAI‑compatible or Azure OpenAI endpoints — so the
rest of your AI‑powered features can use OpenAI models for chat, embeddings,
moderation, image generation, text‑to‑speech, and speech‑to‑text.

It works by registering a single `openai` **AI provider** that adapts OpenAI's
REST API to the operation types AI Core defines. Six operation types are
supported: **chat**, **embeddings**, **moderation**, **text_to_image**,
**text_to_speech**, and **speech_to_text**. You never call this provider directly
— your code and other modules go through AI Core's provider service, so the choice
of vendor stays configuration‑driven and swappable.

Authentication is handled through the **Key** module: you select a Key entity that
holds your OpenAI API key, and only the Key's id is stored in configuration — the
raw secret is never written to plain config. An optional **host** setting repoints
every request at an OpenAI‑compatible service (such as LocalAI or LM Studio) or an
Azure OpenAI deployment. Text calls are **moderation‑gated by default**: each
prompt is checked against `omni-moderation-latest` first and blocked if it's
flagged (you can bypass this per call or turn it off). The provider also supports
the richer features editors and developers expect — system prompts, image/PDF
inputs to vision models, streaming responses, tool/function calling, structured
JSON responses, and per‑model tuning. When you save your key, it seeds sensible
AI Core defaults (for example chat → `gpt-5.2`, embeddings →
`text-embedding-3-small`, moderation → `omni-moderation-latest`).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module, AI Core, and Key.
2. [Configuration](configuration/index.md) — create a Key for your API key, fill
   in the settings form, optionally set a custom host, and make OpenAI the site
   default provider.

## Where it lives in the admin menu

The provider's settings form is at **Configuration → AI → AI Providers → OpenAI
Authentication** (`/admin/config/ai/providers/openai`). Which provider/model is
used for each operation is chosen at AI Core's own settings at
**Configuration → AI → AI settings** (`/admin/config/ai/settings`). Access is
gated by the **Administer AI providers** permission (defined by AI Core).

## How to use it

1. Install AI Core, Key, and this module (see
   [Installation](installation/index.md)).
2. Create a **Key** entity holding your OpenAI API key.
3. Open the **OpenAI Authentication** settings form and select that Key.
4. On save, the module verifies the key against OpenAI and seeds default models
   for each operation type.
5. Confirm or change the site‑wide default provider per operation on AI Core's
   AI settings page.
