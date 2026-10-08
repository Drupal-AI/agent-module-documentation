# Siliconflow Provider — manual setup guide

**Siliconflow Provider** (`ai_provider_siliconflow`) registers the **SiliconFlow**
inference API as a provider for Drupal's
[AI module](https://www.drupal.org/project/ai). SiliconFlow is a hosted inference
platform that serves a broad catalogue of open models; this module makes those
models available for chat and related AI operations within Drupal, selectable
wherever the AI module offers a provider choice.

A nice convenience: the module includes an **autocomplete helper** for browsing the
SiliconFlow model list while you configure the provider, so you can look up the
exact model name rather than typing it blind. Access to that lookup is gated by a
dedicated permission, `autocomplete siliconflow model list`.

You supply a SiliconFlow API key, stored through Drupal's **Key** module — back it
with an environment variable and never commit it. Prompt content is sent to
SiliconFlow's API when operations run, so ordinary API usage cost and data egress
apply.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside the AI and Key modules.
2. [Configuration](configuration/index.md) — store your API key, grant the
   model-list permission, and select a model.

## Where it lives in the admin menu

The module adds no menu items of its own. Its settings sit with the AI module's
other provider settings under **Configuration → AI → Providers**
(`/admin/config/ai/providers`). It adds the `autocomplete siliconflow model list`
permission, managed at **People → Permissions**.

## How to use it

Enable the module, store your SiliconFlow API key as a Key entity, select it on the
provider settings form, use the model-list autocomplete to pick a model, then
choose **SiliconFlow** wherever the AI module offers a provider choice.
