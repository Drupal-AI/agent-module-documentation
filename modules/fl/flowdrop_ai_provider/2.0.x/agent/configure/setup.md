# Install & configure

This module has **no settings form and no `configure` route**. All configuration happens in the two
modules it bridges — `drupal/ai` (the credential, provider and models) and FlowDrop (node types and the
chatbot). Enabling the module ships the AI node types and an AI-prompt type; you then point `drupal/ai`
at a provider so those nodes become runnable.

## 1. Enable

```
composer require drupal/flowdrop_ai_provider
drush en flowdrop_ai_provider -y
```

Pulls in `ai`, `ai_agents`, `flowdrop`, `flowdrop_node_type`, `flowdrop_session`, `flowdrop_interrupt`
(info.yml `dependencies`). Install imports `config/install/`: the AiPrompt type `flowdrop` and 19
`flowdrop_node_type` config entities (one per processor).

## 2. Configure a `drupal/ai` provider (this is where the API key lives)

The node types are inert until at least one provider is configured for the operation type they need.
Go to **`/admin/config/ai/providers`** and install + configure a provider module (OpenAI, Anthropic,
Ollama, …). The provider stores its API key — typically as a **Key entity** (`drupal/key`) referenced
from the provider settings, never in this module and never in a workflow. Set the site default model per
operation type at **`/admin/config/ai/settings`** (`ai.settings`); `AiModelService` reads those defaults.

A node type whose operation type has no configured provider is **hidden from the FlowDrop editor sidebar**
(`NodeListFilterSubscriber`) and its node-type edit form shows a warning with links to compatible
providers (`AiProviderHooks::attachProviderWarning`, sourced from `ai`'s `ai.provider_registry.yml`).

## 3. Node types (optional tuning)

Node types live at **`/admin/flowdrop/config/node-types`** (entity type `flowdrop_node_type`). Each
entity's `parameters` map decides which fields are `configurable` (shown in the node's config panel),
`connectable` (wireable from another node's output) and `required`; `outputs[*].exposed` decides which
outputs get ports. The editor fetches a live schema per node from
`GET /api/flowdrop/ai-provider/config-schema?plugin=flowdrop_ai_provider:<id>` so model/provider
dropdowns always reflect current AI config. Update hook `_10006` re-syncs a site's node types with the
shipped YAML on module update without clobbering per-site flag tweaks.

## 4. AI Prompts (reusable system prompts)

The `chat` node's `systemPrompt` accepts either literal text or an **`ai_prompt:<entity_id>`** reference
to an `ai_prompt` config entity (type `flowdrop`, variables `message`, `workflowName`). References are
resolved at run time by `AiPromptResolver`, and `EntityHooks::entity_presave` also resolves such a
reference stored on an `ai_agent`'s `system_prompt` field before save. Create/list prompts via the
editor (backed by the `/api/flowdrop/ai-prompts*` routes) or at the AI module's prompt admin.

## 5. Guardrails

The `guardrails` node applies an **AI Guardrail Set** (`drupal/ai`) to text — create sets at
`/admin/config/ai/guardrails/guardrail-sets`, then select one on the node (`guardrail_set`), choosing
`mode: input` (pre-generate) or `output` (post-generate).

## 6. Chatbot backend (optional)

To make the AI module's Chatbot answer through a FlowDrop workflow, pick the **FlowDrop Workflow** chat
processor (`flowdrop_workflow`) and select a workflow — see [../plugins/chat-processor.md](../plugins/chat-processor.md).

## Permissions

This module defines **no permissions**. It relies on permissions from `ai`/`flowdrop`:
`administer flowdrop` (all `/api/flowdrop/*` routes here), plus `administer ai` / `manage ai prompts`.
A route subscriber (`AiSettingsRouteSubscriber`) widens the `ai.settings.menu` route so
`manage ai prompts` also grants the AI settings overview (Drupal `+` = OR).
