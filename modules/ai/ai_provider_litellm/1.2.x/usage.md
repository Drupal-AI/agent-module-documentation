LiteLLM AI Provider registers a self-hosted [LiteLLM](https://github.com/BerriAI/litellm) proxy as a provider plugin for the Drupal AI module, so any LLM LiteLLM fronts (OpenAI, Anthropic, Azure, local models, …) becomes usable through Drupal's unified AI operation types.

---

The module provides one AI provider plugin, `litellm` (`LiteLlmAiProvider`), that extends the AI module's `OpenAiBasedProviderClientBase` — LiteLLM speaks an OpenAI-compatible API, so chat, embeddings, moderation, text-to-image, text-to-speech and audio operations are handled by the OpenAI base client pointed at your LiteLLM `host`. A small `LiteLlmAiClient` adds LiteLLM-specific REST calls: `GET /model/info` to enumerate models (each mapped to a `Model` DTO whose capability flags — chat, embeddings, image/audio input/output, moderation — drive which models are offered per operation type) and `GET /key/info` to show key alias, spend, budget and blocked status on the settings form. Configuration lives in `ai_provider_litellm.settings` (`api_key`, `host`, `moderation`) and is edited at `/admin/config/ai/providers/ai_provider_litellm` (route `ai_provider_litellm.settings_form`, permission `administer ai providers`); the API key is selected from a **Key** entity via a `key_select` element, and the host must be a valid URL with no trailing slash. Saving validates the credentials by listing models against the proxy. As of 1.2.x the OpenAI provider module is no longer a hard runtime requirement (the install hook notifies you it can be uninstalled). Model-list filtering, rate-limit/quota exception mapping, and embeddings vector-size probing are handled in the provider plugin.

---

- Use a self-hosted LiteLLM proxy as the AI provider behind Drupal AI features.
- Route Drupal AI chat completions through LiteLLM to any backing LLM.
- Generate embeddings via LiteLLM for the AI Search / vector store modules.
- Run moderation requests through LiteLLM before each AI call.
- Offer text-to-image generation from LiteLLM-fronted image models.
- Offer text-to-speech / audio-to-audio operations via LiteLLM.
- Centralize multiple model vendors behind one OpenAI-compatible endpoint.
- Swap the backing model without changing Drupal configuration (LiteLLM routes it).
- Enforce per-key spend budgets defined in LiteLLM and surface spend in the admin form.
- Store the LiteLLM API key as a Key entity instead of raw config.
- Point Drupal at a private/internal LiteLLM host URL.
- Let the provider auto-discover available models from `/model/info`.
- Filter offered models per operation type by LiteLLM capability flags.
- Show key alias, spend, max budget and blocked status on the settings page.
- Map LiteLLM rate-limit responses to AI rate-limit exceptions for graceful handling.
- Map LiteLLM budget-exceeded responses to AI quota exceptions.
- Probe embeddings vector size dynamically when the model doesn't report it.
- Replace a direct OpenAI provider with LiteLLM to add fallback/loadbalancing.
- Use LiteLLM's own moderation instead of OpenAI moderation by toggling the setting off.
- Serve on-prem/air-gapped LLMs to Drupal through a local LiteLLM gateway.
