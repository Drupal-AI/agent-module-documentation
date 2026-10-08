<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
MCP AI is a submodule of Model Context Protocol that provides an `ai-function-calling` MCP plugin, exposing every function-call plugin registered with the Drupal AI module (`ai.function_calls`) as an MCP tool that LLM clients can list and invoke.

---

The submodule (depends on `mcp` and `ai`) ships a single `#[Mcp(id: 'ai-function-calling')]` plugin, `AiFunctionCalling`, reachable through the parent module's `/mcp/get` + `/mcp/post` endpoints. `checkRequirements()` returns TRUE only when the `ai.function_calls` service is available. `getTools()` iterates all AI function-call definitions, instantiates each, normalizes it, and returns an MCP `Tool` per function with its name, description, and parameter JSON schema (so `tools/list` advertises the whole AI function-call catalog). `executeTool()` matches the requested tool name to an `ExecutableFunctionCallInterface` instance, wraps the caller's arguments in a `ToolsFunctionOutput`, validates them, populates values, calls `execute()`, and returns the function's readable output as MCP text. It has no plugin-specific configuration form. The set of exposed actions is exactly whatever AI function-calls are installed.

---

- Expose all Drupal AI module function-calls to an LLM client as MCP tools.
- Let an MCP client list available AI functions via `tools/list`.
- Invoke a Drupal AI function-call from an external LLM through `tools/call`.
- Bridge the Drupal AI function-calling framework to any MCP-capable host (Claude, Zed, etc.).
- Advertise each AI function's parameter JSON schema to a client for structured calls.
- Return an AI function's readable output back to the LLM as MCP text content.
- Reuse existing `ai.function_calls` plugins without writing MCP-specific code.
- Give an agentic workflow access to Drupal-side AI tools over a standard protocol.
- Let a client discover and call a content-summarization AI function exposed by another module.
- Chain MCP tool calls that trigger Drupal AI operations.
- Prototype AI agents that act on the site via registered function-calls.
- Surface a custom `ExecutableFunctionCallInterface` implementation to MCP automatically.
- Validate LLM-supplied arguments against a function's schema before execution.
- Centralize AI tool exposure through MCP instead of bespoke endpoints.
- Provide an LLM host a uniform interface over heterogeneous AI function-calls.
- Enable multi-server MCP agents to combine Drupal AI tools with other tool providers.
