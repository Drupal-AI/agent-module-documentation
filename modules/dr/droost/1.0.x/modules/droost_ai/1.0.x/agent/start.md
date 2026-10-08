<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Droost AI (droost_ai) — agent index

Optional submodule of **Droost** that bridges it to the Drupal AI module (`drupal/ai`). Version
1.0.0-rc1 (dir `1.0.x`). Core `^10.5 || ^11.2 || ^12`, PHP `^8.3`. Depends on `droost_search` and `ai`.
Local development only (inherits Droost's deployment rules).

## Provides

- **Embedding backend** `AiModuleEmbeddingBackend` (service `droost_ai.embedding`, implements
  `droost_search`'s `EmbeddingBackendInterface`) — reuses the site's AI default embeddings
  provider/model (`ProviderProxy::getPlugin()`), so semantic indexing needs no separate endpoint;
  lexical-only when none is configured. Wired in via `DroostAiServiceProvider` / `DroostAiHooks`.
- **AI function-call bridge** — `Plugin/AiFunctionCall/DroostTool` + `Derivative/DroostToolDeriver`:
  one AI function per Droost tool, but **only `readOnly && !destructive` tools** are exposed.
  Execution requires the **`use droost ai tools`** permission AND `checkToolAccess()`.
- **MCP tool** `droost_ai_generate` (`Plugin/Tool/Generate.php`, extends `DroostToolBase`,
  `readOnly: FALSE` because it makes a billable LLM call) — generates Drupal code from a `prompt`
  (+ optional `context`) using the configured chat provider and Droost's guidelines as the system
  prompt; degrades to `{success: false}` when no chat provider exists.
- **Permission** `use droost ai tools` (`droost_ai.permissions.yml`, `restrict access: true`).

## Solution doc

- The embedding backend, the function-call bridge, and the generate tool →
  [tools/ai-bridge.md](tools/ai-bridge.md)
