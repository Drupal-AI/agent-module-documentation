<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OpenAI Compatible Provider (ai_provider_openai_compatible) — agent index

A **provider plugin for the Drupal AI module** (`drupal/ai`) that targets any endpoint implementing
the OpenAI API (DeepSeek, SiliconFlow, Kimi, …). Models are fully admin-defined. Package
*AI Providers*. Requires **`ai`** (`drupal/ai:^1.2.0`) and **`key`** (`drupal/key:^1.18`). Core
`^10.3 || ^11`. License GPL-2.0-or-later. Version 1.2.1.

- **Install, the settings form (endpoint + Key + per-model config), config object/schema, routes/permission** →
  [config/settings.md](config/settings.md)

## What it actually is

- One plugin: `OpenAiCompatibleProvider` (AiProvider id **`openai_compatible`**, label
  *"OpenAI Compatible"*), in `src/Plugin/AiProvider/OpenAiCompatibleProvider.php`, extending
  drupal/ai's `OpenAiBasedProviderClientBase`.
- One admin config form `OpenAiCompatibleConfigForm` (route
  `ai_provider_openai_compatible.settings_form` at `/admin/config/ai/providers/openai-compatible`,
  permission **`administer ai settings`**) writing config object
  **`ai_provider_openai_compatible.settings`** (`api_key` = Key entity name, `endpoint` URL, `models`
  sequence).
- API key handled through the **Key module** (`key_select`), not stored inline.
- Supported operation types are derived from the configured models (defaults to `chat`).
- No submodules, no Drush, no own permissions. Config schema + install defaults present.

## Mechanism (from source)

- `getEndpoint()` returns the configured `endpoint` (base URL); the base class builds the OpenAI SDK
  client from that endpoint and the Key-resolved API key.
- `getParsedModelsConfig()` / `parseModelsConfig()` read the `models` config sequence and index it by
  model `id`; when empty they fall back to `getDefaultModelsConfig()` (DeepSeek chat + reasoner).
- `getConfiguredModels()` filters those models by requested `$operation_type` and required
  `$capabilities`; `getSupportedOperationTypes()` unions the operation types across all models.
- `getModelSettings()` merges each model's YAML `parameters` into the AI-module config form (type
  inferred by `getParameterType()`). `getSetupData()` returns `key_config_name: api_key` and the
  default chat/embeddings models.
- The form validates the Key has a value, the endpoint is a valid URL (`FILTER_VALIDATE_URL`), model
  ids are unique, and each model's parameters are valid YAML, then seeds default models via
  `AiProviderPluginManager::defaultIfNone()`.
