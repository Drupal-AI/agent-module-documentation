<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Autopilot MCP — permissions

Two permissions (`menu_autopilot_mcp.permissions.yml`), both `restrict access: true`:

| Permission | Machine name | Gates |
|---|---|---|
| Use Menu Autopilot MCP read tools | `use menu autopilot mcp tools` | Every tool in the submodule. Read the dynamic-parent/automatic-child status of the managed menus (counts, titles, node ids) through `menu_autopilot_status` and `menu_autopilot_link_info`. Never returns a label pattern or a node field value. |
| Normalise menu link URIs through MCP | `normalize menu link uris via mcp` | The write tool `menu_autopilot_normalize_uris`, on top of the read permission. Rewrite editorial node link URIs to canonical ones in named managed menus. |

Enforcement: `MenuAutopilotToolBase::checkGovernedAccess()` requires `use menu autopilot mcp tools` for all tools; `NormalizeUrisTool::extraPermissions()` adds `normalize menu link uris via mcp`. Access is checked via `AccessResult::allowedIfHasPermissions()` and re-checked per call in `doExecute()`, so a direct PHP caller is gated too. All access is layered on top of MCP Sentinel's policy-profile governance (rate limits and response-size caps).
