<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds Langdock as a selectable AI provider for the Drupal AI module, so chat and embeddings operations can be routed to Langdock's OpenAI-compatible LLM endpoint.

---

`ai_provider_langdock` registers a single `AiProvider` plugin (`langdock`) that extends the Drupal AI module's `OpenAiBasedProviderClientBase`, so it talks to Langdock through the OpenAI PHP SDK against Langdock's OpenAI-compatible API (default endpoint `https://api.langdock.com/openai/eu/v1`). It supports two operation types — `chat` (including streaming, tool/function calling, and structured JSON-schema responses) and `embeddings` — and reads the live model list from the provider. The API key is held in a Key module entity and the endpoint host is set on the provider's settings form (`/admin/config/ai/providers/langdock`, gated by the `administer ai providers` permission). It depends on the `ai` and `key` modules. Once configured it becomes available to every AI-module feature (chat blocks, agents, the explorer, other modules that call `ai.provider`).

---

- Use Langdock as the chat backend for the Drupal AI module.
- Generate text/chat completions against Langdock models.
- Stream chat responses token-by-token in the AI UI.
- Call Langdock with tool/function-calling payloads.
- Request structured JSON-schema-constrained responses.
- Produce text embeddings via Langdock (`text-embedding-ada-002`, `text-embedding-3-*`).
- Power AI Assistants / agents with Langdock models.
- Point the provider at the EU Langdock endpoint for data-residency needs.
- Point the provider at a custom OpenAI-compatible Langdock host.
- Select the default chat model for the site's AI operations.
- Select the default embeddings model.
- Store the Langdock API key in a Key entity (env or file provider).
- Let editors use Langdock through CKEditor AI tools.
- Feed Langdock into RAG/vector workflows via its embeddings.
- Use `gpt-5`, `o1`, `o3` reasoning models exposed through Langdock (with reasoning-effort control).
- Switch an existing site from another provider to Langdock without code changes.
- Validate connectivity/credentials from the settings form before saving.
- Cache the fetched model list to avoid repeated model-listing calls.
- Compute embedding vector sizes for storage/index sizing.
- Provide Langdock as one of several providers for per-operation defaults.
