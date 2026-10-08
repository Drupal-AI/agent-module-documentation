<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bifrost AI Provider (ai_provider_bifrost) — agent index

An **AI provider plugin** for the Drupal **AI (`ai`) module** that talks to a self-hosted **Bifrost
LLM gateway** (OpenAI-wire-compatible, fronting many vendors). Package *AI Providers*. Depends on
`ai:ai` (>=1.4) and `key:key` (>=1.18). Core `^11 || ^12`, **PHP >= 8.3**. License GPL-2.0-or-later.
No permissions of its own, no Drush, no install hook, no submodules.

## What it provides

- **One AI provider plugin**: `BifrostAiProvider` (id **`bifrost`**, label *"Bifrost"*) in
  `src/Plugin/AiProvider/BifrostAiProvider.php`, extending `ai`'s
  `OpenAiBasedProviderClientBase`. Supported operation types: **`chat`, `embeddings`,
  `text_to_image`, `text_to_speech`, `speech_to_text`**.
- **A model-listing client** `BifrostAiClient` (`src/Bifrost/BifrostAiClient.php`) — a plain class
  (constructed in code, not a service) that calls `GET <host>/models` with the `x-bf-vk` header.
- **A settings form** `BifrostConfigForm` at route **`ai_provider_bifrost.settings_form`** →
  `/admin/config/ai/providers/ai_provider_bifrost` (permission **`administer ai providers`**),
  menu-linked under `ai.admin_providers`.
- **Config object** `ai_provider_bifrost.settings` (`api_key`, `host`) with schema in `config/schema/`.
- **API-parameter definitions** `definitions/api_defaults.yml` (chat / embeddings / text_to_image /
  text_to_speech / speech_to_text parameter schema).
- **Unit test** `tests/src/Unit/BifrostAiProviderTest.php`.

## Docs

- **Settings form, config, schema, routes, model-list caching** → [config/settings.md](config/settings.md)
- **The provider plugin, model discovery/heuristics, the Bifrost client** →
  [plugins/provider.md](plugins/provider.md)

## Key facts (from source)

- The gateway base URL is an **admin-set** config value (`host`), validated in
  `BifrostConfigForm::validateForm()`: required, `FILTER_VALIDATE_URL`, scheme must be `http`/`https`,
  no trailing slash — writable only with `administer ai providers`.
- Auth uses Bifrost's virtual key as the **`x-bf-vk`** header (set via
  `\OpenAI::factory()->withHttpHeader('x-bf-vk', $key)`), never a URL param. The base class's Bearer
  header alone is not sufficient for Bifrost, which is why `createClient()` is overridden.
- All HTTP goes through the core Guzzle `http_client` (injected via `withHttpClient()`); no request
  option disables TLS verification (Guzzle default, on).
- `isUsable()` requires both a host and a **resolvable** Key value (not just a stored key id).
- Model list is fetched from `/models`, cached 5 min under tag `ai_provider_bifrost:models`, and that
  tag is invalidated on config save; empty lists are deliberately not cached.
- Form errors are generic ("see the logs for details") and exceptions are logged via
  `Error::logException()` — backend/connection detail is not echoed to the UI.
