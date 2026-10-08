<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alibaba Cloud Model Studio AI Provider (ai_provider_alibabacloud) — agent index

An **AI provider plugin** for the Drupal **AI (`ai`) module** that talks to **Alibaba Cloud Model
Studio / DashScope** (Qwen models). Package *AI Providers*. Depends on `ai:ai` and `key:key`. Core
`^10.3 || ^11`. License GPL-2.0-or-later. No permissions of its own, no Drush, no submodules.

## What it provides

- **One AI provider plugin**: `AlibabaCloudProvider` (id **`alibabacloud`**, label *"Alibaba Cloud
  Model Studio"*) in `src/Plugin/AiProvider/AlibabaCloudProvider.php`, extending
  `ai`'s `AiProviderClientBase` and implementing `ChatInterface` + `EmbeddingsInterface`.
  Supported operation types: **`chat`**, **`embeddings`**. Capability: `StreamChatOutput`.
- **A helper service** `ai_provider_alibabacloud.helper` (`AlibabaCloudHelper`) — resolves the base
  URL per mode/region, runs the settings-form connection test, and lists the hard-coded model IDs.
- **Two stream iterators**: `AlibabaCloudStreamIterator` (SSE line parser) and
  `AlibabaCloudChatMessageIterator` (per-delta `ChatMessage` emitter).
- **A settings form** `AlibabaCloudConfigForm` at route
  **`ai_provider_alibabacloud.settings_form`** → `/admin/config/ai/providers/alibabacloud`
  (permission **`administer ai providers`**), menu-linked under `ai.admin_providers`.
- **Config object** `ai_provider_alibabacloud.settings` (schema in `config/schema/`,
  install defaults in `config/install/`) and an **API-parameter definition** file
  `definitions/api_defaults.yml` returned by `getApiDefinition()`.
- `hook_requirements()` (runtime) flags a missing/invalid/empty Key; `hook_install()` seeds default
  models via `ai.provider::defaultIfNone()`.

## Docs

- **Settings form, config object & schema, routes/permissions, install** →
  [config/settings.md](config/settings.md)
- **The provider plugin: operations, API modes, models, streaming, tools, embeddings** →
  [plugins/provider.md](plugins/provider.md)

## Key facts (from source)

- Endpoints are **fixed** per mode+region in `AlibabaCloudHelper::getBaseUrl()` — not admin-settable.
  Compatible: `https://dashscope[-intl].aliyuncs.com/compatible-mode/v1`; native:
  `https://dashscope[-intl].aliyuncs.com/api/v1`.
- API key is loaded from the Key entity named by `key_id` and sent as an `Authorization: Bearer …`
  header via the core `http_client` (Guzzle); it is never placed in a URL or query string.
- All requests go through `$this->httpClient->request('POST', $url, [...])` with TLS verification at
  the Guzzle default (on).
