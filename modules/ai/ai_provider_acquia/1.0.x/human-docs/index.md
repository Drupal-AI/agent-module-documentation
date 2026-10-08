# Acquia AI Gateway — manual setup guide

**Acquia AI Gateway** (`ai_provider_acquia`) is a **provider** for Drupal's AI
module. The AI module talks to language models through interchangeable provider
plugins; this one connects it to **Acquia's hosted AI Gateway**, a LiteLLM-based
service that puts many LLMs behind a single endpoint. Once it is configured, every
model your Acquia subscription exposes becomes usable by any AI-module feature —
chat (including image-vision, tool/function calling, and structured responses),
embeddings, moderation, text-to-image, and text-to-speech — without wiring up each
model individually.

Credentials are never hardcoded. The gateway host comes from a `settings.php`
override or the `AI_GATEWAY_URL` environment variable, and the API key is resolved
through the **Key** module under the fixed key name `ai_provider_acquia`; a bundled
resolver surfaces the `AI_GATEWAY_API_KEY` environment variable as that Key value,
so the secret stays in the environment rather than in exported configuration.
These values are usually pre-provisioned for you by Acquia.

Traffic to the gateway uses Drupal's standard HTTP client with normal TLS
verification and authenticates with a Bearer token — no disabled certificate
checks, no secret in the URL. The settings form even calls back to the gateway to
show your key's spend, budget, and blocked status, plus a per-model capability
table.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the AI and Key dependencies.
2. [Configuration](configuration/index.md) — supply the gateway host and API key
   (env → Key), verify the connection, and assign default models per operation.

## Where it lives in the admin menu

The provider's settings form is at **Configuration → AI → Providers → Acquia**
(`/admin/config/ai/providers/acquia`), gated by the AI module's **Administer AI
providers** permission.

## How to use it

Provide the `AI_GATEWAY_URL` and `AI_GATEWAY_API_KEY` values (typically supplied
by Acquia), open the provider settings form to confirm the connection and see your
key/budget status, then pick which Acquia models each AI operation should default
to. From then on, AI-module features route through the Acquia gateway.
