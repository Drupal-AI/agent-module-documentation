<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP Tools - Content Moderation (mcp_tools_moderation) — agent index

Submodule of **mcp_tools**. Adds six Tool API plugins for Content Moderation workflows and states.
Installed release **1.0.0-beta8** (version dir `1.0.x`).
Core `^10.3 || ^11 || ^12`. License GPL-2.0-or-later. Package *MCP Tools*.
Depends on `mcp_tools:mcp_tools`, `drupal:content_moderation`, `drupal:workflows`.
No config objects, routes, or forms of its own.

- **The six tools and ModerationService** → [tools/moderation-tools.md](tools/moderation-tools.md)

## What it is

Tools under `src/Plugin/tool/Tool/` extend `McpToolsToolBase` (const `MCP_CATEGORY = 'moderation'`,
write kind `content`) and delegate to `ModerationService` (`mcp_tools_moderation.moderation`). Base
`checkAccess()` requires `mcp_tools use moderation` + the operation's scope + read-only off; the one
Write tool also calls `accessManager->canWrite()` and validates the transition is allowed.

## Tools (6)

| id | class | op |
|----|-------|----|
| `mcp_moderation_get_workflows` | `GetWorkflows` | Read |
| `mcp_moderation_get_workflow` | `GetWorkflow` | Read |
| `mcp_moderation_get_state` | `GetModerationState` | Read |
| `mcp_moderation_get_history` | `GetModerationHistory` | Read |
| `mcp_moderation_get_content_by_state` | `GetContentByState` | Read |
| `mcp_moderation_set_state` | `SetModerationState` | Write |

## Service

- `mcp_tools_moderation.moderation` — `ModerationService` (entity type manager,
  `content_moderation.moderation_information`, `content_moderation.state_transition_validation`,
  current_user, `datetime.time`, `mcp_tools.access_manager`, `mcp_tools.audit_logger`).

Permission (`mcp_tools_moderation.permissions.yml`, `restrict access: true`):
`mcp_tools use moderation`.
