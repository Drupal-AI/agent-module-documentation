<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# mittwald Provider (ai_provider_mittwald) — agent index

A **provider plugin for the Drupal AI module** (`drupal/ai`) that targets **mittwald AI Hosting**'s
OpenAI-compatible LLM API (default `llm.aihosting.mittwald.de/v1`). Package *AI Providers*. Requires
**`ai`** (`drupal/ai:^1.3.0`) and **`key`** (`drupal/key:^1.18`). Core `^10.3 || ^11`. License
GPL-2.0-or-later. Version 1.2.0.

- **Install, the settings form (Key), config object/schema, routes/permission, model filtering, operations** →
  [config/settings.md](config/settings.md)

## What it actually is

- One plugin: `MittwaldProvider` (AiProvider id **`mittwald`**, label *"mittwald"*), in
  `src/Plugin/AiProvider/MittwaldProvider.php`, extending drupal/ai's
  `OpenAiBasedProviderClientBase` and implementing `ReRankInterface`.
- One service: **`ai_provider_mittwald.helper`** → `MittwaldHelper` (`src/MittwaldHelper.php`),
  used for the setup-time rate-limit probe.
- One admin config form `MittwaldConfigForm` (route `ai_provider_mittwald.settings_form` at
  `/admin/config/ai/providers/mittwald`, permission **`administer ai providers`**) writing config
  object **`ai_provider_mittwald.settings`** (`api_key` = Key name, `moderation` bool, `host`).
- API key via the **Key module** (`key_select`), sent as a bearer token. `host` and `moderation`
  are config-schema keys but are **not exposed in the form** (set via config only).
- Supported operation types: `chat`, `embeddings`, `moderation`, `rerank`, `speech_to_text`,
  `text_to_speech` — `moderation` and `textToImage` throw "not implemented".
- No submodules, no Drush, no own permissions. Config schema + install defaults present.

## Mechanism (from source)

- `loadClient()` sets the OpenAI SDK endpoint from config `host` or the default
  `llm.aihosting.mittwald.de/v1`, then calls the base `loadClient()` (wrapping failures in
  `AiSetupFailureException`).
- `getModels()` lists the server's models and filters them by `$operation_type` (regex on `id`,
  skipping `owned_by === 'openai-dev'`), applies capability heuristics (vision/JSON/audio/video),
  sorts, and caches per operation-type+capabilities key in the cache backend.
- `getSetupData()` returns `key_config_name: api_key` plus default model ids per operation type;
  `postSetup()` runs `MittwaldHelper::testRateLimit()`.
- `rerank()` posts directly to `{endpoint}/rerank` through the base PSR-18 client with a bearer
  token (the OpenAI SDK has no rerank resource); `embeddings()` / `textToSpeech()` call the SDK,
  dropping empty optional params. `isReasoningModel()` and `embeddingsVectorSize()` are id-based
  heuristics.
- `MittwaldConfigForm` validates the Key resolves to a value and that `getConfiguredModels()`
  succeeds, then on submit runs the rate-limit probe and seeds defaults via
  `AiProviderPluginManager::defaultIfNone()`. `hook_update_10001/10002` migrate withdrawn default
  models to `Ministral-3-14B-Instruct-2512`.
