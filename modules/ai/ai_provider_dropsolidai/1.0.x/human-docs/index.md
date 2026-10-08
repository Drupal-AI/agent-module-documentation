# AI Provider Dropsolid AI — manual setup guide

**AI Provider Dropsolid AI** (`ai_provider_dropsolidai`) connects Drupal's AI
module to **Dropsolid's hosted AI** service. Dropsolid exposes its AI through a
**LiteLLM** proxy — a layer that presents many upstream models behind one
consistent, OpenAI-style API — and this module builds on the separate **AI
Provider LiteLLM** module to talk to it. Once configured, Dropsolid AI becomes a
selectable provider wherever the AI module offers a provider choice.

In practice you point the provider at the Dropsolid AI endpoint and authenticate
with an API key. Because it runs over the LiteLLM layer, the models you can reach
are those Dropsolid makes available through that endpoint.

The usual provider considerations apply: the API key is a real credential and
should be stored via Key/env over HTTPS rather than in exported configuration, and
prompt content is sent to the Dropsolid endpoint — external egress that you should
confirm is acceptable for the content involved. The module has no access-control
role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module with its AI and LiteLLM dependencies.
2. [Configuration](configuration/index.md) — set the Dropsolid endpoint, supply
   the API key securely, and choose it for AI operations.

## Where it lives in the admin menu

The AI module groups its settings under **Configuration → AI**
(`/admin/config/ai`). Installed providers, including Dropsolid AI, are configured
from the **Providers** area under that section (`/admin/config/ai/providers`).

## How to use it

Obtain your Dropsolid AI endpoint and API key, enable this module (which brings in
AI Provider LiteLLM), store the key as a Key entity, and register Dropsolid AI on
the AI providers page with the endpoint URL. Then select it for the operations you
want on the AI default-provider settings. This is an **alpha** release; requires
Drupal 10 or 11.
