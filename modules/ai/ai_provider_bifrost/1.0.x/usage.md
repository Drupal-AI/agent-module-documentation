<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bifrost AI Provider registers the self-hosted Bifrost LLM gateway as a provider for the Drupal AI module, so AI features reach whatever models the gateway routes to through a single virtual key.

---

Bifrost AI Provider is a provider plugin (`bifrost`) for the Drupal AI (`ai`) module. Bifrost is a self-hosted, OpenAI-wire-compatible gateway that fronts multiple upstream vendors (OpenAI, Anthropic, local Ollama, etc.) behind one governed entry point with virtual keys, budgets, and rate limits. The plugin extends the AI module's `OpenAiBasedProviderClientBase` and uses the OpenAI PHP client pointed at your gateway's base URL, authenticating with Bifrost's `x-bf-vk` virtual-key header (not a standard Bearer token). It supports chat, embeddings, text-to-image, text-to-speech, and speech-to-text operation types (whatever your gateway actually routes). Available models are discovered live from the gateway's `/v1/models` endpoint and cached for five minutes; because Bifrost exposes no capability-metadata endpoint, the module classifies each model into operation types with a best-effort heuristic (OpenRouter-style `architecture` modality metadata when present, otherwise model-id substring sniffing, with `rerank` models excluded). Configuration — the gateway host (a validated http/https base URL ending in `/v1`) and a Key-module virtual key — lives at `/admin/config/ai/providers/ai_provider_bifrost` (permission: `administer ai providers`), and saving runs a live connectivity check and invalidates the cached model list.

- Add a self-hosted Bifrost gateway as an AI-module provider.
- Reach many upstream vendors (OpenAI, Anthropic, Ollama, …) through one credential.
- Centralize model access, budgets, and rate limits at the gateway.
- Authenticate with a Bifrost virtual key via the `x-bf-vk` header.
- Store the virtual key as a Key entity instead of plain config.
- Point Drupal at your gateway's base URL (validated, must include `/v1`).
- Discover available models automatically from the gateway (no static list).
- Use chat models routed through the gateway for AI Chatbot / assistants.
- Use gateway-routed embedding models for AI Search / Search API AI.
- Generate images via text-to-image models the gateway routes.
- Generate speech via text-to-speech models the gateway routes.
- Transcribe audio via speech-to-text models the gateway routes.
- Respect per-key model access and budgets configured in Bifrost.
- Get a live connectivity check when saving the settings form.
- Have the cached model list refresh automatically after config changes.
- Let model discovery pick up newly granted models on the next request.
- Make Bifrost selectable anywhere the AI module offers a provider choice.
- Avoid installing a separate provider module per upstream vendor.
- Keep AI traffic flowing through a single governed egress point.
- Swap the routed backend without changing Drupal-side configuration.
