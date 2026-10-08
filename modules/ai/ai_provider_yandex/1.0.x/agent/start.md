<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# YandexGPT Provider (ai_provider_yandex) — agent index

An AI-provider plugin that registers **YandexGPT** (Yandex Cloud foundation models) with the Drupal AI
module and routes chat to `https://llm.api.cloud.yandex.net/v1`.

- **Version dir:** 1.0.x · **Core:** `^10.3 || ^11` · **Package:** AI Providers
- **Depends on:** `ai:ai`, `key:key`.
- **Provides:** one AI provider plugin `id: yandex` (`src/Plugin/AiProvider/YandexProvider.php`),
  which extends the AI module's `OpenAiBasedProviderClientBase` (uses `ChatTrait`).
- **Operation types:** `chat` only.
- **Models:** `yandexgpt-lite/latest`, `yandexgpt-lite/rc`, `yandexgpt/latest`, `yandexgpt/rc`.
- **Config object:** `ai_provider_yandex.settings` with two keys: `api_key` (Key-module key id) and
  `catalog_id` (Yandex Cloud folder identifier).
- **Route / form:** `ai_provider_yandex.settings_form` at `/admin/config/ai/providers/yandex`
  (`YandexConfigForm`), permission `administer ai providers`.
- **Menu link:** `ai_provider_yandex.settings_menu` under `ai.admin_providers`.

## How the model id is built

`YandexProvider::chat()` calls `setEndpoint('https://llm.api.cloud.yandex.net/v1')`, reads
`catalog_id` from config, rewrites the model id to `gpt://<catalog_id>/<model_id>`, then delegates to
`OpenAiBasedProviderClientBase::chat()`. All HTTP transport, auth-header handling and response mapping
live in that base class.

No permissions, Drush commands, services, entities or submodules of its own.

## Solution docs

- Configuration (API key + catalog id): [`config/settings.md`](config/settings.md)
- The `yandex` provider plugin (models, endpoint, model-id rewrite): [`plugins/yandex_provider.md`](plugins/yandex_provider.md)
