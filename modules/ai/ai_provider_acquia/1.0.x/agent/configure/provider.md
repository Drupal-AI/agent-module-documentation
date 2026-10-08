<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Acquia AI Gateway provider

**Form:** `Drupal\ai_provider_acquia\Form\AcquiaConfigForm`
**Route:** `ai_provider_acquia.settings_form` — `/admin/config/ai/providers/acquia`
**Permission:** `administer ai providers` (from the AI module).
**Requires:** `ai:ai`, `key:key`.

## Credentials (never hardcoded)
- **Host:** `Settings::get('acquia_ai_gateway_url', getenv('AI_GATEWAY_URL'))` — settings.php override or the `AI_GATEWAY_URL` env var.
- **API key:** resolved through the Key module under the hardcoded key name `ai_provider_acquia` (`getKey('ai_provider_acquia')?->getKeyValue()`). `AcquiaAIEnvKeyResolver` exposes the `AI_GATEWAY_API_KEY` env var as a Key value (id `ai_gateway_key`) so the secret stays in the environment, not in config.

If either host or key is missing the form shows an error and renders nothing actionable.

## What the form does
On build it instantiates `AcquiaAiClient($http_client, $host, $api_key)` and calls `/key/info` and `/model/info` to show the key alias, spend, budget, blocked flag, and a per-model capability table. On submit it maps discovered models to AI operation types via the provider's `getSetupData()['default_models']` and calls `aiProviderManager->defaultIfNone()`, then redirects to `ai.settings_form`.

## Transport / TLS
`AcquiaAiClient` uses the injected core `http_client` (Guzzle) with **default TLS verification** — no `verify => false`, no disabled `CURLOPT_SSL_VERIFYPEER`. Requests authenticate with an `Authorization: Bearer <api_key>` header (`getRequest()`), never a query-string secret. The chat/embeddings path extends `OpenAiBasedProviderClientBase` with the same host/key.

## Provider plugin
`AcquiaAiProvider` (`OpenAiBasedProviderClientBase`, id `acquia`) supports chat, chat-with-image/tools/structured-response, embeddings, moderation, text-to-image, text-to-speech and image/audio-to-video; `loadClient()` sets the endpoint from the configured host and passes the Key value as the API key.
