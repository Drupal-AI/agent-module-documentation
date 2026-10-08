<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring the OpenAI Compatible provider

## Install & enable

```bash
composer require drupal/ai_provider_openai_compatible
drush pm:enable ai_provider_openai_compatible -y
```

Depends on the **AI module** (`drupal/ai:^1.2.0`) and the **Key module** (`drupal/key:^1.18`). No
submodules, no Drush commands, no permissions of its own. Core requirement `^10.3 || ^11`.

## API key (Key module)

The provider does not store the raw API key in its own config. Create a Key first:

1. `/admin/config/system/keys/add` → key type *Authentication*, enter the API key value, save.
2. In the provider form, select that key in the **API Key** field (`#type => key_select`).

The config object stores only the **key's machine name** in `api_key`; the base class resolves the
real secret through the Key repository at request time. `getSetupData()` returns
`key_config_name: 'api_key'` so the AI module knows which config key holds the credential.

## The settings form

Route **`ai_provider_openai_compatible.settings_form`** →
`/admin/config/ai/providers/openai-compatible`, defined in
`ai_provider_openai_compatible.routing.yml`, gated by permission **`administer ai settings`** (owned
by the `ai` module — note this differs from the sibling providers that use `administer ai
providers`). A menu link places it under *Configuration → AI* as *OpenAI Compatible*. Form class:
`src/Form/OpenAiCompatibleConfigForm.php`.

Top-level fields (written to config object **`ai_provider_openai_compatible.settings`**):

| Key | Type | Meaning |
|---|---|---|
| `api_key` | string (Key name, required) | The Key-module key holding the API secret (`key_select`). |
| `endpoint` | string / URL (required) | Base URL of the OpenAI-compatible API, e.g. `https://api.deepseek.com`. |
| `models` | sequence | One or more model definitions (below). |

### Per-model fields

Each `models[]` entry (repeatable via the AJAX *Add Another Model* / *Remove Model* buttons):

| Field | Meaning |
|---|---|
| `id` | Unique model id sent to the API (e.g. `deepseek-chat`). |
| `label` | Human-readable name. |
| `operation_types` | Checkboxes; options come from `AiProviderPluginManager::getOperationTypes()` (chat, embeddings, translate_text, …). At least one required. |
| `capabilities` | Checkboxes; options come from the `AiModelCapability` enum (JSON output, tools, structured response, vision, …). |
| `parameters` | Free-form **YAML** (temperature, max_tokens, top_p, …), decoded and stored as a mapping. |

Config schema is in `config/schema/ai_provider_openai_compatible.schema.yml` (the `models` sequence
with an open `parameters` mapping). Install defaults (`config/install/…settings.yml`) seed
`endpoint: https://api.deepseek.com` and the `deepseek-chat` / `deepseek-reasoner` models.

### Validation & submit

`validateForm()` requires a non-empty API key **with a resolvable value**
(`keyRepository->getKey($key)->getKeyValue()`), a non-empty endpoint that passes
`FILTER_VALIDATE_URL`, unique model ids, a label and at least one operation type per model, and
syntactically valid YAML `parameters`. `submitForm()` normalizes checkbox arrays, decodes the YAML,
saves the config, and calls `setDefaultModels()` → `AiProviderPluginManager::defaultIfNone()` to seed
the site's default chat/embeddings models for this provider.

## How models are resolved at runtime

`OpenAiCompatibleProvider` extends `OpenAiBasedProviderClientBase`:

- `getEndpoint()` returns the configured `endpoint` (or NULL); the base class builds the OpenAI SDK
  client from that endpoint plus the Key-resolved credential.
- `getParsedModelsConfig()` caches `parseModelsConfig()`, which indexes the `models` sequence by
  `id`; an empty/invalid config falls back to `getDefaultModelsConfig()` (DeepSeek chat + reasoner).
- `getConfiguredModels($operation_type, $capabilities)` returns `id => label` for models matching the
  requested operation type and holding all requested capabilities.
- `getSupportedOperationTypes()` unions operation types across all models (defaulting to `['chat']`).
- `getModelSettings()` injects each model's YAML `parameters` into the AI-module config form, with
  the field type inferred by `getParameterType()` (int/float/bool/array/string).

## Operating notes

- To target a different OpenAI-compatible service, change only the `endpoint` and the selected Key,
  then define that service's model ids.
- Capability and operation-type checkbox options are pulled live from the AI module; if the AI
  module cannot supply them the form falls back to a hardcoded list.
- Model `parameters` are per-model overrides; keep the YAML keys aligned with what the target API
  accepts.
