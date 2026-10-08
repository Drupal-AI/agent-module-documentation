<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost AI — embedding backend, function-call bridge, generate tool

## Embedding backend (`src/Embedding/AiModuleEmbeddingBackend.php`)

Service `droost_ai.embedding`, implementing `droost_search`'s `EmbeddingBackendInterface`. Reuses the
site's AI-module **default embeddings** provider/model — it calls embeddings on the raw provider plugin
(`ProviderProxy::getPlugin()`) and reads the vector size via `embeddingsVectorSize($model_id)`.
Available only when a default embeddings provider is configured; otherwise `droost_search` runs
lexical-only. Registered as a candidate backend through `DroostAiServiceProvider` +
`Hook/DroostAiHooks` so `droost_search`'s `EmbeddingBackendManager` can pick it (when
`droost_search.settings.embedding_backend` allows). No injected-auth / proxy-normalized embedding
config is supported — it uses whatever the AI default resolves to.

## AI function-call bridge (`src/Plugin/AiFunctionCall/`)

Exposes Droost tools to the AI module's function-calling system so chat/assistants/automators can call
them.

- **`DroostToolDeriver`** builds one derivative per MCP tool, but `isEligible()` requires
  **both `definition->readOnly` AND `!definition->destructive`** — so write/eval tools are never
  exposed via AI even if an annotation were mis-set (fail-closed against a single wrong flag).
- **`DroostTool::execute()`** resolves the target tool (`mcp_tool_id` on the derivative), and before
  running it enforces `isPermitted()`: `currentUser->hasPermission('use droost ai tools')` **AND**
  `$tool->checkToolAccess($toolId, $currentUser)->isAllowed()`. On denial it returns
  "Access denied … requires the 'use droost ai tools' permission." It then runs the tool with the
  AI-supplied arguments and renders the `{success, message, data}` envelope as text.

This is a **stronger** gate than the raw MCP transport (which enforces no tool-level permission): the
AI surface is treated as untrusted, so it is permission-gated and read-only-only.

## `droost_ai_generate` (`src/Plugin/Tool/Generate.php`)

MCP tool (`id: droost_ai_generate`, extends `DroostToolBase`). Args: `prompt` (required), `context`
(optional). Uses the AI module's default chat provider (`AiProviderPluginManager`), with Droost's
`GuidelineProvider` output as the system prompt, and returns the generated code + the provider/model
used. `readOnly: FALSE` because it makes a real (billable) external LLM call, though it changes no site
state; `destructive: FALSE`, so no gate flag — it is safe by construction (produces text, writes
nothing). Degrades to `{success: false}` with a clear message when no chat provider is configured.

## Permission

`use droost ai tools` (`droost_ai.permissions.yml`, `restrict access: true`) — grant only to trusted
roles; its description warns these tools expose application internals (config, database, logs,
entities), never anonymous/untrusted users.
