<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — settings form, token storage, moderation

## Install & enable
```
composer require drupal/ai_anthropic_provider_oauth
drush en ai_anthropic_provider_oauth
```
Hard deps: `ai`, `key` (`.info.yml`). PHP `>=8.1`, core `^10.3 || ^11`.

## Get a token, store it in a Key
The credential is a **setup-token**, produced by the Claude CLI, not an OAuth grant:
```
npm install -g @anthropic-ai/claude-code
claude setup-token          # sign in; copy the sk-ant-oat01-... token
```
Create a **Key** entity (`/admin/config/system/keys`, type *Authentication*) holding that token — the env-variable provider is preferred for anything beyond a dev box. This module never stores the token itself; it stores the **Key entity id**.

## Route & access
`ai_anthropic_provider_oauth.routing.yml`:
- `ai_anthropic_provider_oauth.settings_form` → path `/admin/config/ai/providers/anthropic-oauth`, form `AnthropicOAuthConfigForm`, requirement `_permission: 'administer ai providers'`.

That permission is defined by the core AI module — this project ships **no** `*.permissions.yml`. Menu link `ai_anthropic_provider_oauth.settings_menu` places it under `ai.admin_providers` (`*.links.menu.yml`).

## Config object & schema
Config object **`ai_anthropic_provider_oauth.settings`** (`config/schema/…schema.yml`, install defaults in `config/install/…settings.yml`):

| key | type | meaning |
|-----|------|---------|
| `api_key` | string | **Key entity id** that holds the setup-token (default `''`). Not the token value. |
| `openai_moderation` | boolean | Enable OpenAI moderation before each request (install default `true`). |
| `models_cache_ttl` | integer | TTL (seconds) for the dynamically fetched model list. No install default; provider falls back to `86400` (24h). |

## The settings form — `src/Form/AnthropicOAuthConfigForm.php`
`ConfigFormBase`, form id `anthropic_oauth_settings`, editable config = `ai_anthropic_provider_oauth.settings`. Injected: `ai.provider` (`AiProviderPluginManager`), `module_handler`, `ai_anthropic_provider_oauth.token_manager`.

`buildForm()` renders:
- A fixed **ToS warning** block (setup-tokens are meant for Claude Code CLI; third-party use may violate Anthropic ToS; recommends `ai_provider_anthropic`).
- A **token status** block from `OAuthTokenManager::getTokenStatus()` (see plugins doc) — runs a live API check and shows a *masked* token.
- A `key_select` element **`api_key`** to pick the Key.
- `openai_moderation` checkbox — enabled only if `ai_provider_openai` is installed **and** `createInstance('openai')->isUsable()` **and** `ai_external_moderation` is installed; otherwise disabled with an explanatory message.
- `moderation_checkbox` ("No Moderation Needed") — an acknowledgement.

`validateForm()`: if `openai_moderation == 0` and the acknowledgement checkbox is empty, sets an error — you must either enable moderation or explicitly accept running without it.

`submitForm()`:
1. Saves `api_key` and `openai_moderation` to config.
2. If `ai_external_moderation` is installed, edits **`ai_external_moderation.settings`** → adds/removes a `moderations` entry for provider `anthropic_oauth` using model `openai__text-moderation-latest`.
3. `setDefaultModels()` calls the provider's `getSetupData()` and, per operation type, `aiProviderManager->defaultIfNone($op_type, 'anthropic_oauth', $model_id)` (won't override an already-set default).

## Operate
Visit the settings page; the status line validates the selected Key's token against `GET /v1/models` live and reports configured / invalid / none. When a token expires (~1 year), re-run `claude setup-token` and update the **Key value** — no config change here is needed.
