# Zhipuai Provider — manual setup guide

**Zhipuai Provider** (`ai_provider_zhipuai`) registers **Zhipu AI** (the GLM
family of models) as a provider for Drupal's AI module. Once it is installed and
given an API credential, Zhipu's models appear in the same provider choices that
the rest of your AI‑powered site uses — so any feature built on the AI framework
(chat assistants, content tools, search) can send its requests to Zhipu.

The module has no front‑end feature of its own. It is the adapter between
Drupal's AI abstraction and Zhipu's cloud API: you install it, store your Zhipu
key securely, and then pick Zhipu wherever a provider is offered. It supports
chat and related AI operations.

The API credential is stored through the **Key** module (backed by an
environment variable), so the secret never sits in plain configuration. When a
feature uses this provider, the prompt content is sent to Zhipu — that carries a
usage cost and means your content leaves your server.

**Data‑residency note:** Zhipu AI is a **non‑US cloud service (China)**. Prompts
and content routed through this provider are transmitted to Zhipu's servers.
Confirm that sending your content to that provider is acceptable under your
organisation's privacy and compliance rules before using it with real content.

This guide is written for a **human** setting the provider up through the admin
UI and the command line. If you want a terse, token‑cheap reference for an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and store your Zhipu credential as a Key.

## How to use it

There is no standalone settings page for this module. You use it in three steps:

1. **Store your Zhipu credential** as a Key (see
   [Installation](installation/index.md)).
2. **Select and configure the provider.** Zhipu now appears as a provider in the
   AI module's provider administration (under **Configuration →** the **AI**
   section). Attach the Key you created and choose which Zhipu/GLM model handles
   each type of request.
3. **Point a feature at it.** In any AI‑powered feature, pick Zhipu (or set it as
   a default provider for an operation such as *chat*) and that feature's calls
   go to Zhipu.
