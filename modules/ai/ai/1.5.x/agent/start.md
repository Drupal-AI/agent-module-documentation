# ai (AI Core) 1.5.x — agent index

Provider-agnostic AI abstraction layer. Code calls one API; the configured provider
module (OpenAI, Anthropic, Ollama, …) serves the request. This module defines the
contracts and plumbing — install at least one provider module to actually run anything.

Core mental model: a **provider** (an `AiProvider` plugin) implements one or more
**operation types** (`chat`, `embeddings`, `text_to_image`, `moderation`, …). You get the
site's default provider for an operation from the `ai.provider` service, pass a typed
input, and read a normalized output.

- **Call an AI operation from code** (chat, embeddings, images, …) → [api/ai.md](api/ai.md)
- **Configure defaults, providers, keys, settings** → [configure/ai.md](configure/ai.md)
- **Plugin types you can implement** (providers, operation types, tools, guardrails, …) → [plugins/ai.md](plugins/ai.md)
- **Observe / alter every request** (events, no hook_ API) → [extend/ai.md](extend/ai.md)
- **Drush commands** (`ai:chat`) → [drush/ai.md](drush/ai.md)
- **Permissions** → [permissions/ai.md](permissions/ai.md)

Submodules documented separately under `modules/ai/modules/<name>/`: ai_api_explorer,
ai_assistant_api, ai_automators, ai_chatbot, ai_ckeditor, ai_observability, ai_search.

The ai project also ships ai_content_suggestions, ai_eca, ai_external_moderation,
ai_logging, ai_translate, ai_validations and field_widget_actions on disk; these are not
documented here (several are deprecated or have moved to their own contrib projects), and
are intentionally left out of this knowledge base.
