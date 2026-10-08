# Cloudflare AI Gateway Provider — manual setup guide

**Cloudflare AI Gateway Provider** (`ai_provider_cloudflare_gateway`) connects
Drupal's AI module to a **Cloudflare AI Gateway**. Rather than talking to a model
vendor directly, Drupal sends requests to your Cloudflare gateway, which forwards
them on while adding the things a gateway is good at — caching of repeated
responses, rate limiting, and analytics — all visible in your Cloudflare
dashboard.

Once enabled and configured, the gateway appears as a selectable provider
wherever the AI module offers a provider choice, for chat and related operations.
Because it routes through Cloudflare, you also get a single vantage point for
monitoring and controlling AI traffic across the site.

This module is built on Cloudflare's own Drupal integration: it depends on the
**Cloudflare AI** and **Cloudflare SDK** modules in addition to the AI module.
Configuration identifies your gateway using your Cloudflare **account ID** and
**gateway ID**, and authenticates with a Cloudflare API token. As always, the
token is a real credential (store it via Key/env), and prompts sent through the
gateway leave your site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module with its Cloudflare and AI dependencies.
2. [Configuration](configuration/index.md) — identify your gateway (account and
   gateway IDs), supply the API token securely, and choose it for AI operations.

## Where it lives in the admin menu

The AI module groups its settings under **Configuration → AI**
(`/admin/config/ai`). Installed providers, including the Cloudflare AI Gateway,
are configured from the **Providers** area under that section
(`/admin/config/ai/providers`).

## How to use it

Create an AI Gateway in your Cloudflare dashboard and note its account ID and
gateway ID, then enable this module, store your Cloudflare API token as a Key
entity, and register the gateway on the AI providers page. Select it for the AI
operations you want on the AI default-provider settings. Requires Drupal 10.5,
11 or 12.
