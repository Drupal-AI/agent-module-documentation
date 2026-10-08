# AI Provider ByteDance — manual setup guide

**AI Provider ByteDance** (`ai_provider_bytedance`) connects Drupal's AI module to
**ByteDance ModelArk**, ByteDance's hosted model platform (part of its Volcano
Engine cloud). Once enabled and given an API key, the models ByteDance exposes
through ModelArk become selectable inside Drupal for chat and related AI
operations, wherever the AI module offers a provider choice.

Like every provider plugin, it does no work on its own — it is a binding that
lets the AI module route requests to ModelArk. Which capabilities and models you
can actually use depend on your ModelArk account and what the AI module supports.

The two standing considerations apply. The API key is a spending credential, so
store it as a Key entity backed by an environment variable rather than in
exported configuration, and set a limit at the vendor. And every prompt is sent
to ByteDance's endpoint — that is content leaving your site to a third-party
processor, which matters for unpublished or personal data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside the AI module.
2. [Configuration](configuration/index.md) — register ByteDance as a provider,
   supply the API key securely, and choose it for AI operations.

## Where it lives in the admin menu

The AI module groups its settings under **Configuration → AI**
(`/admin/config/ai`). Installed providers, including ByteDance, are configured
from the **Providers** area under that section (`/admin/config/ai/providers`).

## How to use it

Enable the module, obtain a ModelArk API key from your ByteDance / Volcano Engine
account, store it as a Key entity, and register ByteDance on the AI providers
page. Then, on the AI module's default-provider settings, select ByteDance for
the operations (such as chat) you want it to handle. Requires Drupal 10.3 or 11.
