<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Blueprint — AI submodules & function-call tools

Four submodules integrate with the Drupal AI ecosystem. All are `lifecycle: experimental`.

## entity_blueprint_ai

Depends on `entity_blueprint` + `ai`. Exposes the blueprint operations as Drupal AI **function-call plugins**
(`Drupal\ai\Attribute\FunctionCall`), each an `eb_*` tool. No permission of its own — tool access is governed by
the AI module's agent/assistant permission layer. One admin route: `entity_blueprint_ai.settings` at
`/admin/config/ai/entity-blueprint`, `_permission: 'administer site configuration'`
(`Form\SettingsForm`, config `entity_blueprint_ai.settings`), controlling which entity types/bundles are hidden
from AI bundle discovery (`hidden_entity_types`, `hidden_bundles`). Menu link under `ai.admin_settings`.

### Tool base — `EntityBlueprintToolBase`

Shared infrastructure for every tool (`abstract`, extends `ai\Base\FunctionCallBase`):

- `loadEntity()` / `loadAnyEntity()` — load then check `$entity->access($op)`; set an error string and return
  NULL on miss or denial.
- `requireWorkspace()` / `requireWorkspaceFor()` — when Workspaces requires an active workspace, emit the list of
  workspaces and instruct the AI to ask the user which to use (never pick one itself); return FALSE to abort.
- `requireContentEntityType()` — reject config entity types on content-only tools.
- `persistEntity()` / `persistViaBackend()` — route through `EntityStorageHandler` (save vs tempstore), fire
  `entity_blueprint_ai_tool_persisted` hook and an `Event\AiToolActionEvent`.
- `decodeJsonParam()` — accept a JSON string or already-decoded array; `formatArray()` renders results as YAML.

### `eb_*` tools (`src/Plugin/AiFunctionCall/`)

Information (group `information_tools`): `eb_read_entity`, `eb_read_element`, `eb_read_schema`, `eb_list_bundles`,
`eb_validate`, `eb_skill`. Modification (`modification_tools`): `eb_create_entity`, `eb_update_element`,
`eb_add_element`, `eb_remove_element`, `eb_restructure_layout`, `eb_reorder_field`, `eb_batch_operations`. Each
modification tool calls `requireContentEntityType()` + `requireWorkspace()`, loads the entity with the right
access op, runs the operation, and persists only on success. Intended agent workflow (per tool descriptions):
`eb_skill` → `eb_read_schema` → present plan to user → act.

## entity_blueprint_config_ai

Depends on `entity_blueprint_config` + `entity_blueprint_ai`. Adds config-entity tools that reuse the same base
class and the config backend: `eb_config_create`, `eb_config_read`, `eb_config_read_schema`,
`eb_config_manage_plugins` (add/update/remove/reorder plugins in a config entity's plugin collections). Creation
and updates are enforced by the config backend's fail-closed access checks (see config/settings.md).

## entity_blueprint_ai_anthropic

Depends on `entity_blueprint_ai` + `ai_agents`. `EventSubscriber\SkillListSubscriber` provides Anthropic/Claude
-specific formatting for the skill catalog surfaced to the agent. No routes/permissions/config.

## entity_blueprint_ai_dev_tools

Developer diagnostics. Depends on `entity_blueprint_ai`, `ai`, `ai_assistant_api`, `ai_agents`. Swaps a capture
provider (`Plugin\AiProvider\PromptCaptureProvider`) in for the real LLM provider so the genuine
prompt-assembly pipeline runs but no LLM is called; the assembled `ChatInput` (system prompt, messages, tools) is
read back from the `PromptCapture` service (nothing is persisted) and printed by the `entity-blueprint:prompt-audit`
Drush command (`Drush\Commands\PromptAuditCommands`). `entity_blueprint_ai` also ships an
`entity-blueprint:ai-tail` Drush command (`AiTailCommand`). Enable only in development.
