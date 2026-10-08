<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DeepSeek Provider (ai_provider_deepseek) — agent index

A provider plugin that adds **DeepSeek**'s hosted, OpenAI-compatible chat API to Drupal's **`ai`**
module. Package `AI Providers`. Depends on **`ai` (>=1.0-beta)** and **`key`**. Core `^10 || ^11`.
License GPL-2.0-or-later. Version 1.1.0.

- **The provider plugin — id, operation types, models, client, request flow** →
  [plugins/deepseek_provider.md](plugins/deepseek_provider.md)
- **Install, enable, the settings form, config object & permission** →
  [config/settings.md](config/settings.md)

## What it actually is

- One plugin: `DeepSeekProvider`, `src/Plugin/AiProvider/DeepseekProvider.php`, attribute
  `#[AiProvider(id: 'deepseek', label: 'DeepSeek')]`, extends the `ai` module's
  `AiProviderClientBase` and implements `ChatInterface`.
- `getSupportedOperationTypes()` returns **`['chat']`** only — no chat_with_tools, embeddings,
  moderation, or image ops (despite a `protected bool $moderation = TRUE` field that is never used).
- Talks to DeepSeek via the Composer library **`deepseek-php/deepseek-php-client` `^1.0`**
  (`DeepseekPhp\DeepseekClient`), which wraps a **Guzzle** client. No Drupal `http_client` is used.
- The API key is a **Key entity** id stored in config; the value is read through `key.repository`
  and passed to the client as a Bearer token. `key` is a hard module dependency.

## Provided items (from source)

- **Plugin** `deepseek` (AiProvider). **Config object** `ai_provider_deepseek.settings` (schema in
  `config/schema/`, one key: `api_key`). **API definition** `definitions/api_defaults.yml`
  (chat defaults + a `models` list) read by `getApiDefinition()`.
- **Route** `ai_provider_deepseek.settings` → `/admin/config/ai/providers/deepseek`
  (`Form\SettingsForm`), permission **`administer ai_provider_deepseek configuration`**
  (`restrict access: TRUE`). Menu link under `ai.admin_providers`.
- **Permission** `administer ai_provider_deepseek configuration`
  (`ai_provider_deepseek.permissions.yml`). **hook_help** in `.module`. No install/update hooks,
  no services file, no Drush, no submodules.

## Notes / caveats (accuracy)

- **Model list is inconsistent across the source.** `getConfiguredModels()` hard-codes
  `deepseek-v4-flash` and `deepseek-v4-pro`; `definitions/api_defaults.yml` instead lists
  `deepseek-chat` and `deepseek-coder`; the vendor library's default model constant is
  `DeepSeek-R1`. None of these are DeepSeek's current public model ids — verify against the live
  API before relying on any of them. See [plugins/deepseek_provider.md](plugins/deepseek_provider.md).
- `SettingsForm::submitForm()` saves a `model` value, but `buildForm()` renders **no `model`
  element**, so the saved `model` is always empty and the schema does not define it.
- `chat()` passes its `$input` straight into `$client->query($input)`, which is typed
  `string $content` — a non-string `ChatInput`/message array will not work as-is.
