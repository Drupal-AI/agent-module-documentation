<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ai_provider_openrouter — agent start

Registers the `openrouter` **AiProvider** plugin for the AI (AI Core) module, routing operations
through **OpenRouter** — an OpenAI-compatible LLM aggregator at `https://openrouter.ai/api/v1`.
Depends on `ai` and `key`. Version 1.1.6, core `^10.5 || ^11.2`.

- Supported operation types (`getSupportedOperationTypes()`): **`chat`, `embeddings`,
  `text_to_image`**. Capability: `StreamChatOutput`.
- HTTP is done through the `ai_provider_openrouter.client` service (`OpenRouterClient`), which
  wraps the **`openai-php/client`** SDK plus a raw Guzzle call for the models listing.
- API key is a **Key** entity — config stores only its machine name (`api_key`), never the secret.
  The client resolves it at request time via `key.repository`.
- Config UI: **Admin → Config → AI → AI Providers → OpenRouter** at
  `/admin/config/ai/providers/openrouter/settings` (route `ai_provider_openrouter.settings`,
  permission `administer ai providers`).
- Provides two permissions of its own (`administer ai providers`, `use ai provider openrouter`)
  and a config schema. No Drush commands.

## Map

- Settings form, config object, key selection, model whitelist, base URL, default-provider toggle →
  [configure/settings.md](configure/settings.md)
- The `openrouter` AiProvider plugin — chat/embeddings/text-to-image handling, streaming, tools,
  reasoning, multimodal, model discovery → [providers/openrouter.md](providers/openrouter.md)
- Calling OpenRouter from code (the `ai.provider` service and the client service) →
  [api/ai_provider_openrouter.md](api/ai_provider_openrouter.md)

## Notes

- OpenRouter is an aggregator: one key reaches models from OpenAI, Anthropic, Google, Meta,
  Mistral, Qwen, Grok and others. Every prompt and response passes through OpenRouter — a data
  processing chain worth capturing in a privacy assessment, and a real spend credential worth a
  provider-side limit.
- Streaming is forced on for legacy (non-agent) DeepChat assistants and disabled for agent-based
  assistants (three DeepChat hooks in the `.module` file). See the provider doc.
- Model availability on an aggregator can change without notice; a site pinned to one model needs
  a fallback plan.
