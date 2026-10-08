<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# MCP AI — agent index

Submodule of [Model Context Protocol](../../../../1.0.x/agent/start.md). Provides one `mcp` plugin,
`ai-function-calling`, exposing every Drupal AI module function-call (`ai.function_calls`) as an MCP
tool. Depends on `mcp` + `ai`. Reached through the parent's `/mcp/get` + `/mcp/post` endpoints
(gated by `access content`).

- **The `ai-function-calling` plugin: list & execute AI function-calls as tools** →
  [plugins/ai-function-calling.md](plugins/ai-function-calling.md)

Key facts:
- `checkRequirements()` requires the `ai.function_calls` service.
- `getTools()` returns one MCP `Tool` per registered AI function-call (name, description, parameter
  JSON schema).
- `executeTool()` finds the matching `ExecutableFunctionCallInterface`, validates arguments, runs
  `execute()`, returns `getReadableOutput()` as text.
- No plugin-specific config form.
