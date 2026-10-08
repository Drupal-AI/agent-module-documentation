<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
mittwald Provider registers mittwald AI Hosting as a provider for the Drupal AI module via its OpenAI-compatible LLM API.

---

`ai_provider_mittwald` connects the [AI module](https://www.drupal.org/project/ai) to
[mittwald](https://www.mittwald.de/)'s AI hosting platform, which exposes an OpenAI-compatible API
(default endpoint `llm.aihosting.mittwald.de/v1`). It offers **chat**, **embeddings**, **rerank**,
**speech-to-text** and **text-to-speech** operations (moderation and text-to-image are declared but
throw "not implemented"). Because mittwald does not publish per-model capability metadata, the module
hard-codes model selection: `getModels()` filters the server's model list by operation type using
regex on model ids, and heuristics decide vision-capable and reasoning models. The API key is stored
through the **Key module** and sent as a bearer token; on save the module validates it by listing
models and runs a rate-limit probe that warns when the account is on a limited quota tier. Sensible
default models are seeded automatically (e.g. `Ministral-3-14B-Instruct-2512` for chat,
`Qwen3-Embedding-8B` for embeddings). Supports Drupal 10.3+ and 11.

---

- Use mittwald AI Hosting as the AI provider for a Drupal site.
- Run chat completions against mittwald-hosted models.
- Generate embeddings with `Qwen3-Embedding-8B` for semantic search.
- Rerank documents against a query via mittwald's rerank endpoint.
- Transcribe audio with `whisper-large-v3-turbo` (speech-to-text).
- Synthesize speech with a mittwald text-to-speech model.
- Store the mittwald API key securely through the Key module.
- Validate the API key on save by listing available models.
- Get a warning when the mittwald account is on a rate-limited quota tier.
- Auto-seed default models for each supported operation type.
- Offer only chat models that match mittwald's chat model families.
- Restrict image-vision use to models that actually accept images.
- Expose a Reasoning Effort setting for reasoning-capable models.
- Override the API host via config for a custom mittwald endpoint.
- Reuse OpenAI-style AI-module flows against mittwald infrastructure.
- Keep AI hosting within a mittwald-managed platform.
- Select mittwald as the provider for chat, embeddings, or rerank in AI settings.
- Migrate away from withdrawn default models automatically on update.
- Support Drupal 10.3, 11 sites running the AI module and Key module.
