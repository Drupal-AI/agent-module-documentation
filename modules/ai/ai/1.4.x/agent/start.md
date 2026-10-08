# ai (AI Core) 1.4.x — agent index

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
ai_assistant_api, ai_automators, ai_chatbot, ai_ckeditor, ai_observability, ai_search
(ai_search is `lifecycle: experimental`).

Not documented — the ai project also ships these but they are marked `lifecycle: deprecated`
in their `.info.yml` and are intentionally skipped here: ai_content_suggestions, ai_eca
(now a migration stub → `ai_integration_eca`), ai_external_moderation (folded into AI Core),
ai_logging, ai_translate, ai_validations, field_widget_actions.
