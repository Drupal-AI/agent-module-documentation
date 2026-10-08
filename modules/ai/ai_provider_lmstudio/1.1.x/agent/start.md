<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LM Studio Provider (ai_provider_lmstudio) — agent index

A **provider plugin for the Drupal AI module** (`drupal/ai`) that connects a local **LM Studio**
server through its OpenAI-compatible HTTP API. Package *AI Providers*. Requires **`ai`**
(`drupal/ai:^1.2`). Core `^10.2 || ^11`. License GPL-2.0-or-later. Version 1.1.0.

- **Install, settings form, config object, routes/permission, the control API, and model discovery** →
  [config/settings.md](config/settings.md)

## What it actually is

- One plugin: `LmStudioProvider` (AiProvider id **`lmstudio`**, label *"LM Studio"*), in
  `src/Plugin/AiProvider/LmStudioProvider.php`, extending drupal/ai's
  `OpenAiBasedProviderClientBase` and using `ChatTrait`.
- Supported operation types: **`chat`** and **`embeddings`**.
- One service: **`ai_provider_lmstudio.control_api`** → `LmStudioControlApi`
  (`src/LmStudioControlApi.php`), a thin Guzzle wrapper (`@http_client`) used for the `/v1/models`
  listing.
- One admin config form `LmStudioConfigForm` (route `ai_provider_lmstudio.settings_form` at
  `/admin/config/ai/providers/lmstudio`, permission **`administer ai providers`**) writing config
  object **`ai_provider_lmstudio.settings`** (`host_name` string, `port` integer).
- No API key: `hook_update_11200` clears a legacy `api_key` value; the server is unauthenticated.
- No submodules, no Drush, no own permissions. Config schema + install defaults present.

## Mechanism (from source)

- `getBaseHost()` reads `host_name` (+ `:port`) from `ai_provider_lmstudio.settings`; `loadClient()`
  sets the OpenAI SDK endpoint to `{host}[:port]/v1` and calls `createClient()` (base class).
- `getConfiguredModels()` calls the control API's `getModels()` (a `GET v1/models`) and maps each
  returned `id` to itself (no machine-name rewriting). On error it logs to channel
  `ai_provider_lmstudio` and, for users with `administer ai providers`, shows a messenger error;
  returns `[]`.
- `LmStudioControlApi::makeRequest()` builds `{baseHost}/{path}`, sets 120s connect/read/timeout and
  a JSON `Content-Type`, and issues the request via the injected Guzzle `@http_client`.
- `hook_install()` copies config from the older AI-core submodule `provider_lmstudio` and uninstalls
  it; chat parameter defaults live in `definitions/api_defaults.yml`.
