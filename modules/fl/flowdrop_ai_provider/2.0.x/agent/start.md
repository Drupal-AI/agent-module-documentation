<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FlowDrop AI Provider (flowdrop_ai_provider) — agent index

Bridges the **FlowDrop** visual-workflow builder to the **AI** module's provider abstraction. It ships
**19 `FlowDropNodeProcessor` plugins** (chat, embeddings, moderation, summarize, rerank, translate,
speech/audio/image/video generation, image classification, object detection, guardrails, session
history) that appear as executable nodes in the FlowDrop editor, plus one `ChatProcessor` plugin
(`flowdrop_workflow`) that lets the AI module's chatbot run a whole FlowDrop workflow as its backend.
Every AI call is delegated to a `drupal/ai` provider via the `ai.provider` plugin manager — this module
never talks to a vendor API itself and **never stores a credential**: the API key, provider choice and
model live in `drupal/ai` configuration (e.g. a Key entity), so a workflow definition (which FlowDrop
exports and shares) carries no secret.

The layer is thin and config-driven. `AiModelService` discovers which providers/models can serve each
operation type (cached 1h, tag `config:ai.settings`); each processor resolves a model with the same
fallback (explicit model → operation-type default → chat default → first available). Two extra services
harden the file paths: `SecureFileLoader` fetches image/audio/video inputs with SSRF and path-traversal
guards, and the chat path allow-lists conversation roles to block `system`-role injection. Seven
`/api/flowdrop/*` JSON routes (all `administer flowdrop`) feed the editor's model/prompt/guardrail pickers.
A `flowdrop.chat_reasoner` service override gives FlowDrop Reason nodes a real (function-calling) backend.

- Depends on: `ai:ai`, `ai_agents:ai_agents`, `flowdrop:flowdrop`, `flowdrop:flowdrop_node_type`,
  `flowdrop:flowdrop_session`, `flowdrop:flowdrop_interrupt`.
- Core: `^11 || ^12` (composer requires `drupal/core:^11.3`). PHP `>=8.2`. Package: `FlowDrop`.
- **No settings page / `configure` route.** Configuration lives in `drupal/ai` (providers, prompts,
  guardrails) and FlowDrop (node types at `/admin/flowdrop/config/node-types`, chat processor per bot).
- **No permissions of its own** (routes reuse `administer flowdrop`; a route subscriber widens
  `ai.settings.menu` to also accept `manage ai prompts`). **No drush.** Provides config schema. Defines
  **no plugin types** — it provides plugins of types owned by `flowdrop`/`ai`.

## What you'd do → where

- **Install & configure it end-to-end (providers, node types, prompts, guardrails, chat bot)** →
  [configure/setup.md](configure/setup.md)
- **Understand / add a workflow node that calls a model (the 19 processors, their params, file inputs)** →
  [plugins/node-processors.md](plugins/node-processors.md)
- **Use a FlowDrop workflow as an AI chatbot backend (the `flowdrop_workflow` chat processor)** →
  [plugins/chat-processor.md](plugins/chat-processor.md)
- **Call the model/prompt services from PHP, or hit the JSON API routes** →
  [api/services.md](api/services.md)
- **Understand the hooks, event subscribers, route subscriber and update path** →
  [hooks/hooks.md](hooks/hooks.md)

## Key facts (real machine names)

- Routes (all `_permission: administer flowdrop`, controller `…\Controller\Api\*`):
  `flowdrop_ai_provider.api.ai_prompts.list|create|autocomplete` (`/api/flowdrop/ai-prompts[...]`),
  `flowdrop_ai_provider.api.ai_prompt_types.list`, `flowdrop_ai_provider.api.ai_provider.schema`
  (`/api/flowdrop/ai-provider/config-schema`), `flowdrop_ai_provider.api.guardrail_sets.autocomplete|detail`.
- Services: `flowdrop_ai_provider.model_service` (`AiModelService`),
  `flowdrop_ai_provider.operation_availability` (`AiOperationAvailability`),
  `flowdrop_ai_provider.ai_prompt_resolver` (`AiPromptResolver`),
  `flowdrop_ai_provider.secure_file_loader` (`SecureFileLoader`),
  `flowdrop_ai_provider.node_list_filter_subscriber`, `flowdrop_ai_provider.route_subscriber`,
  `flowdrop_ai_provider.ai_prompt_system_prompt_subscriber`, and the service override
  **`flowdrop.chat_reasoner`** → `Service\Reasoning\ChatReasoner`.
- `FlowDropNodeProcessor` plugin ids: `chat`, `simple_chat`, `embeddings`, `moderation`, `summarize`,
  `rerank`, `translate_text`, `text_to_image`, `image_to_image`, `image_classification`,
  `object_detection`, `image_to_video`, `image_and_audio_to_video`, `text_to_speech`, `speech_to_text`,
  `speech_to_speech`, `audio_to_audio`, `guardrails`, `session_history` (namespaced
  `flowdrop_ai_provider:<id>`; node-type config entities `flowdrop_node_type.flowdrop_node_type.flowdrop_ai_provider_<id>`).
- `ChatProcessor` plugin id: `flowdrop_workflow` (config keys `workflow_id`, `remember_conversation`).
- Config: schema `ai_chat_processor.configuration.flowdrop_workflow`; install `ai.ai_prompt_type.flowdrop`
  (AiPrompt type `flowdrop`, variables `message`, `workflowName`) + 19 node-type entities.
- Library: `flowdrop_ai_provider/ai-prompt-field` (`lib/build/ai-prompt-field.js`, Svelte field widgets).
- Hooks (`Hook\AiProviderHooks`, `Hook\EntityHooks`): `library_info_alter`,
  `form_flowdrop_node_type_add_form_alter`, `form_flowdrop_node_type_edit_form_alter`, `entity_presave`.
- Update hooks `flowdrop_ai_provider_update_10001`–`_10007` (node-type rename/namespace/category/port migrations).
