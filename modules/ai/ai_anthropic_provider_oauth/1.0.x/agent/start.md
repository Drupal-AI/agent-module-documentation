<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Anthropic Provider (OAuth) (ai_anthropic_provider_oauth) — agent index

Registers one AI-module **chat provider**, `anthropic_oauth` ("Anthropic (OAuth Token)"), that authenticates to the **native Anthropic Messages API** with a long-lived **`claude setup-token`** Bearer token (prefix `sk-ant-oat01-`, ~1 year, no refresh) stored via the **Key module**. Despite the name there is **no OAuth authorization-code / callback flow** — the token is pasted into a Key and referenced by id. Package `AI Providers`. Core `^10.3 || ^11`, PHP `>=8.1`. Version `1.0.0-beta4`. License GPL-2.0-or-later. Depends on `ai`, `key`.

**Dev/personal only** — the settings form warns third-party use of setup-tokens may violate Anthropic's ToS; use `ai_provider_anthropic` with official API keys in production.

## Solution docs
- **Settings form, config object, Key-based token storage, moderation, routes** → [config/settings.md](config/settings.md)
- **The `anthropic_oauth` provider plugin + `AnthropicClient` / `OAuthTokenManager` services** → [plugins/anthropic_oauth.md](plugins/anthropic_oauth.md)

## What it provides (from source)
- **Plugin**: `AnthropicOAuthProvider` (`src/Plugin/AiProvider/AnthropicOAuthProvider.php`), `#[AiProvider(id: 'anthropic_oauth')]`, extends `AiProviderClientBase implements ChatInterface`. Supported operation types: `chat` only.
- **Services** (`*.services.yml`): `ai_anthropic_provider_oauth.token_manager` (`OAuthTokenManager`), `ai_anthropic_provider_oauth.client` (`AnthropicClient`), and a `logger.channel.ai_anthropic_provider_oauth`.
- **Form**: `AnthropicOAuthConfigForm` (`ConfigFormBase`), form id `anthropic_oauth_settings`.
- **Route** (`*.routing.yml`): `ai_anthropic_provider_oauth.settings_form` → `/admin/config/ai/providers/anthropic-oauth`, permission `administer ai providers` (a core-AI permission — this module defines **no** permissions.yml). Menu link under `ai.admin_providers`.
- **Config**: object `ai_anthropic_provider_oauth.settings` (`api_key` = Key id, `openai_moderation` bool, `models_cache_ttl` int); schema in `config/schema/`, install defaults in `config/install/`.
- No entities, no Drush, no hooks, no submodules.
