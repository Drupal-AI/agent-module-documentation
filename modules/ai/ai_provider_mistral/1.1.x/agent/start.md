<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mistral AI Provider (ai_provider_mistral) — agent index

Provider plugin that registers **Mistral AI** with Drupal's **`ai`** module. One class,
`Drupal\ai_provider_mistral\Plugin\AiProvider\MistralProvider` (plugin id `mistral`), implements
`ChatInterface`, `EmbeddingsInterface` and `ModerationInterface`. Requires `ai ^1.2.0`, `key ^1.18`
and PHP 8.2+. Core `^10.2 || ^11`. Version **1.1.0-rc1** (release candidate). License GPL-2.0-or-later.

## What it does
- **Supported operation types** (`getSupportedOperationTypes()`): `chat`, `embeddings`, `moderation`.
- **Chat** — streaming and non-streaming, multi-turn, tool/function calling, structured JSON-schema
  output (`response_format`), and multimodal input (images sent as `image_url`, other files as
  `document_url`, both base64-encoded inline). Tunables: `max_tokens`, `temperature`, `top_p`.
- **Embeddings** — hard-wired to the `mistral-embed` model.
- **Moderation** — defaults to `mistral-moderation-latest`; returns a flagged boolean plus
  per-category scores.
- **Model listing** — chat and moderation model lists are fetched live from Mistral's `/models`
  endpoint and filtered by requested `AiModelCapability` (vision, function calling, JSON); results
  cached 24h. Embeddings list is the static `mistral-embed`.
- **Files API helpers** (not AI operation types): `uploadFile`, `getFileUrl`, `listFiles`,
  `retrieveFile`, `deleteFile` for OCR / batch / fine-tune purposes.

## How it talks to Mistral
- HTTP is handled by the third-party **`partitech/php-mistral`** library, via PSR-18 client
  discovery. TLS verification is left at the library/Guzzle secure default (not disabled).
- Auth is a **Bearer** header carrying the Mistral API key.
- The module stores only a **Key entity reference** (`api_key` config, a `key_select` element) plus
  an optional `host`. The real secret is resolved server-side at request time by
  `AiProviderClientBase::loadApiKey()` through the Key module's repository. The key is never written
  to config, drupalSettings, markup or logs.

## Configuration
- Route `ai_provider_mistral.settings_form` → `/admin/config/ai/providers/mistral`, permission
  `administer ai providers` (`restrict access: true`).
- Two settings: **Mistral API Key** (Key entity selector) and, under Advanced, **Custom API Host**
  (overrides the default `https://api.mistral.ai`; admin-only). On save it sets `mistral` as the
  default chat provider (`mistral-large-latest`) and embeddings provider (`mistral-embed`) if none
  is set yet.
- `hook_install` migrates config from the old in-`ai` submodule `provider_mistral` if present.

## Subdocs
- `config/setup.md` — install, Key setup, host override, defaults.
- `providers/operations.md` — the three operation types and their models/parameters in detail.

## Notes for agents
1. The key is a **spending credential** — cap and monitor it at Mistral.
2. A **prompt is a disclosure** that leaves the site (Mistral, EU-hosted). Treat personal/unpublished
   content in prompts as a data transfer.
3. **Model names change** — pin a model; plan for withdrawal or silent behaviour drift.
4. `ai_provider_mistral.services.yml` still declares a service pointing at a non-existent
   `Drupal\ai_provider_mistral\MistralClient` class — a leftover from an earlier architecture; it is
   never instantiated (all HTTP goes through the `partitech/php-mistral` `MistralClient`).

Peers documented here: `ai_provider_openrouter`, `ai_provider_deepl`.
