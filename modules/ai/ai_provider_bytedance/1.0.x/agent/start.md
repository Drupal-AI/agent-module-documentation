<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Provider ByteDance (ai_provider_bytedance) — agent index

A **provider plugin for the `drupal/ai` framework** that exposes **ByteDance ModelArk**
(Volcengine/BytePlus) chat and image models to any AI-consuming subsystem. Package `AI`.
Core `^10.3 || ^11`. License GPL-2.0-or-later. Version 1.0.2.

Requires **`drupal/ai` ^1.2** (module dep `ai:ai`) and **`drupal/key` ^1.18** — the key
dependency is composer-only; enable Key yourself. No submodules, no Drush, no own permissions.

- **Provider plugin: models, operations, request mapping, streaming** →
  [plugins/provider.md](plugins/provider.md)
- **Setup form, config object, endpoint & key handling** →
  [config/settings.md](config/settings.md)

## What it actually is

- One plugin: `ByteDanceProvider` (id **`bytedance`**, label *"ByteDance ModelArk"*) in
  `src/Plugin/AiProvider/ByteDanceProvider.php`, extending `Drupal\ai\Base\OpenAiBasedProviderClientBase`
  and implementing `ImageToImageInterface` (uses `ChatTrait`, `ImageToImageTrait`).
- Supported operations (`getSupportedOperationTypes()`): **`chat`**, **`text_to_image`**,
  **`image_to_image`**.
- Model catalogue is hard-coded in `getModels()` — chat: `skylark-pro-250415`, `deepseek-v3`,
  `kimi-k2-250711`, `gpt-oss-120b-250805`, `skylark-vision-250515`; image:
  `seedream-4-0-250828`, `seedream-4-5-251128`.
- `getSetupData()` names key config `api_key` and seeds default models (chat →
  `skylark-pro-250415`, image → `seedream-4-5-251128`).

## Config, routes, services

- Config object **`ai_provider_bytedance.settings`** — keys `api_key` (Key entity id) and
  `host` (optional endpoint override). Schema in `config/schema/`, install defaults (both empty)
  in `config/install/`.
- One route **`ai_provider_bytedance.settings_form`** at `/admin/config/ai/providers/bytedance`
  (`ByteDanceConfigForm`), requirement **`_permission: 'administer ai providers'`**; menu link
  under the AI providers admin (`ai.admin_providers`).
- No services.yml; the form uses core `ai.provider` and `key.repository`. Request parameter
  defaults for each operation live in `definitions/api_defaults.yml`.

## Mechanism (from source)

- `loadClient()` sets the endpoint to `https://ark.ap-southeast.bytepluses.com/api/v3` unless
  `host` config overrides it, then defers to the AI module base client (OpenAI-style transport).
- `chat()` builds an OpenAI-shaped `messages` payload (text + optional `image_url` data URLs),
  supports tools (`response_format`, `tool_calls`), streaming and Fiber-based streaming, and maps
  ModelArk errors to `AiRateLimitException` / `AiQuotaException` / `AiUnsafePromptException` /
  `AiRequestErrorException`.
- `textToImage()` / `imageToImage()` call `client->images()->create()` and read back `b64_json`
  or `url` results into `ImageFile` objects.
