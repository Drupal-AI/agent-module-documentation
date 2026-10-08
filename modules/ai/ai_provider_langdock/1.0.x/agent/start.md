<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Langdock Provider for Drupal AI (ai_provider_langdock) — agent index

An **AI-module provider plugin** that routes `chat` and `embeddings` operations to the
**Langdock** OpenAI-compatible LLM API. Package `AI`. Depends on **`ai`** and **`key`**.
Core `^10.5 || ^11.2`. License GPL-2.0-or-later. Version dir `1.0.x` (release 1.0.0-beta1).

- **Settings form, config keys, endpoint, key wiring** → [config/settings.md](config/settings.md)
- **The `langdock` provider plugin: operations, streaming, tools, models** → [plugins/provider.md](plugins/provider.md)

## What it actually is

- One plugin: `LangdockProvider` (id **`langdock`**, label *Langdock*) in
  `src/Plugin/AiProvider/LangdockProvider.php`, extending
  `Drupal\ai\Base\OpenAiBasedProviderClientBase` and using `ChatTrait`. Attribute
  `#[AiProvider(id: 'langdock', ...)]`.
- Supported operation types (`getSupportedOperationTypes()`): **`chat`**, **`embeddings`**.
- Talks to Langdock through the OpenAI PHP SDK; default endpoint
  `https://api.langdock.com/openai/eu/v1` (overridable per site via the `host` config).
- One streamed-message helper: `LangdockChatMessageIterator` extends the AI module's
  `StreamedChatMessageIterator` (`src/LangdockChatMessageIterator.php`).
- One settings form: `SettingsForm` (`src/Form/SettingsForm.php`), config object
  `ai_provider_langdock.settings`.

## Provides

- **Plugin:** `ai_provider` instance `langdock`.
- **Route:** `ai_provider_langdock.settings_form` → `/admin/config/ai/providers/langdock`
  (`_permission: 'administer ai providers'`); menu link under *AI → Providers*.
- **Config object:** `ai_provider_langdock.settings` (keys `api_key`, `host`) — no config
  schema file ships; no permissions, services, hooks, or Drush commands.
- **Definitions:** `definitions/api_defaults.yml` (chat + embeddings input/config defaults).

## Dependencies & operation

- Requires the `ai` framework and `key` module. The API key is a **Key entity** selected on
  the settings form; the endpoint host is a required text field. Default models are set on
  save via `AiProviderPluginManager::defaultIfNone()` (`getSetupData()`: chat `gpt-5.2`,
  embeddings `text-embedding-ada-002`).
- Chat supports streaming, Fiber-based async streaming, tool/function calling, and
  structured JSON-schema responses. Rate-limit / quota errors are mapped to
  `AiRateLimitException` / `AiQuotaException`.
