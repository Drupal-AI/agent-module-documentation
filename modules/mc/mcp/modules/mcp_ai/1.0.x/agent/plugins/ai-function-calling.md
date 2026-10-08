<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `ai-function-calling` MCP plugin

`Drupal\mcp_ai\Plugin\Mcp\AiFunctionCalling` — `#[Mcp(id: 'ai-function-calling')]`. Injects the AI
module's `ai.function_calls` plugin manager (`NULL_ON_INVALID_REFERENCE`).

- `checkRequirements(): bool` — TRUE only when `ai.function_calls` is available (the `ai` module is
  installed and provides the service).

## `getTools()` (→ MCP `tools/list`)
Iterates `ai.function_calls->getDefinitions()`, instantiates each, calls `->normalize()` then
`->renderFunctionArray()`, and returns one `Tool` per function:
- `name` = `$instance->getFunctionName()`,
- `description` = the function's description,
- `inputSchema` = the function's `parameters` (JSON schema).

Externally these are advertised as `ai-function-calling_<functionName>` (parent service prefix).

## `executeTool($toolId, $arguments)` (→ MCP `tools/call`)
- `$toolId` is the bare function name (the parent controller strips the `ai-function-calling_` prefix by
  splitting on the first `_`).
- Scans all definitions, keeps instances that implement `ExecutableFunctionCallInterface` **and** whose
  `getFunctionName()` matches `$toolId`.
- For each match: wraps `$arguments` in `ToolsFunctionOutput(input: $instance->normalize(), arguments:
  $arguments)`, calls `->validate()`, `->populateValues()`, `->execute()`, then collects
  `['type' => 'text', 'text' => $instance->getReadableOutput()]`.
- No matches → returns `[]`.

## Notes
- The exposed tool set is entirely determined by which AI function-call plugins are installed on the
  site; this plugin adds no functions of its own.
- Argument validation is the AI function's own (`ToolsFunctionOutput::validate()`).
- No `buildConfigurationForm()` override — only the generic Enable checkbox on `/admin/config/mcp`.
