# Infomaniak AI Provider — manual setup guide

**Infomaniak AI Provider** (`ai_provider_infomaniak`) connects Drupal's AI module
to **Infomaniak AI**, the AI service from Infomaniak, the Swiss hosting company.
Once enabled and given an API key, Infomaniak's models become selectable inside
Drupal for chat and related AI operations, wherever the AI module offers a
provider choice. The provider includes a model-list autocomplete, so you can pick
from the models Infomaniak offers when configuring it.

For organisations that care about where their data is processed, Infomaniak's
Swiss base can be a deciding factor — but confirm the specifics against
Infomaniak's own terms rather than assuming. As with any provider, prompts you
send are transmitted to Infomaniak's endpoint, which incurs cost and sends content
off-site.

The API key is stored via the **Key** module from an environment variable rather
than in exported configuration. That keeps the credential — which is both a
spending and an access credential — out of your exported config.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module with its AI and Key dependencies.
2. [Configuration](configuration/index.md) — register Infomaniak, supply the API
   key securely, pick a model, and choose it for AI operations.

## Where it lives in the admin menu

The AI module groups its settings under **Configuration → AI**
(`/admin/config/ai`). Installed providers, including Infomaniak, are configured
from the **Providers** area under that section (`/admin/config/ai/providers`).

## How to use it

Get an Infomaniak AI API key, enable this module, store the key as a Key entity,
and register Infomaniak on the AI providers page — using the model-list
autocomplete to pick a model. Then select Infomaniak for the operations you want
on the AI default-provider settings. This is an **alpha** release; requires Drupal
10.4 or 11.
