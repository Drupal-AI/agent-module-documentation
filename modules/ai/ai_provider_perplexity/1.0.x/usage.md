<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds Perplexity AI (Sonar online models) as a selectable chat provider for the Drupal AI module, exposing citations returned by Perplexity.

---

`ai_provider_perplexity` (module machine name `ai_perplexity`) registers a single `AiProvider` plugin (`perplexity`) that extends the Drupal AI module's `AiProviderClientBase` and drives the OpenAI PHP SDK against Perplexity's fixed endpoint `https://api.perplexity.ai`. It supports the `chat` operation type against the Llama 3.1 Sonar online models and surfaces Perplexity `citations` in the chat output metadata. Model parameters (temperature, top_p, max_tokens) and retry/timeout behaviour are configurable, and the API key lives in a Key module entity. Configuration is at `/admin/config/ai/providers/perplexity` (route `ai_perplexity.settings`, gated by `administer ai providers`). It depends on the `ai` and `key` modules.

---

- Use Perplexity AI as the chat backend for the Drupal AI module.
- Get web-grounded answers from the Sonar "online" models.
- Access `citations` returned with each Perplexity response.
- Choose between Sonar Small (8B), Large (70B), and Huge (405B).
- Set a default Perplexity model for the site.
- Tune temperature (0-2) for response randomness.
- Tune top_p (0-1) for nucleus sampling.
- Cap response length with max_tokens (1-4096).
- Configure request timeout for slow responses.
- Configure automatic retry count and exponential backoff delay.
- Store the Perplexity API key in a Key entity (env or file provider).
- Power AI Assistants / agents with Perplexity models.
- Feed Perplexity answers with sources into content workflows.
- Switch an existing AI-module site to Perplexity without code changes.
- Offer Perplexity as one of several providers in per-operation defaults.
- Handle Perplexity rate limits automatically (mapped to the AI rate-limit exception).
- Retry transient timeouts before surfacing an error.
- Call the provider programmatically via `ai.provider` → `createInstance('perplexity')`.
- Use Perplexity for research-style Q&A inside Drupal.
- Expose Sonar models to any module that consumes the AI framework.
