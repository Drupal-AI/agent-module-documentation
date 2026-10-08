<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `ai_agent_mode` config entity and its admin UI

## Install & enable

```bash
composer require drupal/ai_agent_modes
drush en ai_agent_modes -y
```

Hard dependencies `ai` and `ai_agents` (>=1.3) are pulled in by Composer. The selector only *appears*
once there is more to choose than the free-form default: create at least one mode, or make sure the
parent agent has live sub-agents.

## The entity

`src/Entity/AiAgentMode.php` — a `#[ConfigEntityType(id: 'ai_agent_mode', config_prefix:
'ai_agent_mode', admin_permission: 'administer ai agent modes')]`. `config_export` keys (schema
`config/schema/ai_agent_modes.schema.yml` → `ai_agent_modes.ai_agent_mode.*`):

| Key | Type | Meaning |
|---|---|---|
| `id` / `label` / `uuid` | machine_name / label / uuid | Identity. |
| `description` | text | Human note, shown in the list builder. |
| `weight` | int | Order in the list and the dropdown. |
| `status` | bool | Only enabled modes are listed/resolved. |
| `agent` | string | Parent AiAgent plugin ID. **Empty = generic** (matches any agent, steers by prompt only). |
| `sub_agents` | string[] | AiAgent plugin IDs this mode exposes. Under `guide` a hint; under `restrict` the allow-list. |
| `system_prompt_addition` | text | Scoped directive prepended to the system prompt (may contain tokens; the agent replaces them after). |
| `scope_strength` | string | `guide` (default) or `restrict`. `Choice` constraint. |
| `assistants` | string[] | ai_assistant IDs the mode is offered for. Empty = every assistant; a non-empty list is never offered where there is no assistant. |
| `surfaces` | string[] | Surface IDs the mode applies to. Empty = all surfaces. |

Key entity methods: `getScopeStrength()` clamps any unknown stored value to `guide` (hand-edited
config can never make an agent lose its tools); `withholdsTools()` is true only for `restrict`;
`appliesToAssistant(?string)` / `appliesToSurface(string)` implement the filtering; only the parent
`agent` is added as a config dependency in `calculateDependencies()` (sub-agents and assistants are
deliberately not dependencies, so removing one does not delete the whole mode).

`scope_strength` constants live on `AiAgentModeInterface`: `SCOPE_GUIDE = 'guide'`,
`SCOPE_RESTRICT = 'restrict'`.

## Routes, permission, links

All CRUD is under `/admin/config/ai/agent-modes` (`ai_agent_modes.routing.yml`), every route gated
by `_permission: 'administer ai agent modes'`:

- `entity.ai_agent_mode.collection` — `_entity_list: ai_agent_mode` (the configure route).
- `entity.ai_agent_mode.add_form` / `.edit_form` / `.delete_form` — forms `ai_agent_mode.add`,
  `.edit` (both `AiAgentModeForm`), `.delete` (core `EntityDeleteForm`).

Permission `administer ai agent modes` (`ai_agent_modes.permissions.yml`) is
`restrict access: true`. Menu link under `ai.admin_settings`; local tasks *Modes* and *Settings*;
action link *Add AI agent mode*.

## The forms

- `AiAgentModeForm` (`src/Form/AiAgentModeForm.php`, extends `EntityForm`) builds the add/edit form:
  parent-agent select with an AJAX `updateSubAgents()` callback that repopulates the sub-agent
  checkboxes from `ModeManager::listSubAgents()`, plus fields for the directive, scope strength,
  assistants and surfaces. `validateForm()`, `buildEntity()`, `save()` and a `modeExists()` machine-
  name check.
- `AiAgentModeListBuilder` adds columns (label, machine name, agent, etc.) via `buildHeader()` /
  `buildRow()`.

## Config export example

```yaml
# ai_agent_modes.ai_agent_mode.page_builder_only.yml
langcode: en
status: true
id: page_builder_only
label: 'Page Builder Only'
description: 'Build and edit pages.'
weight: 0
agent: canvas_ai_orchestrator
sub_agents:
  - drupal_canvas_page_builder_agent
system_prompt_addition: 'Focus on building and editing pages only.'
scope_strength: restrict
assistants: {  }
surfaces: {  }
```

`restrict` here is honoured only because the mode names a parent `agent` and a real sub-agent;
a generic mode (empty `agent`) set to `restrict` logs a warning and steers only.
