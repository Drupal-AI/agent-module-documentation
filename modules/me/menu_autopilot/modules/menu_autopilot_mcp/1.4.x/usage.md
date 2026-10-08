<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Optional Tool API plugins that let an MCP client read Menu Autopilot status, inspect one menu link, and normalise editorial URIs, all governed by MCP Sentinel.

---

Menu Autopilot MCP is an optional submodule of Menu Autopilot that publishes three [Tool API](https://www.drupal.org/project/tool) plugins governed by [MCP Sentinel](https://www.drupal.org/project/mcp_sentinel), so an AI agent or MCP client can work with autopilot-managed menus safely. Because Menu Autopilot's two bookkeeping base fields are internal, JSON:API and GraphQL omit them and a client cannot otherwise tell a managed automatic child from a hand-curated link — these tools close that gap. `menu_autopilot_status` (read) lists the dynamic parents in the managed menus with counts of owned/adoptable/extra/disabled children and the disabled children by title and node id. `menu_autopilot_link_info` (read) reports, for one menu link UUID, whether it is a dynamic parent, an automatic child, or neither, and exactly what a client edit would do to it. `menu_autopilot_normalize_uris` (write) runs the module's URI normalisation for one to ten named managed menus, reads each change back from storage, and says whether it reached the live link. Every tool re-checks its permission, validates its inputs strictly, caps its result size, rate-limits through the resolved MCP Sentinel policy profile, and never relays caller input or exception text; no tool returns a label pattern or a node field value. The write tool needs its own permission on top of the shared read permission. Requires the base `menu_autopilot` module plus `mcp_sentinel` (>=2.22) and `tool` (>=1.0.0-beta8).

---

- Let an MCP/AI client discover which menu links are Menu Autopilot dynamic parents.
- List every dynamic parent in the managed menus with per-parent child counts.
- See counts of owned, adoptable, extra, and disabled automatic children per parent.
- Find automatic children that are disabled and do not show in a menu.
- Distinguish children a sync save disabled from children an editor disabled.
- Read a parent's source type and existing-children policy without touching config.
- Inspect a single menu link by UUID before an API client edits it.
- Learn whether a link is a dynamic parent, an automatic child (and of which node), or plain.
- Predict what renaming, re-weighting, moving, or deleting a link will do under autopilot.
- Detect that a link sits under a dynamic parent that would delete or adopt it on the next sync.
- Normalise editorial node link URIs (e.g. `/node/12/latest`) to canonical `entity:node/12` via MCP.
- Restrict URI normalisation to one to ten named managed menus per call.
- Confirm each normalised URI reached the live link (the `applied` flag) rather than a pending revision.
- Detect a save refused part way through a normalise run (the `completed` / `failed_menu` fields).
- Govern all three tools with MCP Sentinel rate limits and response-size caps.
- Gate read tools behind `use menu autopilot mcp tools` and the write tool behind an extra permission.
- Give an AI agent a safe, read-first view of navigation without exposing internal fields.
- Audit navigation state from an MCP client without shell or Drush access.
