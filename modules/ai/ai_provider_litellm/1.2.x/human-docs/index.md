# LiteLLM AI Provider — manual setup guide

**LiteLLM AI Provider** (`ai_provider_litellm`) lets you use a self‑hosted
[LiteLLM](https://github.com/BerriAI/litellm) proxy as a provider for Drupal's
[AI module](https://www.drupal.org/project/ai). LiteLLM is an OpenAI‑compatible
gateway that can front many different LLM back ends — OpenAI, Anthropic, Azure,
local/on‑prem models, and more — behind a single endpoint. Point Drupal at your
LiteLLM host and any model it routes to becomes usable through the AI module's
unified operation types: chat, embeddings, moderation, text‑to‑image,
text‑to‑speech, and audio.

Because LiteLLM speaks the OpenAI API, the module's provider plugin builds on the
AI module's OpenAI‑based client, simply pointed at your LiteLLM host. On top of
that it makes a couple of LiteLLM‑specific calls: it **auto‑discovers** the
available models (and reads each model's capability flags so the right models are
offered for each operation type), and it shows your API key's alias, spend,
budget, and blocked status right on the settings form. This makes it easy to
centralize several model vendors behind one gateway, enforce per‑key spend
budgets, or serve air‑gapped/on‑prem models to Drupal.

The module requires the **AI module** and the **Key** module (the LiteLLM token is
stored as a Key entity, not raw config), and runs on **Drupal 10.2 or 11**. It
has one settings form and the **Administer AI providers** permission; it adds no
Drush commands or plugin types of its own. As of 1.2.x the separate OpenAI
provider module is no longer a hard runtime requirement.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside the AI and Key modules.
2. [Configuration](configuration/index.md) — connect to your LiteLLM proxy: the
   host URL, the API key (via a Key entity), and the moderation toggle.

## Where it lives in the admin menu

The settings form is at **Configuration → AI → Providers → LiteLLM**
(`/admin/config/ai/providers/ai_provider_litellm`), and requires the **Administer
AI providers** permission.

## How to use it

Point Drupal at your LiteLLM proxy on the settings form: enter the host URL,
select the Key entity holding your LiteLLM API token, and choose whether to run
moderation before each call. When you save, the module validates the connection by
listing the models from your proxy. Once it's configured and validated, LiteLLM
becomes a selectable provider throughout the AI module — for chat completions,
embeddings for AI Search / vector stores, moderation, image and audio generation,
and so on. See [Configuration](configuration/index.md) for the details and how to
keep the API token out of exported config.
