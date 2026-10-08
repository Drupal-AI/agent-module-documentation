<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI + — architecture (context, deferred image generation, refresh)

AI Plus is a wiring layer between Navigation Plus (Edit Mode UI), ai_chatbot (DeepChat panel), ai_agents / ai_assistant_api (the agent), and entity_blueprint (JSON entity (de)serialization for AI). All LLM work is delegated to the `ai` module's `@ai.provider` (`AiProviderPluginManager`) — **ai_plus opens no HTTP client of its own and holds no API keys.**

## 1. Feeding context to the agent

When the assistant runs, `ai_assistant_api` dispatches `AiAssistantPassContextToAgentEvent` and `ai_agents` dispatches `BuildSystemPromptEvent`. ai_plus resolves the current entity/selection from the request context and injects it:

- **`RouteEntityResolver`** turns the posted `current_route` path into an entity.
- **`ElementSelectionResolver`** (optional dep `@?entity_blueprint.element_resolver`) turns selected element ids into rich descriptions.
- **`TokenPropagationSubscriber`** (model-neutral) captures the entity + view mode, sets `current_entity_context` / `current_view_mode` tokens so sub-agents inherit them, and hands the current entity to `entity_blueprint`'s `CurrentEntityContext` so AI tools (which run without token access) can resolve it.
- The **provider submodules** (`ai_plus_anthropic`) actually phrase this context into the prompt/message. See [../submodules/ai_plus_anthropic.md](../submodules/ai_plus_anthropic.md). `AgentUserMessageTrait` is the shared helper for prepending a `<system-reminder>` block to the last user message.

## 2. Reacting to AI edits — `AiToolActionSubscriber`

entity_blueprint_ai dispatches `AiToolActionEvent` (`entity_persisted`) after the agent writes an entity, and ai_agents dispatches `AgentToolFinishedExecutionEvent`. The subscriber:

- **New entity** → queues `SetCookieCommand('activeTool','ai_plus')` + `OpenLinkCommand($url,$label)` so the client navigates to the new page (`$url` is `$entity->toUrl()` — internal only; the JS handler `js/ai-plus-open-link.js` sets `window.location.href`).
- **Existing entity, immediate targets** → renders the entity in edit context (`LoadEditablePage::getBuild`) and queues an `UpdateElement` surgical replace + form-clear commands.
- **Deferred targets** (image generation) → stores the operations in private tempstore (`ai_plus_deferred`, batch key `type:id:uniqid`) and queues a `TriggerDeferredCommand` so the client calls the deferred endpoint.
- **Workspace switch tools** → replaces the workspace switcher toolbar block.

Queued commands are held in **`UiCommandQueue`** and flushed into the DeepChat JSON response by **`DeepChatResponseListener`** (as `drupal_commands`). Client JS (`js/ai-plus-command-processor.js`, `ai-plus-trigger-deferred.js`, `ai-plus-followup-chat.js`) executes them.

## 3. Deferred image generation

The `_generate` image flow is what makes image fields fill "asynchronously":

- **`ImageGenerationHandler`** (`entity_blueprint.field_handler`, `field_types: entity_reference`, priority 10) intercepts media-reference fields. When a field value carries `{_generate: "...", alt_text: "..."}` and the gate is on, it writes the **placeholder** media (on create) and emits a `DeferredOperation(type: image_generation)`; it asks `ImageDimensionAdapterManager::extractConfiguration()` to turn any AI-supplied sizing key into provider config. When the gate is off it keeps the placeholder and returns a warning instead.
- The client then POSTs to `ai_plus.deferred_processing`; **`DeferredProcessingController::process`** claims the batch and runs each op through **`DeferredProcessorManager`** → **`ImageGenerationProcessor`**.
- **`ImageGenerationProcessor::process`**: checks `createAccess('media','image')`, calls the configured `text_to_image` provider via `@ai.provider` (`generateImage()` → `$provider->textToImage()`), writes the file under `public://ai_generated/`, creates a `media:image` entity, then does **layout surgery** (`performLayoutSurgery()`) to swap the placeholder reference for the new media id — either on the root entity field or inside the Layout Builder tempstore component (via `NestedAwareSectionStorage`). Every write is guarded by `checkFieldEditable()`.
- **Retry** (`ai_plus.deferred_retry` → `RetryableProcessorInterface::buildRetryOperations`): `ImageGenerationProcessor::rewritePrompts()` asks the `chat_with_tools` provider to rephrase prompts rejected by content moderation, then re-runs them.

### Image-dimension adapters (extension point)

`ImageDimensionAdapterManager` (service collector tag `ai_plus.image_dimension_adapter`) resolves the active `text_to_image` provider and returns the first adapter whose `supports()` matches; it exposes `getGuidance()` (appended to the field guidance the AI sees) and `extractConfiguration()`. Ships **`AspectRatioDimensionAdapter`** (priority −100, catch-all). `ai_plus_gemini` adds a Gemini-specific adapter — see [../submodules/ai_plus_gemini.md](../submodules/ai_plus_gemini.md).

### Deferred-processor extension point

`DeferredProcessorManager` (service collector tag `ai_plus.deferred_processor`) collects processors keyed by `getType()`. Implement `DeferredOperationProcessorInterface` (and optionally `RetryableProcessorInterface`) and tag your service to add a new kind of deferred operation. `image_generation` is the only built-in processor.

## 4. Page refresh & highlighting

`PageRefreshCommands` builds the CSS selectors for changed components and the `UpdateElement`/clear-form AJAX commands; `RefreshComponentsController::refresh` re-renders the entity in edit mode and returns those commands for a follow-up chat turn. After a surgical update, `navigation_plus/highlight` flashes the changed components. Polling vs. instant refresh modes are driven by the JS (`js/ai-plus-*.js`) and the `chat`/`edit_mode`/`layout_context` libraries in `ai_plus.libraries.yml`.
