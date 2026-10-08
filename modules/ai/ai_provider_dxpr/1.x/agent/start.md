<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DXPR AI Provider (ai_provider_dxpr) — agent index

A **provider plugin for the `drupal/ai` framework** that connects Drupal to **DXPR AI (the DXAI
Kavya platform)** — an OpenAI-compatible gateway fronting OpenAI, Claude, Gemini, xAI and
MistralAI with automatic failover, web research and EU routing. Package `AI Providers`.
Core `^10.3 || ^11`. License GPL-2.0-or-later. Version 1.1.1.

Depends on `ai:ai`, **`key:key`** and **`dxpr_builder:dxpr_builder` (>=2.7.5)**; composer also
requires `openai-php/client`.

- **Provider plugin: operations, models, request building, streaming, translation, em-dash** →
  [plugins/provider.md](plugins/provider.md)
- **Settings form, config object, key handling, hooks, install** →
  [config/settings.md](config/settings.md)

## What it actually is

- One plugin: `DxprProvider` (id **`dxpr`**, label *"DXPR"*) in
  `src/Plugin/AiProvider/DxprProvider.php`, extending `Drupal\ai\Base\AiProviderClientBase` and
  implementing `ChatInterface`, `ImageToImageInterface`, `TextToImageInterface`,
  `TranslateTextInterface` (uses `ChatTrait`, `ImageToImageTrait`).
- Supported operations (`getSupportedOperationTypes()`): **`chat`**, **`text_to_image`**,
  **`image_to_image`**, **`translate_text`**. Capability: `StreamChatOutput`.
- Models are fetched live from the API (`getModels()` → `client->models()->list()`, filtered to
  exclude `owned_by === 'dxpr-dev'`, cached). Default models are all `kavya-m1` (chat/translate)
  and `kavya-image` (images) — see `getSetupData()`.

## Config, routes, services

- Config object **`ai_provider_dxpr.settings`** — `api_key` (Key entity id), `host` (base URI,
  default `kavya.dxpr.com/v1`), `em_dash_mode` (int 0-3), `em_dash_language_overrides` (sequence).
  Schema/install in `config/schema` and `config/install`.
- One route **`ai_provider_dxpr.settings_form`** at `/admin/config/ai/providers/dxpr`
  (`DxprConfigForm`), requirement **`_permission: 'administer ai providers'`**; menu link under
  `ai.admin_providers`.
- Services (`…services.yml`): `ai_provider_dxpr.helper` (`DxprHelper` — free-tier rate-limit
  check) and `DxprProviderHooks` (OO hook). Two asset libraries (`ai-providers`,
  `em-dash-settings`). `hook_install()` auto-selects any Key whose label contains "DXPR".

## Mechanism (from source)

- `loadClient()` builds an openai-php `Client` via `\OpenAI::factory()->withApiKey(...)
  ->withHttpClient($this->httpClient)->withBaseUri($host)` — the Bearer key comes from a Key
  entity (`loadApiKey()`), never from a URL; transport is Drupal's HTTP client.
- Streaming chat and both image operations bypass the openai-php response parsers with direct
  `$this->httpClient->request('POST', 'https://'.$host.'/…')` calls (`createRawStream()`,
  `images/generations`, `images/edits`).
- `translateText()` builds a content-aware system prompt (HTML-aware, RTL detection, prompt-
  injection guard) and routes an inner `chat()` through a `ProviderProxy` so AI events fire.
- `resolveEmDashMode()` picks the em-dash mode from config / per-language overrides and adds it
  to each chat payload as `em_dash_mode`.
- `DxprProviderHooks::aiSettingsFormAlter()` warns on the AI settings page when no key is set.
