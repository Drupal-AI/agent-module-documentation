# ai_api_explorer (AI API Explorer) 1.4.x — agent index

Development-only submodule of AI Core (`ai`). Adds admin "explorer" forms to test AI
operations (chat, embeddings, moderation, image/audio/video, tools, …) against your
configured providers and copy boilerplate PHP. No config of its own; intended for dev
sandboxes, not production.

Mental model: one **`AiApiExplorer` plugin = one explorer form** for an operation type. A
route subscriber registers a route per plugin under `/admin/config/ai/explorers/<plugin_id>`;
a landing page lists the ones your providers can actually run.

- **Use the explorer pages** (routes, the landing list, available explorers) → [configure/ai_api_explorer.md](configure/ai_api_explorer.md)
- **Add your own explorer form** (the `AiApiExplorer` plugin type) → [plugins/ai_api_explorer.md](plugins/ai_api_explorer.md)
- **Permissions** (`access ai prompt`) → [permissions/ai_api_explorer.md](permissions/ai_api_explorer.md)
