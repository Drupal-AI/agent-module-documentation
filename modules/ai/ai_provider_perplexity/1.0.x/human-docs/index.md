# Perplexity AI Provider — manual setup guide

**Perplexity AI Provider** (project `ai_provider_perplexity`, **machine name
`ai_perplexity`**) connects Drupal's
[AI module](https://www.drupal.org/project/ai) to
[Perplexity AI](https://www.perplexity.ai/), so AI operations — including
Perplexity's answer‑ and search‑augmented models — can be routed to Perplexity
anywhere the AI module offers a provider choice.

> **Heads‑up — the machine name does not match the project name.** The Drupal
> project and Composer package are `ai_provider_perplexity`, but the module's
> **machine name is `ai_perplexity`**. You install with the project name and
> **enable with the machine name** — see [Installation](installation/index.md).

The AI module abstracts providers so you build an AI feature once and point it at
whichever service you choose; this module makes Perplexity one of those options.
It authenticates to the Perplexity API with an **API key**, so store that key as a
secret, and remember prompts you send leave the site.

It depends on the AI module and targets Drupal 10.2+ and 11. This is an early
release (version 1.0.0‑beta2). It has no access‑control role of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the AI
   module requirement, and enable it under the **correct machine name**.
2. [Configuration](configuration/index.md) — register Perplexity on the AI
   settings and supply your API key as a secret.

## Where it lives in the admin menu

Provider configuration lives in the AI module's settings area under
**Configuration → AI → Providers** (`/admin/config/ai/providers`), where
Perplexity appears once enabled. The API key is best stored as a **Key** entity at
**Configuration → System → Keys** (`/admin/config/system/keys`).

## How to use it

Enable the module (as `ai_perplexity`), store your Perplexity API key as a secret,
select it on the provider settings, then choose Perplexity — and one of its
models — as the provider for the AI operations you want it to power.
