<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Droost Brain gives an AI coding agent a per-project knowledge base of exactly which modules are installed on this site and the extension patterns each one exposes, served as read-only MCP tools.

---

Droost Brain harvests the running Drupal container into a persisted "project brain" and serves it to agents over MCP. `RuntimeHarvester` walks the installed module list, entity-type manager, service container, route provider, event dispatcher, typed-config manager and Droost's own API/hook scanner to record, per module, the plugin types it defines (with a real example class), the plugin instances and entity types it provides, its hook implementations, event listeners and dependencies. `BrainBuilder` writes these into three tables via `BrainStorage` (droost_brain_module, droost_brain_pattern, droost_brain_capability); the tables are created lazily on the first `drush droost:brain:build` (alias `dbb`), so a site that never builds is byte-identical to before. `BrainSeeder`/`SeedReader` can bootstrap the brain from a shipped seed dataset (e.g. droost_knowledge's brain-seed) at install time so core-capability questions answer before the first build. `BrainStaleness` fingerprints the installed module set and git HEAD (via `droost.git_head`) and reports when the brain is stale. Three MCP tools read the brain — all read-only, all gated behind the mcp_server "access mcp server" permission, and all returning the standard `{success, message, data}` envelope: `droost_architecture`, `droost_capabilities`, `droost_module_patterns`. It is a developer-acceleration submodule for local development only.

---

- Give an agent a module-count-by-scope (core/contrib/custom) overview of the site via `droost_architecture`.
- Show the highest-count capabilities the installed modules expose, to orient an agent new to the codebase.
- Ask "what can THIS project do?" — list plugin types and entity types by provider with `droost_capabilities`.
- Filter capabilities to one kind, e.g. `capability: "block"` or `capability: "field.formatter"`.
- Answer "how do I extend module X?" with `droost_module_patterns` (pass `module: "node"`).
- Get a copyable example FQCN for each plugin type a module defines, so an agent can imitate real code.
- Narrow module patterns with `kind` (plugin_type, plugin_instance, entity_type, hook_impl, event_listener, module_deps).
- Build/refresh the brain deterministically with `drush droost:brain:build` (alias `dbb`).
- Bootstrap the brain from a shipped seed dataset so it answers before the first harvest.
- Detect when the brain is stale after enabling/uninstalling modules or moving git HEAD.
- Let an agent verify a module is installed before assuming an API exists.
- Discover which module provides a given plugin type before writing a new plugin.
- Feed accurate, version-correct capability data to an agent instead of stale training knowledge.
- Ground scaffolding decisions in what the project actually ships.
- Clean up brain tables and staleness state automatically on uninstall.
- Combine with droost_search/droost_graph to go from "who provides this" to "show me the code".
