<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI + (ai_plus) — agent index

An **AI assistant integrated into Navigation Plus Edit Mode** for the "+ Suite" page builder. It is a thin wiring layer: it adds an **AI tool** and an **always-on chat sidebar** to Edit Mode, feeds the current page/selection context to an **AI Agents** agent, and after the agent edits content it **surgically re-renders and highlights** the changed Layout Builder components. Image fields are filled **asynchronously** via a deferred processor that calls the configured `text_to_image` AI provider. Package `Page Building`. Lifecycle `experimental`. Core `^11`, PHP `8.1`. License GPL-2.0-or-later. Version 1.0.2.

**ai_plus makes no external HTTP calls and stores no API keys** — every model call is delegated to the `ai` module's provider plugins.

## Dependencies

`navigation_plus` (`^2.3.6`), `ai:ai_chatbot` (`^1.3`), `ai_agents` (`^1.2`), `entity_blueprint` + `entity_blueprint_ai` (`^1.0`). Configuration lives on the **Navigation Plus** settings form (route `navigation_plus.settings`), altered by this module.

## What it provides (from source)

- **Plugins (navigation_plus attribute plugins):**
  - `Plugin/Tool/AiPlus.php` — the "AI" Edit Mode tool (id `ai_plus`, hotkey `a`); attaches libraries, adds a per-user "Generate images" toggle.
  - `Plugin/Sidebar/ChatSidebar.php` — the always-on `<deep-chat>` chat panel (id `ai_plus`), gated by permission `use ai assistant`.
- **Permission:** `use ai assistant` (`ai_plus.permissions.yml`). Note: the three POST routes below are gated by navigation_plus's `use toolbar plus edit mode` **plus** `_entity_access: entity.update`.
- **Routes/controllers** (all POST, entity-access gated) — see [config/routing-and-access.md](config/routing-and-access.md):
  - `ai_plus.refresh_components` → `RefreshComponentsController::refresh`
  - `ai_plus.deferred_processing` → `DeferredProcessingController::process`
  - `ai_plus.deferred_retry` → `DeferredProcessingController::retry`
- **Services / extension points** (`ai_plus.services.yml`) — see [architecture/overview.md](architecture/overview.md):
  - Two service-collector extension points: `ai_plus.deferred_processor` (tag) and `ai_plus.image_dimension_adapter` (tag).
  - `ImageGenerationHandler` — an `entity_blueprint.field_handler` for media reference fields (handles `_generate`).
  - `ImageGenerationProcessor` — deferred processor that generates images via `@ai.provider`.
  - Event subscribers: `TokenPropagationSubscriber`, `AiToolActionSubscriber`, `DeepChatResponseListener`; helpers `UiCommandQueue`, `PageRefreshCommands`, `RouteEntityResolver`, `ElementSelectionResolver`, `ImageGenerationGate`.
- **Config:** object `ai_plus.settings` (`assistant_id`, `placeholder_media_id`, `image_generation_enabled`); schema in `config/schema/ai_plus.schema.yml`.
- **Hook:** `hook_ai_plus_deepchat_style_alter(&$params, &$auxiliary_style)` (`ai_plus.api.php`) to restyle the chat panel; `hook_library_info_alter` bolts AI Plus JS onto ai_chatbot's `deepchat` library.

## Solution docs

- **Settings, config object, image-generation gate** → [config/settings.md](config/settings.md)
- **Routes, permissions, access model** → [config/routing-and-access.md](config/routing-and-access.md)
- **Architecture: context injection, deferred image generation, refresh** → [architecture/overview.md](architecture/overview.md)
- **Submodule — AI Plus Anthropic (context formatting)** → [submodules/ai_plus_anthropic.md](submodules/ai_plus_anthropic.md)
- **Submodule — AI Plus Gemini (image dimensions)** → [submodules/ai_plus_gemini.md](submodules/ai_plus_gemini.md)
