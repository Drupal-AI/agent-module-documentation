<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Autopilot MCP (menu_autopilot_mcp) — agent index

**Optional Tool API plugins for Menu Autopilot, governed by MCP Sentinel.** Version **1.4.x** (release 1.4.1). Core `^10.6 || ^11.3`. Ships inside the `menu_autopilot` project as a submodule.

Depends on `menu_autopilot:menu_autopilot`, `mcp_sentinel:mcp_sentinel (>=2.22.0)`, and `tool:tool (>=1.0.0-beta8)`. The base module gains no dependency; enable this submodule only to expose the tools.

Why it exists: Menu Autopilot's `menu_autopilot` and `menu_autopilot_dynamic` base fields are internal, so JSON:API and GraphQL omit them and an MCP/API client cannot otherwise tell an automatic child from a curated link. These three Tool API plugins give a governed, read-first view and one safe write.

- **The three MCP tools** → [tools](tools/tools.md) — `menu_autopilot_status` (read), `menu_autopilot_link_info` (read), `menu_autopilot_normalize_uris` (write). Governance, inputs, outputs, and the shared base class.
- **Permissions** → [permissions](permissions/permissions.md) — `use menu autopilot mcp tools` (all tools) and `normalize menu link uris via mcp` (the write tool).

All tools extend `MenuAutopilotToolBase` (`src/Plugin/tool/Tool/`), which subclasses MCP Sentinel's `McpGovernedToolBase`: per-call permission recheck, strict input validation, rate limiting via the resolved policy profile, a response-size cap (min of a 131072-byte ceiling and the profile cap), and a single fixed refusal message. Caller input, exception text, label patterns, and node field values never reach a result. Tool results come from `NavSyncManager` (`parentStatus()`, `normalizeNodeUris()`) and `_menu_autopilot_link_data()`.

Parent module docs: [menu_autopilot agent index](../../../../1.4.x/agent/start.md).
