<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Workspace — tool-calling plugin type

A pluggable, OpenAI-function-style tool-calling scaffold. **No tools ship active** in 1.0.0-rc4;
this is the extension point for adding them. The `tools_enabled` config flag and the `/tools` API
exist, but `ToolExecutor` returns an empty schema list until a module registers a plugin.

## Plugin type `ai_workspace_tool`
- Manager: `Plugin\AiWorkspaceTool\AiWorkspaceToolPluginManager` (service
  `plugin.manager.ai_workspace_tool`, `parent: default_plugin_manager`). Discovers classes in any
  module's `Plugin/AiWorkspaceTool` namespace; alter hook `ai_workspace_tool_info`; cache bin key
  `ai_workspace_tool_plugins`.
- Annotation: `Annotation\AiWorkspaceTool` — `id`, `label`, `description` (string, sent to the AI),
  `permission` (optional Drupal permission; empty = any `use ai workspace` user).
- Interface: `Plugin\AiWorkspaceTool\AiWorkspaceToolInterface` — `getDescription(): string`,
  `getParameterSchema(): array` (JSON-Schema draft-07 / OpenAI function params), `execute(array $arguments): mixed`.

## Register a tool
1. Add `src/Plugin/AiWorkspaceTool/MyTool.php` implementing `AiWorkspaceToolInterface`.
2. Annotate `@AiWorkspaceTool(id="my_tool", label=@Translation("My Tool"), description="…", permission="use ai workspace")`.
3. `drush cr`.

## ToolExecutor (`ai_workspace.tool_executor`)
- `getAvailableTools()` — instantiates every plugin definition, **skipping** any whose annotated
  `permission` the current user lacks (`AccountInterface::hasPermission`). Instantiation failures are
  logged and skipped.
- `getToolSchemas()` — wraps each available tool as `{type:'function', function:{name(plugin_id),
  description, parameters}}`; served by `ToolApiController::list()` at `GET /api/ai-workspace/tools`.
- `execute($tool_id, $arguments)` — validates the plugin id (`InvalidArgumentException` if unknown),
  logs the invocation with the current uid, calls `$tool->execute()`, and wraps failures in
  `RuntimeException`.

Note: the `Message` entity carries `tool_invocation`/`tool_result` fields and the `ChatService`
constructor injects the executor, but the current chat/stream paths do not yet dispatch model tool
calls — the wiring between provider tool_call responses and `ToolExecutor::execute()` is not present
in this release.
