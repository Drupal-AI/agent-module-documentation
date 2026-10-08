<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Droost AI bridges Droost to the Drupal AI module: it reuses the site's configured embeddings provider for droost_search, exposes Droost's read-only tools as AI function calls, and adds an AI code-generation MCP tool.

---

Droost AI is an optional submodule that connects Droost to `drupal/ai`. It registers an embedding backend (`AiModuleEmbeddingBackend`) that reuses whatever embeddings provider and model the site set as its AI default — so `droost_search`'s semantic code index can be built without configuring a separate embedding endpoint. It also bridges Droost's read-only introspection tools into the AI module's function-calling system (`DroostTool` + `DroostToolDeriver`, one function per read-only tool), gated by the dedicated `use droost ai tools` permission and each tool's access check, so a site's chat/assistants/automators can query the codebase on a permitted account's behalf. Finally it adds the `droost_ai_generate` MCP tool, which generates Drupal code from a natural-language prompt using the site's configured chat provider, primed with Droost's guidelines. It depends on `droost_search` and `ai`, and like all of Droost is for local/trusted development only.

---

- Build droost_search's semantic index using the site's existing AI embeddings provider (no separate endpoint).
- Reuse the AI module's default embeddings model/dimension for code retrieval.
- Let the site's AI chat/assistant call Droost's read-only introspection tools as function calls.
- Restrict AI-driven tool use to trusted roles via the `use droost ai tools` permission.
- Keep write/eval tools out of the AI surface (only read-only, non-destructive tools are exposed).
- Generate Drupal code from a natural-language prompt with the configured AI provider.
- Prime AI code generation with Droost's house guidelines/conventions.
- Ask an assistant "what entity types does this site have?" and have it call `droost_entities`.
- Degrade cleanly to lexical-only search when no default embeddings provider is configured.
- Degrade cleanly with a `{success: false}` message when no chat provider is configured.
- Add AI-provider-backed capabilities without hardcoding a model or key in Droost.
- Wire an AI agent (ai_agents) to the codebase-introspection tool set.
