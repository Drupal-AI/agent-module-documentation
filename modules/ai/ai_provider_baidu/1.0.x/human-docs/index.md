# Baidu Provider — manual setup guide

**Baidu Provider** (`ai_provider_baidu`) registers Baidu's large-language-model
API as a provider for Drupal's [AI module](https://www.drupal.org/project/ai).
Baidu (via its ERNIE / Qianfan platform) is one of China's major LLM vendors; this
module lets the AI module use those models for chat and related operations. Once it
is configured, Baidu models become selectable wherever the AI module offers a
provider choice.

You supply a Baidu API credential, which the module stores through Drupal's **Key**
module — back it with an environment variable and never commit it. When AI
operations run, the prompt content is sent to Baidu's API, so ordinary API usage
cost and data egress apply.

Because Baidu operates in China, sending content there is a data-residency
consideration: weigh it before routing sensitive or regulated content through this
provider.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside the AI and Key modules.
2. [Configuration](configuration/index.md) — store your Baidu API credential and
   select Baidu models.

## Where it lives in the admin menu

The module adds no menu items of its own. Its settings sit with the AI module's
other provider settings under **Configuration → AI → Providers**
(`/admin/config/ai/providers`). It also defines its own permission for
administering the provider.

## How to use it

Enable the module, store your Baidu credential as a Key entity, select it on the
Baidu provider settings form, then choose **Baidu** and a model wherever the AI
module offers a provider choice.
