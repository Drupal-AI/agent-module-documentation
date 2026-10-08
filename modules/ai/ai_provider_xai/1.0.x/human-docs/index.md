# xAI Provider — manual setup guide

**xAI Provider** (`ai_provider_xai`) registers xAI's API as a provider for Drupal's
[AI module](https://www.drupal.org/project/ai), making the **Grok** family of
models available for chat and related operations. Once configured, xAI models
become selectable wherever the AI module offers a provider choice.

You supply an xAI API key, which the module stores through Drupal's **Key** module —
back it with an environment variable and never commit it. Prompt content is sent to
xAI's API when operations run, so ordinary API usage cost and external data egress
apply.

> **Overlap note:** another module, **[X AI Provider](https://www.drupal.org/project/ai_provider_x)**
> (`ai_provider_x`), also connects the AI module to X's Grok models. The two are
> alternative implementations of the same integration — you normally install only
> one. If you are choosing between them, compare their releases and supported core
> versions and pick a single one.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside the AI and Key modules.
2. [Configuration](configuration/index.md) — store your xAI API key and select a
   Grok model.

## Where it lives in the admin menu

The module adds no menu items of its own. Its settings sit with the AI module's
other provider settings under **Configuration → AI → Providers**
(`/admin/config/ai/providers`). It also defines its own permission for
administering the provider.

## How to use it

Enable the module, store your xAI API key as a Key entity, select it on the
provider settings form, then choose **xAI** and a Grok model wherever the AI module
offers a provider choice.
