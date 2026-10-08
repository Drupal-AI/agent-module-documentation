<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Moonshot AI Provider (ai_provider_moonshot) — agent index

An **AI-module provider plugin** that routes `chat` operations to **Moonshot AI (Kimi)** via
their OpenAI-compatible API. Package `AI Providers`. Depends on **`ai`** and **`key`** (and the
`openai-php/client` library). Core `^10.3 || ^11`. License GPL-2.0-or-later. Version dir `1.2.x`
(release 1.2.1).

- **Settings form, config keys, endpoint, key wiring** → [config/settings.md](config/settings.md)
- **The `moonshot` provider plugin: chat, images, tools, models** → [plugins/provider.md](plugins/provider.md)

## What it actually is

- One plugin: `MoonshotProvider` (id **`moonshot`**, label *Moonshot AI*) in
  `src/Plugin/AiProvider/MoonshotProvider.php`, extending
  `Drupal\ai\Base\AiProviderClientBase`, implementing `ChatInterface`, using `ChatTrait`.
- Supported operation types (`getSupportedOperationTypes()`): **`chat`** only.
- Talks to Moonshot through the OpenAI PHP SDK; default endpoint
  `https://api.moonshot.cn/v1` (overridable per site via the `host` config).
- One settings form: `SettingsForm` (`src/Form/SettingsForm.php`), config object
  `ai_provider_moonshot.settings`.

## Provides

- **Plugin:** `ai_provider` instance `moonshot`.
- **Route:** `ai_provider_moonshot.settings_form` → `/admin/config/ai/providers/moonshot`
  (`_permission: 'administer ai providers'`); menu link under *AI → Providers* (weight 10).
- **Config object:** `ai_provider_moonshot.settings` (keys `api_key`, `host`) — no config
  schema, no config/install, no permissions, services, hooks, or Drush commands.
- **README.md** with install/config steps.

## Dependencies & operation

- Requires the `ai` framework and `key` module. The API key is a **Key entity** (filtered to
  type `authentication`) selected on the settings form; the API host is a required text field
  defaulting to `https://api.moonshot.cn/v1`.
- `getConfiguredModels('chat')` returns a hard-coded list: `kimi-k3`, `kimi-k2.7-code`,
  `kimi-k2.7-code-highspeed`, `kimi-k2.6`.
- Chat supports image messages (base64 data URLs), tool/function calling, structured
  JSON-schema responses, and the `tool` role. No streaming or embeddings.
- `getSetupData()` seeds default models (`chat` → `moonshot-lite`, and the vision/json/tools/
  structured variants → `moonshot-pro`).
