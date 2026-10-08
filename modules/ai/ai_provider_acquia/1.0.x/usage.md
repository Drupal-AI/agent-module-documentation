<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia AI Gateway is an AI-module provider plugin that connects Drupal's AI framework to Acquia's hosted AI Gateway, giving access to multiple LLMs through one endpoint.

---
The core AI module abstracts operations (chat, embeddings, moderation, image/speech generation) behind provider plugins. This module supplies the `acquia` provider, backed by Acquia's LiteLLM-based gateway, so a subscription's models become available to any AI-module feature without per-model wiring. The provider extends `OpenAiBasedProviderClientBase` and advertises chat (with image-vision, tools and structured-response variants), embeddings, moderation, text-to-image, text-to-speech and image/audio-to-video.

Credentials are never hardcoded. The gateway host comes from `Settings::get('acquia_ai_gateway_url', getenv('AI_GATEWAY_URL'))` and the API key is resolved through the Key module under the fixed key name `ai_provider_acquia`; the bundled `AcquiaAIEnvKeyResolver` surfaces the `AI_GATEWAY_API_KEY` environment variable as a Key value so the secret stays in the environment. The `AcquiaAiClient` talks to the gateway over the injected core `http_client` (Guzzle) with default TLS verification — there is no `verify => false` — and authenticates with an `Authorization: Bearer` header rather than a query-string secret. The config form calls `/key/info` and `/model/info` to display key spend/budget/blocked status and per-model capabilities, and on submit assigns discovered models as operation defaults via `defaultIfNone()`.

Setup: install with `ai` and `key`, provide the `AI_GATEWAY_URL` / `AI_GATEWAY_API_KEY` values (usually pre-provisioned by Acquia), visit `/admin/config/ai/providers/acquia` (permission `administer ai providers`) to confirm the connection, then pick Acquia models per capability on the AI settings form.
---
- Use Acquia's hosted AI Gateway as an AI-module provider
- Access multiple LLMs from one subscription and endpoint
- Run chat completions through the Acquia gateway
- Run chat-with-image-vision requests
- Run chat-with-tools / function-calling requests
- Run chat-with-structured-response requests
- Generate text embeddings for vector search
- Run content moderation via the gateway
- Generate images from text (text-to-image)
- Generate speech from text (text-to-speech)
- Store the gateway API key in the Key module
- Resolve the API key from the `AI_GATEWAY_API_KEY` env var
- Set the gateway host via `AI_GATEWAY_URL` or settings.php
- Inspect key spend, budget and blocked status in the admin form
- Browse per-model supported capabilities in the admin form
- Assign default Acquia models per AI operation type
- Verify connectivity with the gateway before enabling features
- Keep AI secrets out of exported configuration
- Authenticate to the gateway with a Bearer token over TLS
- Power AI submodules (summaries, translation, tagging) via Acquia
- Override the auto-resolved key with a manually created Key entity
