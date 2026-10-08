<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Optional Field Guard submodule that exposes two read-only, MCP-Sentinel-governed Tool API plugins for discovering which fields Field Guard protects and the guard's verdict for the acting account — names only, never field values.

---

Field Guard MCP is an optional submodule of Field Guard. It answers a question an API/AI client cannot otherwise resolve: which fields does Field Guard protect, and would the acting account pass the guard? A write to a guarded field fails with a 403 only after the request is sent, and a read is worse — JSON:API leaves a view-denied field out of the resource and GraphQL returns `null`, so a guarded field looks like an empty one. The submodule adds two [Tool API](https://www.drupal.org/project/tool) plugins, both declared `ToolOperation::Read`: `field_guard_list_guarded` lists an entity type's guarded fields with the permission each operation requires and the own-subject flag (up to 500, with a `truncated` marker), and `field_guard_check_access` reports the guard's verdict on up to 50 named fields for the acting account only. Both return entity type, bundle, field and permission names — never a field value, and no tool loads an entity. Every tool extends `FieldGuardToolBase` (a `McpGovernedToolBase`), requires the restricted `use field guard mcp tools` permission, and is gated by MCP Sentinel's profile resolution, rate limiting, and response-size cap before it runs; its own refusals are one fixed message that never relays caller input. The verdict comes from the same `ExplicitPermissionChecker::hasExplicitPermission()` the access hook uses, so user 1 and an `is_admin` role are reported as denied unless a non-admin role explicitly holds the permission. The submodule requires Tool API and MCP Sentinel; because MCP Sentinel does not declare Drupal 12 yet, the submodule declares `^10.6 || ^11.3` while the base module keeps its wider range. Installing it publishes nothing by itself — enable the tools in your site's MCP tool bridge configuration.

---

- Let an MCP/AI client discover which fields Field Guard protects on an entity type.
- List guarded fields for a single bundle, or across every bundle in the map.
- See the permission name that unlocks each guarded operation (`view`, `edit`).
- Learn which fields carry the own-subject view exemption (`view_exempt_own_subject`).
- Identify fields that read as empty/null in JSON:API or GraphQL because they are view-guarded.
- Check, before writing, whether the acting account passes the guard on up to 50 fields at once.
- Distinguish a guarded-but-denied field (`allowed: false`) from an unguarded one (`allowed: null`).
- Confirm that user 1 or an admin role is still denied a field unless a non-admin role grants it.
- Read the required permission name alongside each field's verdict to plan a role change.
- Keep an AI agent from writing a field it would be forbidden to set, avoiding a post-hoc 403.
- Gate all of this behind the restricted `use field guard mcp tools` permission.
- Rely on MCP Sentinel for permission, source readiness, scope, IP policy, and rate limiting.
- Cap tool output to a fixed byte ceiling (and the profile's smaller response-size cap).
- Get a single fixed refusal message that never echoes back caller input on error.
- Audit only failure class, file and line in the log — never caller input or field values.
- Integrate Field Guard state into an MCP tool bridge without writing any custom code.
- Avoid exposing any write, cross-user, or value-reading capability — read-only by design.
