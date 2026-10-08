<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A universal, multi-instance AI provider for the Drupal AI module that models each OpenAI-compatible (or native) inference server and its models as configuration entities, with optional smart-routing, fact-check and content-governance submodules.

---

AI Provider: Universal registers a single provider plugin (`universal`) with the Drupal AI (`drupal/ai`) ecosystem, but instead of one hard-wired endpoint it lets a site run many inference servers side by side. Each server is an `ai_universal_server` config entity (a backend plugin id, host/port, a Key-entity API key, timeout, an operation-type filter, and optional per-server daily request/token limits); each discovered model is an `ai_universal_model` config entity carrying cost rates, quality tier, context length, sampling and extra-parameter overrides and capability tags. Twelve `AiServerBackend` plugins cover OpenAI-compatible servers (llama.cpp, vLLM, LM Studio, Ollama, Groq, OpenRouter, Fireworks, Hugging Face, LiteLLM, DeepSeek, amazee.ai, xAI/Grok) plus a native Anthropic Messages backend, and other modules can add more without patching. Model entity ids use dot-separated `server.model` form for compatibility with AI core and ai_search. Three optional submodules build on the provider: a cost-aware Smart Router, a claim-level Fact Check / plagiarism / AI-detection scanner, and a Content Governance layer for AI Act Art. 50 transparency. Requires Drupal ^11.1 || ^12, PHP ^8.3, `drupal/ai` ^1.3 and `drupal/key`.

---

- Run several local and cloud LLM endpoints concurrently under one Drupal AI provider.
- Point the AI module (chat, embeddings, moderation, rerank, text-to-image) at a self-hosted llama.cpp / vLLM / LM Studio server via the `openai_compatible` backend with a custom base URL.
- Add a local or remote Ollama instance and auto-enrich model metadata from its `/api/show` endpoint.
- Use commercial catalogs (OpenRouter, Groq, Fireworks, Hugging Face, DeepSeek, xAI/Grok, amazee.ai, LiteLLM) as servers, each with its own Key-entity credential.
- Talk to Anthropic Claude models over their native Messages API through the shipped `anthropic` backend.
- Store every discovered model as an exportable `ai_universal_model` config entity and tune its cost, quality tier, context length and sampling per site.
- Cap spend by setting per-server daily request and token limits with a grace percentage and an alert threshold.
- Filter which models a server exposes with an allow/deny model filter.
- Override reasoning effort and sampling (temperature, top_p, penalties) per model without touching code.
- Send provider-native extra request parameters (tools, JSON mode, etc.) verbatim per model via the extra-params overrides.
- Discover and persist models for one or all servers from the CLI with `drush aip:discover-models`.
- Smoke-test a configured model from the CLI with `drush aip:chat`.
- Make universal models selectable as the default provider for any AI operation type in the AI settings.
- Use universal models as the embeddings engine for `ai_search` indexes.
- Add a virtual "Auto:" route model (Smart Router) that picks the cheapest capable model per request and fails over on rate/budget limits.
- Review a routing/savings decision log to see which model served each request and what it saved.
- Fact-check a node's generated or edited content claim by claim against a local `ai_search` index or web evidence (Tavily), with escalation to a stronger model.
- Scan pasted text or a public URL for factual support, readability, AI-likelihood and verbatim plagiarism from an admin page or block.
- Schedule background fact-check scans on node save via scan profiles and react to results with ECA/Workflow through `ContentReviewEvent`.
- Curate trusted/distrusted web sources as `trusted_site` nodes and seed them from Media Bias/Fact Check ratings.
- Attach a default AI-core Guardrail set to provider calls that arrive without one.
- Append a visible AI-disclosure suffix or an invisible machine-readable AI-origin marker to chat responses for Art. 50 transparency.
- Emit AI-origin provenance events on successful generations for downstream ECA/Workflow policy.
- Bootstrap AI-disclosure fields and a governance starter with the shipped recipes.
- Build a custom backend for a non-OpenAI protocol by implementing an `AiServerBackend` plugin (and optionally `AiInferenceBackendInterface`).
