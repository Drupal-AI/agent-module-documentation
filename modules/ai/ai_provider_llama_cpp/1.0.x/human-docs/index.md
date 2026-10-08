# llama.cpp Provider — manual setup guide

**llama.cpp** (`ai_provider_llama_cpp`) lets Drupal's
[AI module](https://www.drupal.org/project/ai) talk to a local or self-hosted
**llama.cpp** server. llama.cpp is a popular open-source engine for running LLMs on
your own hardware (CPU or GPU); when you start its server it exposes an
**OpenAI-compatible `/v1` HTTP API**. This provider registers that server as an AI
provider, so the AI module can run chat and completion operations against a model
you host yourself — no third-party vendor involved.

The main draw is data control and cost. Because inference happens on infrastructure
you operate, prompt data never leaves your environment, and there is no per-token
vendor bill. And because the server speaks the OpenAI API shape, existing
OpenAI-style flows work against it once you point them at your local endpoint.

The only thing you configure is the server's **base URL**. A local server usually
needs no API key, so there is typically no secret to store — but you should make
sure the llama.cpp endpoint is network-restricted and not publicly exposed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — point the provider at your llama.cpp
   server's base URL.

## Where it lives in the admin menu

The module adds no menu items of its own. Its settings sit with the AI module's
other provider settings under **Configuration → AI → Providers**
(`/admin/config/ai/providers`). It also defines its own permission for
administering the provider.

## How to use it

Run a llama.cpp server with its OpenAI-compatible API enabled, enable this module,
enter the server's base URL on the provider settings form, then choose **llama.cpp**
wherever the AI module offers a provider choice.
