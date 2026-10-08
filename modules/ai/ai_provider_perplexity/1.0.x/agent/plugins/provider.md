<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `perplexity` AI provider plugin

`src/Plugin/AiProvider/PerplexityProvider.php` — `#[AiProvider(id: 'perplexity', label: 'Perplexity AI')]`,
extends `Drupal\ai\Base\AiProviderClientBase`, implements `ContainerFactoryPluginInterface` and
`ChatInterface`, uses `ChatTrait`. `create()` additionally injects `key.repository`.

## Operations

`getSupportedOperationTypes()` → `['chat']`. `isUsable()` returns FALSE for the
`ChatWithImageVision` capability (no vision) and FALSE until `api_key` is configured.

### chat()

- Normalizes a `ChatInput`: optional system message from `$this->chatSystemRole`, then each
  message → `{ role, content }`.
- Payload = `model`, `messages`, plus `temperature` (`configuration['temperature'] ?? 0.2`),
  `top_p` (`?? 0.9`), `max_tokens` (`?? 1000`).
- Retry loop: up to `max_retries` (config, default 5) attempts. Before each retry it sleeps
  `retry_delay * 2^(attempt-1)` ms (exponential backoff; `retry_delay` default 2000).
- On response it validates `choices[0].message` exists, builds a `ChatMessage`, and copies
  `response['citations']` into the output metadata (`metadata['citations']`).
- Errors: message containing "rate limit" → `AiRateLimitException`; on the last attempt a
  "timed out"/"timeout" message is rethrown as a friendly timeout `\Exception`, otherwise the
  original exception is rethrown.

## Models

`getConfiguredModels()` returns a fixed map:

- `llama-3.1-sonar-small-128k-online` → *Llama 3.1 Sonar Small (8B)*
- `llama-3.1-sonar-large-128k-online` → *Llama 3.1 Sonar Large (70B)*
- `llama-3.1-sonar-huge-128k-online` → *Llama 3.1 Sonar Huge (405B)*

`getModelSettings()` returns the general config unchanged. `getApiDefinition()` parses
`definitions/api_defaults.yml` (chat temperature/top_p/max_tokens metadata).

## Client / auth

- `setAuthentication($key)` stores the key and nulls the client.
- `getConfig()` → `ai_perplexity.settings`.
- `loadApiKey()` reads the `api_key` config, resolves the Key entity via `keyRepository`, and
  returns its value (`''` if unset).
- `loadClient()` builds a dedicated Guzzle client (timeout/connect_timeout) and an OpenAI client
  with the fixed base URI `https://api.perplexity.ai` (see
  [../config/settings.md](../config/settings.md)). `getClient()` exposes the raw OpenAI client.
