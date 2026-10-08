<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Siliconflow Provider (ai_provider_siliconflow) — agent index

An **AI-module provider plugin** for **SiliconFlow's inference API**, supporting `chat`,
`embeddings`, and `text_to_image`. Package `AI Providers`. Depends on **`ai`** and **`key`**.
Core `^10.2 || ^11`. License GPL-2.0-or-later. Version dir `1.0.x` (release 1.0.2).

- **Settings form, config, schema, install migration, autocomplete route** → [config/settings.md](config/settings.md)
- **The `siliconflow` provider plugin + `SiliconflowApi` service** → [plugins/provider.md](plugins/provider.md)

## What it actually is

- One plugin: `SiliconflowProvider` (id **`siliconflow`**, label *Siliconflow*) in
  `src/Plugin/AiProvider/SiliconflowProvider.php`, extending
  `Drupal\ai\Base\AiProviderClientBase`, implementing `ChatInterface`, `EmbeddingsInterface`,
  `ImageClassificationInterface`, using `ChatTrait`. `hasPredefinedModels = FALSE` — models are
  admin-entered, not hard-coded.
- One service: **`ai_provider_siliconflow.api`** → `SiliconflowApi` (`src/SiliconflowApi.php`),
  a thin REST client (arg `@http_client`) with methods for many inference task types; base
  `https://api.siliconflow.cn/v1`.
- One controller: `SiliconflowAutocomplete::models` (`src/Controller/SiliconflowAutocomplete.php`)
  backing the model-name autocomplete.
- One settings form: `SiliconflowConfigForm` (`src/Form/SiliconflowConfigForm.php`), config
  object `ai_provider_siliconflow.settings`.

## Provides

- **Plugin:** `ai_provider` instance `siliconflow`.
- **Service:** `ai_provider_siliconflow.api`.
- **Permission:** `autocomplete siliconflow model list`
  (`ai_provider_siliconflow.permissions.yml`).
- **Routes** (`ai_provider_siliconflow.routing.yml`):
  - `ai_provider_siliconflow.settings_form` → `/admin/config/ai/providers/siliconflow`
    (`_permission: 'administer ai providers'`); menu link under *AI → Providers*.
  - `ai_provider_siliconflow.autocomplete.models` →
    `/admin/ai/siliconflow/autocomplete/models`, `_format: json`
    (`_permission: 'autocomplete siliconflow model list'`).
- **Config + schema:** `ai_provider_siliconflow.settings` (`config/install/` seeds `api_key: ''`;
  `config/schema/` types `api_key`).
- **Install hook:** `hook_install()` migrates config from the legacy `provider_siliconflow`
  AI submodule and uninstalls it.
- **Definitions:** `definitions/api_defaults.yml`, loaded by `getApiDefinition()`.

## Dependencies & operation

- Requires the `ai` framework and `key` module. The access token is a **Key entity** selected on
  the settings form; per-operation models are added on the AI-module models table, with a
  `siliconflow_endpoint` field (model name or dedicated URL) that autocompletes from SiliconFlow.
- Supported operation types (`getSupportedOperationTypes()`): `chat`, `embeddings`,
  `text_to_image`. `imageClassification()` is also implemented in code (its `supportedTypes`
  entry is commented out). No streaming; no system-role support in chat (a warning is logged).
