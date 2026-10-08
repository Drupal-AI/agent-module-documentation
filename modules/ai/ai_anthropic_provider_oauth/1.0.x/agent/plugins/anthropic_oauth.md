<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Provider plugin `anthropic_oauth` + client/token services

Three classes work together: the AI-module provider plugin, an HTTP client, and a token manager.

## Provider — `src/Plugin/AiProvider/AnthropicOAuthProvider.php`
`#[AiProvider(id: 'anthropic_oauth', label: 'Anthropic (OAuth Token)')]`, extends `AiProviderClientBase`, `implements ChatInterface`, `use ChatTrait`. `create()` pulls in `ai_anthropic_provider_oauth.token_manager` and `.client`.

Key methods:
- `getSupportedOperationTypes()` → `['chat']`. `getSupportedCapabilities()` → `[]`.
- `isUsable()` → TRUE only if a token can be loaded (via token manager), the config `api_key` is set, or `setAuthentication()` supplied one; then checks the operation type is `chat`.
- `getSetupData()` → `key_config_name = 'api_key'` and default models: `chat` = `claude-sonnet-4-6`, `chat_with_image_vision` = `claude-sonnet-4-6`, `chat_with_complex_json` / `chat_with_tools` / `chat_with_structured_response` = `claude-opus-4-6`.
- `getConfiguredModels()` → `fetchAvailableModels()` (live list, cached) or `getHardcodedModels()` fallback; when the `ChatJsonOutput` capability is requested, filters model ids by a Claude-3.5/3.7/4 regex.
- `getModelSettings()` strips `top_p` for Claude Opus/Sonnet 4.x (Anthropic disallows `temperature`+`top_p` together).
- `chat($input, $model_id, $tags)` — the core. Normalizes string/array/`ChatInput`; builds Anthropic `messages` from `ChatMessage`s: text → `text` blocks, `getImages()` → base64 `image` blocks, `getToolsId()` → `tool_result` block (role user), assistant tool calls → `tool_use` blocks; system prompt pulled to top-level `system`. `max_tokens` from `$this->configuration['max_tokens'] ?? 4096`; adds `temperature`/`top_p`/`top_k` from configuration. **`requiresClaudeCodeIdentity()`** (regex `claude-(sonnet|opus)`) prepends a required identity block `"You are Claude Code, Anthropic's official CLI for Claude."` to `system` — needed for OAuth tokens to reach Sonnet/Opus. Tools converted via `convertToolsToAnthropic()` (OpenAI `function`→ Anthropic `name`/`description`/`input_schema`). Calls `AnthropicClient::createMessage()`, then `buildChatOutput()`.
- `buildChatOutput()` concatenates `text` blocks, rebuilds tool calls as `ToolsFunctionOutput`, and sets `TokenUsageDto` from `response['usage']`.
- `fetchAvailableModels()` caches `ai_anthropic_provider_oauth:models` for `models_cache_ttl` (default 86400) via `$this->cacheBackend`; `clearModelsCache()` clears it. `getHardcodedModels()` lists Opus/Sonnet/Haiku 4.x + Claude 3 Haiku.
- `ensureToken()` loads from token manager, else `loadApiKey()`, else throws `AiSetupFailureException`.
- `handleApiException()` maps errors: 401/Unauthorized → logs "token may have expired", clears `apiKey`; "Too Many Requests"/"Request too large" → `AiRateLimitException`; "credit balance is too low" → `AiQuotaException`; otherwise rethrows.

## HTTP client — `src/AnthropicClient.php`
Constants: `BASE_URL = https://api.anthropic.com/v1`, `API_VERSION = 2023-06-01`, `OAUTH_BETA = claude-code-20250219,oauth-2025-04-20`. Uses core `@http_client` (Guzzle).
- `buildHeaders()` sets `Authorization: Bearer <token>` (from `OAuthTokenManager::getValidToken()` unless overridden), `anthropic-version`, `anthropic-beta`, `Content-Type: application/json`. **No `verify => false`** — TLS certificate verification uses Guzzle's default (enabled).
- `get()` / `post()` wrap requests; `decodeResponse()` throws `\RuntimeException` on non-2xx (logging status + body) or bad JSON.
- Convenience: `listModels()`, `testToken()` (calls `listModels()`, returns bool), `getModel()`, `createMessage()` (POST `/messages`, allow-listed options: system, temperature, top_p, top_k, stop_sequences, tools, tool_choice, metadata), `countTokens()` (POST `/messages/count_tokens`).

## Token manager — `src/OAuthTokenManager.php`
Constants `ACCESS_TOKEN_PREFIX = 'sk-ant-oat01-'`, `MIN_TOKEN_LENGTH = 80`. Injects `config.factory`, `key.repository`, logger; `setAnthropicClient()` wired via a service `calls:` configurator (avoids a circular dependency with the client).
- `loadToken()` reads the config `api_key` (a Key id), loads the Key via `KeyRepositoryInterface::getKey()`, returns `$key->getKeyValue()` — so the raw token lives only in the Key backend, never in this module's config.
- `getValidToken()` returns the token or throws `\RuntimeException` if none.
- `isValidAccessToken()` static — prefix + length format check.
- `testTokenWithApi()` delegates to `AnthropicClient::testToken()`.
- `getTokenStatus($testApi = TRUE)` returns `status`/`message`; on success **masks** the token as `substr($token,0,15) . '...' . substr($token,-4)` for display.

## Use from code
```php
$provider = \Drupal::service('ai.provider')->createInstance('anthropic_oauth');
$out = $provider->chat('Summarize Drupal in one line.', 'claude-sonnet-4-6');
$text = $out->getNormalized()->getText();
```
Requires a Key holding a valid setup-token selected at `/admin/config/ai/providers/anthropic-oauth`.
