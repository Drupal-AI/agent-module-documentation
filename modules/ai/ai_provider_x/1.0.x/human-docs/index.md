# X AI Provider — manual setup guide

**X AI Provider** (`ai_provider_x`) adds a provider plugin for **X AI (Grok)** to
Drupal's [AI module](https://www.drupal.org/project/ai). Grok is the large-language
model from xAI (the AI company associated with X, formerly Twitter); with this
module enabled, the AI module can route its chat and completion operations to X's
AI service, and Grok becomes selectable wherever the AI module offers a provider
choice.

You supply an X API key, which the module stores through Drupal's **Key** module —
back it with an environment variable and never commit it. Calls go to X's API over
HTTPS, and prompt content is sent to X, so this is external data egress: confirm it
is acceptable for the content you route through it. The module has no
access-control role of its own.

> **Overlap note:** another module, **[xAI Provider](https://www.drupal.org/project/ai_provider_xai)**
> (`ai_provider_xai`), also connects the AI module to xAI's Grok models. The two are
> alternative implementations of the same integration — you normally install only
> one. If you are choosing between them, compare their releases and supported core
> versions and pick a single one.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside the AI and Key modules.
2. [Configuration](configuration/index.md) — store your X API key and select Grok.

## Where it lives in the admin menu

The module adds no menu items of its own. Its settings sit with the AI module's
other provider settings under **Configuration → AI → Providers**
(`/admin/config/ai/providers`).

## How to use it

Enable the module, store your X API key as a Key entity, select it on the provider
settings form, then choose **X (Grok)** wherever the AI module offers a provider
choice.
