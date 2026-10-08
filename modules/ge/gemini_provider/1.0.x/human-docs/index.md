# Gemini Provider — manual setup guide

**Gemini Provider** (`gemini_provider`) lets Drupal's **AI** module talk to
**Google Gemini**. The AI module provides a common way for Drupal features to use
large language models — chat, embeddings, image and audio generation — without
caring which company's model sits behind them. This module plugs Google Gemini in
as one of those providers, so any AI-powered feature on your site can run on
Gemini.

Once installed and given an API key, Gemini becomes available for a range of
operations: **chat** (including vision, tools, and structured JSON responses),
**embeddings** (turning text into vectors for search and similarity),
**text-to-image**, **text-to-speech**, and **speech-to-text**. The default chat
model is `gemini-2.5-flash` and the default embeddings model is
`gemini-embedding-001`, but the AI module lets you choose which provider and model
handle each kind of task.

Credentials are handled the secure Drupal way, through the **Key** module. You
don't paste your Gemini API key into a settings field — instead you store the
secret (ideally in an environment variable), wrap it in a Key entity, and point
Gemini Provider at that Key. The module also exposes Google's **safety settings**,
so you can set content-filtering thresholds per harm category.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its AI / Key
   dependencies with Composer and enable it.
2. [Configuration](configuration/index.md) — create the API-key Key entity, select
   it on the settings form, and tune the safety settings.

## Where it lives in the admin menu

The provider's settings form sits alongside the other AI providers at
**Configuration → AI → Providers → Gemini**
(`/admin/config/ai/providers/gemini`). Access is gated by the AI module's
**Administer AI providers** permission (this module ships no permissions of its
own). The API-key Key entity you'll create lives under **Configuration → System →
Keys** (`/admin/config/system/keys`).
