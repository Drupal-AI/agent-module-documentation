<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Ollama Provider registers a local [Ollama](https://ollama.com) server as an AI provider for the Drupal AI module, so chat, embeddings and moderation operations can run against models on your own hardware instead of a hosted API.

---

The module is a single `#[AiProvider(id: 'ollama')]` plugin (`OllamaProvider`) built on the AI module's `OpenAiBasedProviderClientBase` — Ollama exposes an OpenAI-compatible endpoint, so chat and embeddings reuse that client while a small `OllamaControlApi` service talks to Ollama's native REST endpoints (`api/tags` to list installed models, `api/show` for a model's embedding vector and context size, `api/embeddings`, `api/chat`) over the injected `http_client`. Configuration is deliberately tiny: a settings form at `/admin/config/ai/providers/ollama` (permission `administer ai providers`, from the AI module) stores just `host_name` and `port` in `ai_provider_ollama.settings`; the form validates by actually calling `getConfiguredModels()` and refuses to save if the host cannot be reached, and it renders the AI module's standard models table so you can map operation types to the models your Ollama instance has pulled. `hasAuthentication()` returns FALSE and `setAuthentication()` is a no-op — there is no API key, which is why the host/port pair is the entire security boundary. Supported operation types are `chat`, `embeddings` and `moderation`. Moderation is special: it sends the prompt as a chat message and then parses the reply through model-specific rule classes, currently `LlamaGuard3` and `ShieldGemma`; any other model throws "Model not supported for moderation." A `definitions/api_defaults.yml` file declares the tunable chat parameters (max_tokens, temperature, frequency_penalty, presence_penalty, …) that the AI module surfaces in its UI. `hook_install()` migrates settings from the old `provider_ollama` submodule that used to ship inside the AI module and uninstalls it, and `hook_uninstall()` clears the cached model list from state.

---

- Run Drupal AI features against a self-hosted LLM with no data leaving your infrastructure.
- Develop and test AI features locally without spending on hosted API tokens.
- Serve chat completions from a model pulled with `ollama pull llama3`.
- Generate embeddings locally for a Search API vector index.
- Moderate user-submitted content with Llama Guard 3 running on your own server.
- Use ShieldGemma for safety classification without a third-party moderation API.
- Meet data-residency or GDPR constraints that rule out hosted AI providers.
- Point Drupal in DDEV/Docker at an Ollama instance on the host via `host.docker.internal`.
- Compare model quality by switching the configured model per operation type.
- Provide a fallback provider for environments without internet access.
- Keep prompt content confidential in regulated industries.
- Prototype AI agents cheaply before switching to a hosted provider in production.
- Run embeddings and chat on different local models via the AI module's model table.
- Use an Ollama instance shared across a team on an internal network.
- Cut latency by co-locating the model with the Drupal server.
- Avoid per-token cost accounting entirely for internal tooling.
- Migrate from the AI module's old bundled `provider_ollama` submodule automatically on install.
- Verify connectivity from the settings form before saving, avoiding silent misconfiguration.
- Discover which models are available on the server directly in the admin UI.
- Swap the underlying model without touching any Drupal code that calls the AI API.
