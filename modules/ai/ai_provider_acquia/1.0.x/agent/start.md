<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Acquia AI Gateway (ai_provider_acquia) — agent index

**AI-module provider plugin routing operations through Acquia's hosted AI Gateway (LiteLLM).**

- **Version:** 1.0.x
- **Core:** `^10.4 || ^11`  · package AI Providers · requires `ai:ai`, `key:key`
- **Route:** `ai_provider_acquia.settings_form` (`/admin/config/ai/providers/acquia`, permission `administer ai providers`).
- **Provider:** `AcquiaAiProvider` (id `acquia`, extends `OpenAiBasedProviderClientBase`) — chat + vision/tools/structured, embeddings, moderation, text-to-image, text-to-speech, image/audio-to-video.
- **Client:** `AcquiaAiClient` (core `http_client`, Bearer-token auth, `/key/info` `/model/info` `/model_hub`).
- **Secrets:** host via `Settings::get('acquia_ai_gateway_url', getenv('AI_GATEWAY_URL'))`; API key via Key module (`ai_provider_acquia`), env var `AI_GATEWAY_API_KEY` surfaced by `AcquiaAIEnvKeyResolver`.

**Security:** admin route gated by `administer ai providers`; no anonymous or mutating public endpoints. Reviewed for the AI-provider hazard classes — API key is Key-module/env-var backed (no hardcoded secret), sent as an `Authorization: Bearer` header (not a query string), over the core Guzzle `http_client` with **default TLS verification (no `verify => false`, no disabled SSL_VERIFYPEER)**. No security findings.

See [configure/provider.md](configure/provider.md)
