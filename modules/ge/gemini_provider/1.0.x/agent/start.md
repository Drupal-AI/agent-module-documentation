<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gemini Provider — agent index

Registers the **`gemini`** AI provider plugin for the Drupal **AI (`ai`)** module, backed by
`google-gemini-php/client`. Lets AI-module features run on Google Gemini. Depends on `ai` and
`key`. Defines **no permissions and no Drush** of its own.

- **Settings: the API Key (Key entity), config keys, route/permission, safety settings** →
  [configure/settings.md](configure/settings.md)
- **The `gemini` AiProvider plugin: operation types, default models, embeddings sizes,
  model listing, streaming** → [plugins/gemini-provider.md](plugins/gemini-provider.md)
- **Programmatic use via the AI provider service and per-request tuning** →
  [api/usage.md](api/usage.md)

Key facts: plugin id `gemini` (`GeminiProvider`, `#[AiProvider(id: 'gemini')]`). Config object
`gemini_provider.settings` with `api_key` (a **Key** entity id chosen via `key_select`) and
`safety_settings` (`HarmCategory` → `HarmBlockThreshold`). Settings route
`gemini_provider.settings_form` → `/admin/config/ai/providers/gemini`, permission
`administer ai providers` (from the AI module). Supported operations: `chat`, `embeddings`,
`text_to_image`, `text_to_speech`, `speech_to_text`. Default chat model
`models/gemini-2.5-flash`, default embeddings `models/gemini-embedding-001`. Listing models
(`getConfiguredModels()`) hits the live Gemini API and needs a valid key.
