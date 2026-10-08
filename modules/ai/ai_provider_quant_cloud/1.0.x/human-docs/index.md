# Quant Cloud AI Provider — manual setup guide

**Quant Cloud AI Provider** (`ai_provider_quant_cloud`) connects Drupal's
[AI module](https://www.drupal.org/project/ai) to the **Quant Cloud** platform
(QuantCDN / QuantGov). It offers both **chat** and **embeddings** through Quant's
Dashboard API, so once it is configured Quant's models become selectable wherever
the AI module offers a provider choice — including as the embeddings source for
vector search.

Authentication is **OAuth** rather than a single API key: you supply OAuth client
credentials, which the module stores through Drupal's **Key** module. Back them
with environment variables and never commit them.

When AI operations run, prompt or embedding content is sent to Quant's API, so
ordinary platform cost and data egress apply — weigh that for sensitive content.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside the AI and Key modules.
2. [Configuration](configuration/index.md) — store your OAuth client credentials
   and select Quant models.

## Where it lives in the admin menu

The module adds no menu items of its own. Its settings sit with the AI module's
other provider settings under **Configuration → AI → Providers**
(`/admin/config/ai/providers`). It also defines its own permission for
administering the provider.

## How to use it

Obtain OAuth client credentials from the Quant Cloud dashboard, store them as Key
entities, enter (or select) them on the Quant provider settings form, then choose
**Quant Cloud** and a model wherever the AI module offers a provider choice — for
chat, or as the embeddings provider for AI Search.
