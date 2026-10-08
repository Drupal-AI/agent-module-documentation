<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI + — routes, permissions & access model

## Permission

`ai_plus.permissions.yml` defines **one** permission: `use ai assistant` ("Access the always-on AI assistant chat panel"). `ChatSidebar::applies()` gates the chat panel on it. The Edit Mode tool and the three AJAX routes are gated by navigation_plus's `use toolbar plus edit mode` instead (both should be limited to trusted editors — the assistant can create and modify content and spends AI-provider budget).

## Routes — `ai_plus.routing.yml`

All three are **POST-only**, `no_cache: TRUE`, and upcast `{entity}` via `type: entity:{entity_type}`. Each requires **both** `_permission: 'use toolbar plus edit mode'` **and** `_entity_access: 'entity.update'` — so a caller must be able to update the specific entity, not merely hold the permission.

| Route | Path | Controller::method |
|---|---|---|
| `ai_plus.refresh_components` | `/ai-plus/refresh/{entity_type}/{entity}/{view_mode}` | `RefreshComponentsController::refresh` |
| `ai_plus.deferred_processing` | `/ai-plus/deferred/{entity_type}/{entity}/{view_mode}` | `DeferredProcessingController::process` |
| `ai_plus.deferred_retry` | `/ai-plus/deferred-retry/{entity_type}/{entity}/{view_mode}` | `DeferredProcessingController::retry` |

### Input validation (defensive)

- **View mode** rides the URL, so both controllers reject an unconfigured one via `NavigationPlusUi::isValidViewMode()` → `BadRequestHttpException` (`RefreshComponentsController::refresh`, `DeferredProcessingController::assertValidViewMode`) before it reaches the view builder.
- Request bodies are `Json::decode`d and shape-checked (`batch_id` must be a non-empty string; `failures`/`targets` must be arrays) — malformed input throws `BadRequestHttpException` or returns an empty result, never a fatal.
- Batch data for `deferred_processing` lives in **private tempstore** (`ai_plus_deferred`), keyed per batch and per user; the process endpoint claims a batch (sets `processing` timestamp) to avoid double-execution.

### Per-field write access

Even though the routes already require `entity.update`, the image-generation write path re-checks **field-level** edit access before writing. `ImageGenerationProcessor::checkFieldEditable()` calls `entity_blueprint`'s `BlueprintAccessChecker::fieldEditable()` for every surgical write (root entity or inline block_content), and `process()` gates on `createAccess('media', 'image')` before generating anything. Field name and component UUID on the retry path are client-supplied, so these checks stop a caller from steering a generated media reference into a field they may not edit.

## The DeepChat API endpoint (owned by ai_chatbot)

The chat panel posts to `/api/deepchat` (route `ai_chatbot.api`, owned by the `ai_chatbot` module), not to an ai_plus route. `ChatSidebar::build()` mints a fresh CSRF token for it via `@csrf_token` (`$this->csrfToken->get('api/deepchat')`) and appends it as the `token` query parameter in the `<deep-chat>` `connect` attribute. `DeepChatResponseListener` (a kernel RESPONSE subscriber) then injects any queued UI commands (`drupal_commands`) into that endpoint's JSON response — it only touches responses whose `_route` is `ai_chatbot.api`.
