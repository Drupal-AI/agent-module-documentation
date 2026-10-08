# LiteLLM AI Provider — manual setup guide

**LiteLLM AI Provider** (`ai_provider_litellm`) connects Drupal's **AI** module to
a [LiteLLM](https://github.com/BerriAI/litellm) proxy. LiteLLM is a lightweight,
self-hostable service that puts a single, OpenAI-compatible API in front of many
different LLMs (OpenAI, Anthropic, Azure, local/on-prem models, and more). With
this module, whatever LiteLLM fronts becomes usable through Drupal's unified AI
operation types — chat, embeddings, moderation, text-to-image, text-to-speech, and
text translation.

The problem it solves is vendor lock-in and model sprawl. Instead of configuring
each AI vendor separately in Drupal, you point Drupal at one LiteLLM host; LiteLLM
handles routing, fallback, load-balancing, and per-key spend budgets on its side.
You can swap the backing model, or add failover across providers, without touching
Drupal's configuration. It's also the natural choice for serving **on-prem or
air-gapped** models to Drupal through a local gateway.

The module registers a single AI provider plugin, `litellm`. Because LiteLLM
speaks the OpenAI API, the standard operations are handled by an OpenAI-compatible
client pointed at your LiteLLM host, and the module auto-discovers the available
models and what each one can do (chat, embeddings, vision, function/tool calling,
structured JSON responses, and so on) so only capable models are offered per
operation. As of 1.3.x it also adds a `translate_text` operation and no longer
requires the separate OpenAI provider module.

> **Security note:** this release's project page lists it as **not covered** by
> Drupal's security advisory policy. Weigh that for production use, and treat the
> LiteLLM host and API key as sensitive infrastructure.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside the AI module.
2. [Configuration](configuration/index.md) — point the provider at your LiteLLM
   host and select its API key.

## Where it lives in the admin menu

The provider's settings form is at **Configuration → AI → AI Providers → LiteLLM**
(`/admin/config/ai/providers/ai_provider_litellm`), gated by the **administer ai
providers** permission. Once configured, the LiteLLM provider becomes selectable
wherever the AI module and its submodules let you choose a provider and model.

## How to use it

You need a running LiteLLM instance and its API key. On the settings form, select
the **Key** entity holding your LiteLLM API key and enter the **host** URL of your
LiteLLM instance; saving validates the credentials by listing models from the
proxy. After that, LiteLLM appears as an available provider throughout the AI
module — pick it (and a model) for chat, embeddings, AI Search, and the other AI
features, and requests are routed through your LiteLLM gateway.
