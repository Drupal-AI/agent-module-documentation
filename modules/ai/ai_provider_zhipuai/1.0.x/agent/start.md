<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Zhipuai Provider (ai_provider_zhipuai) — agent index

Registers **Zhipu AI (GLM)** as a **chat** provider for `drupal/ai`. Package **AI
Providers**. Version **1.0.1**. Core `^10 || ^11`. License GPL-2.0-or-later.

Depends on **`ai` (>=1.0-beta)** and **`key`**. No permissions, config schema, Drush, or
plugin types of its own.

## What it provides

- **AI provider plugin** `zhipuai` (`Plugin\AiProvider\ZhipuaiProvider`, extends
  `Drupal\ai\Base\AiProviderClientBase`, implements `ChatInterface`) →
  [plugins/provider.md](plugins/provider.md)
  - Supported operation types: **`chat`** only.
  - Models: `glm-4.5`, `glm-4.5-air`, `glm-4.5-x`, `glm-4.5-airx`, `glm-4.5-flash`.
- **HTTP client service** `ai_provider_zhipuai.client` (`ZhipuaiClient`, constructed with
  core `@http_client`) — talks to `https://open.bigmodel.cn/api/paas/v4`.
- **Settings form + route** `ai_provider_zhipuai.settings` at
  `/admin/config/ai/providers/zhipuai` (`Form\SettingsForm`, permission
  **`administer ai providers`**) → [config/settings.md](config/settings.md)
  - Menu link under the AI module's *Providers* menu (`ai.admin_providers`).

## Mechanism (from source)

- The API key is stored as a **Key entity reference** (config
  `ai_provider_zhipuai.settings:api_key`, a `key_select`), loaded at call time via
  `keyRepository->getKey(...)->getKeyValue()` (`ZhipuaiProvider::loadApiKey()`).
- `ZhipuaiProvider::chat()` builds the request and calls
  `ZhipuaiClient::textGeneration('/chat/completions', $model_id, $input)`, decodes the
  JSON, and returns a `ChatOutput` wrapping a `ChatMessage`.
- `ZhipuaiClient::makeRequest()` sends the key as `Authorization: Bearer <key>` over the
  injected Guzzle client with 120s connect/read timeouts.

## Files

- `src/Plugin/AiProvider/ZhipuaiProvider.php` — the provider plugin.
- `src/ZhipuaiClient.php` — the Guzzle HTTP client wrapper.
- `src/Form/SettingsForm.php` — the settings form.
