<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# llama.cpp (ai_provider_llama_cpp) — agent index

A **provider plugin for the Drupal AI module** (`drupal/ai`) that connects a self-hosted
**llama.cpp** `llama-server` through its OpenAI-compatible `/v1` HTTP API. Package *AI Providers*.
Requires **`ai`** (`drupal/ai:^1.2.0`). Core `^10.2 || ^11`. License GPL-2.0-or-later. Version 1.0.0.

- **Install, the settings form, config object, routes/permission, and how the provider works** →
  [config/settings.md](config/settings.md)

## What it actually is

- One plugin: `LlamaCppProvider` (AiProvider id **`llama_cpp`**, label *"llama.cpp (OpenAI-compatible)"*),
  in `src/Plugin/AiProvider/LlamaCppProvider.php`, extending drupal/ai's
  `OpenAiBasedProviderClientBase` and using `ChatTrait`.
- Supported operation types: **`chat`** and **`embeddings`** (`getSupportedOperationTypes()`).
- `hasAuthentication()` returns **FALSE** — no API key is used or stored; built for local servers.
- One admin config form `LlamaCppConfigForm` (route `ai_provider_llama_cpp.settings_form` at
  `/admin/config/ai/providers/llama-cpp`, permission **`administer ai providers`**) writing config
  object **`ai_provider_llama_cpp.settings`** (`host_name`, `port`).
- No submodules, no Drush, no own permissions. Config schema in
  `config/schema/ai_provider_llama_cpp.schema.yml`. `hook_uninstall` clears the State model cache.

## Mechanism (from source)

- `getBaseHost()` builds the endpoint base from config `host_name` (+ `:port` if set); `loadClient()`
  sets the endpoint to `{host}/v1` and constructs the HTTP client, then `createClient()` (from the
  base class) builds the OpenAI SDK client.
- `getConfiguredModels()` calls `models()->list()`, maps each raw model id to a machine name via
  `getMachineName()` (transliterate → lowercase → `[^a-z0-9_]→_`), and stores the mapping in State
  key `ai_provider_llama_cpp.models`. On failure it logs and falls back to the cached State mapping.
- `chat()` / `embeddings()` translate the machine model id back to the raw id (`getModel()`) then
  defer to the base class. `embeddingsVectorSize()` retrieves model metadata to derive the vector size.
- `testConnection()` (called from the form's `validateForm`) does a `models()->list()` to verify the
  host/port before saving.
