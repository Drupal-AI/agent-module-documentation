# Microsoft Azure AI — manual setup guide

**Microsoft Azure AI** (`ai_provider_azure`) is a provider plugin for Drupal's
[AI module](https://www.drupal.org/project/ai). It teaches the AI module how to
talk to **Azure AI Studio / Azure OpenAI** — and to OpenAI-compatible endpoints
sitting behind a proxy — so that anywhere the AI module lets you pick a provider,
you can now choose **Azure**. It supports chat, embeddings, text-to-image,
text-to-speech and speech-to-text, and can stream chat responses.

Unlike some providers, this one ships with **no predefined models**. You add each
model yourself on the Azure setup form, giving it the Azure **endpoint** (the
"Target URI" from your deployment), an **API key** stored securely as a Key entity,
and a **header type** that tells the module how to authenticate. Under the hood it
uses the `openai-php/client` library and derives the right request URL for each
operation type from the endpoint you provide.

The module has its own small config object but no permissions or plugins of its
own — the setup form is gated by the AI module's `administer ai providers`
permission. Live calls need real Azure credentials: a working endpoint and a valid
key. Because credentials are held in a **Key** entity, you keep your Azure API key
out of version control (for example by backing the key with an environment
variable).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies with Composer and enable it.
2. [Configuration](configuration/index.md) — store the Azure key, then add models
   (endpoint, key, header type) on the setup form.

## Where it lives in the admin menu

Once enabled, the setup form sits under the AI module's providers area at
**Configuration → AI → Providers → Azure**
(`/admin/config/ai/providers/azure`, "Setup Azure Models"). You need the
**Administer AI providers** permission (provided by the AI module) to reach it.
