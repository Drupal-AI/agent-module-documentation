<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Baidu Provider (ai_provider_baidu) — agent index

An **AI provider plugin** for the Drupal **AI (`ai`) module** that calls **Baidu's Qianfan LLM API**
(ERNIE family + a few third-party models). Package *AI Providers*. Depends on `ai:ai` (>=1.0-beta)
and `key:key`. Core `^10 || ^11`. License GPL-2.0-or-later. A deliberately minimal module: no config
schema, no permissions, no install hook, no Drush.

## What it provides

- **One AI provider plugin**: `BaiduProvider` (id **`baidu`**, label *"Baidu"*) in
  `src/Plugin/AiProvider/BaiduProvider.php`, extending `ai`'s `AiProviderClientBase` and implementing
  **`ChatInterface`** only. Operation types: **`chat`**. No streaming/embeddings.
- **One HTTP client service** `ai_provider_baidu.client` (`BaiduClient`, arg `@http_client`) — makes
  the Qianfan API call.
- **One settings form** `SettingsForm` at route **`ai_provider_baidu.settings`** →
  `/admin/config/ai/providers/baidu` (permission **`administer ai providers`**), menu-linked under
  `ai.admin_providers`. Writes config object `ai_provider_baidu.settings` (`api_key` = a Key entity
  id).

## Docs

- **Settings form, config, routes, install** → [config/settings.md](config/settings.md)
- **The provider plugin, model list, and the Qianfan client** → [plugins/provider.md](plugins/provider.md)

## Key facts (from source)

- The endpoint base is hard-coded in `BaiduClient::$serverless = 'https://qianfan.baidubce.com'`;
  `chat()` posts to `/v2/chat/completions`. No admin-overridable host.
- The Key value is loaded via `keyRepository` and sent as `Authorization: Bearer …` through the core
  Guzzle `http_client`; it is never placed in a URL. TLS verification is at the Guzzle default (on) —
  `BaiduClient::makeRequest()` sets no `verify` option.
- `getConfiguredModels('chat')` returns a fixed code list (ERNIE 4.5 turbo/speed/lite/tiny variants,
  `DeepSeek-V3.1-250821`, `Kimi-K2-Instruct`).
- No `config/schema` ships, so `ai_provider_baidu.settings` is schema-less (strict config tooling may
  warn). `submitForm()` also writes a `model` key from an absent form field (saved empty) — a benign
  quirk, not used by the plugin.
