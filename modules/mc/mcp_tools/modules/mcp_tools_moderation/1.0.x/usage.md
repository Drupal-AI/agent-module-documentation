Submodule of MCP Tools that adds six Tool API plugins for reading and changing Content Moderation states, workflows, and transitions.

---

`mcp_tools_moderation` lets an AI/MCP client work with Drupal's Content Moderation and Workflows. Read tools list all moderation workflows, describe one workflow's states/transitions/entity-type bindings, report an entity's current state and which transitions are available, return an entity's revision history annotated with moderation states, and list all content sitting in a given state of a workflow. One write tool transitions an entity to a new moderation state, creating a new revision. All tools extend `McpToolsToolBase` with category `moderation`, inheriting the parent access model (`mcp_tools use moderation` permission, per-connection read/write scope, config write policy, global read-only switch); the write tool also validates the transition is permitted and checks `canWrite()`. The submodule depends on core `content_moderation` and `workflows`, ships one permission and one service (`ModerationService`), and declares no config, routes, or forms.

---

- List every content moderation workflow with its states and transitions (`mcp_moderation_get_workflows`).
- Inspect one workflow's states, allowed transitions, and which entity types/bundles use it (`mcp_moderation_get_workflow`).
- Get an entity's current moderation state and the transitions it can make next (`mcp_moderation_get_state`).
- Move a node from draft to review or published, creating a new revision (`mcp_moderation_set_state`).
- Attach a revision log message when transitioning state.
- List all content currently in "draft" (or any state) within a workflow (`mcp_moderation_get_content_by_state`).
- Build an editorial dashboard: how many items await review?
- Review an entity's moderation history — who changed the state, when, and with what message (`mcp_moderation_get_history`).
- Let an agent publish approved content on request while respecting the workflow's allowed transitions.
- Prevent invalid transitions — the write tool rejects a state change the workflow does not allow.
- Bulk-triage: find drafts, inspect each, and advance the ones that are ready.
- Support media moderation as well as nodes (entity type is a parameter).
- Answer "what state is node 42 in and what can I do with it next?".
- Audit an editorial workflow's configuration before onboarding editors.
- Keep state changes on write-scoped connections while leaving workflow/state inspection read-only.
- Report the workflow governing a given entity and its published/unpublished states.
- Drive a scheduled-publish agent that transitions items when they are ready.
- Summarise editorial throughput by counting content per state.
