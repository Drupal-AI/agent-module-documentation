# OpenRouter Provider — manual setup guide

**OpenRouter Provider** (`ai_provider_openrouter`) connects Drupal's
[AI module](https://www.drupal.org/project/ai) to
[OpenRouter](https://openrouter.ai/), giving your site access to **many models
through one API and one key**. OpenRouter is itself an aggregator: a single
account reaches models from OpenAI, Anthropic, Google, Meta and others, with
per‑request routing and fallback when a provider is unavailable.

The AI module abstracts providers so you write an AI feature once and point it at
whichever service you choose; OpenRouter is a particularly useful thing to point
it at when you want to **compare models**, use different models for different
tasks, or avoid committing to a single vendor's contract. The trade‑off is a layer
of indirection — OpenRouter sees every prompt and response as it passes through.

It depends on the AI module and the **Key** module (the API key comes from a Key
entity, so it never reaches exported configuration), and defines an
access‑restricted `administer ai providers` permission. Note the **unusually tight
core requirement, `^10.5 || ^11.2`** — check your Drupal version before installing
(version 1.1.6).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the AI
   and Key requirements (mind the tight core range), and enable the module.
2. [Configuration](configuration/index.md) — register OpenRouter on the AI
   settings and supply your key through a Key entity.

## Where it lives in the admin menu

Provider configuration lives in the AI module's settings area under
**Configuration → AI → Providers** (`/admin/config/ai/providers`), where
OpenRouter appears once enabled. The API key is a **Key** entity, managed at
**Configuration → System → Keys** (`/admin/config/system/keys`).

## How to use it

Enable the module, store your OpenRouter key in a Key, select that Key on the
OpenRouter provider settings, then choose OpenRouter — and any of the many models
it exposes — as the provider for the AI operations you want it to power.
