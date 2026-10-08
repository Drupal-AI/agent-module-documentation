<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Autopilot MCP — Tool API plugins

Three [Tool API](https://www.drupal.org/project/tool) plugins in `src/Plugin/tool/Tool/`, all governed by [MCP Sentinel](https://www.drupal.org/project/mcp_sentinel). They read from the base module's `menu_autopilot.sync_manager` service (and `_menu_autopilot_link_data()`) and never expose a label pattern or a node field value.

## Shared base — `MenuAutopilotToolBase`

Abstract base (`MenuAutopilotToolBase.php`) extending `McpGovernedToolBase` and using `McpEntityToolTrait`. Every concrete tool implements `run(array $values): array`; the base's `doExecute()` wraps it with:

- **Access** — `checkGovernedAccess()` / `checkGovernedDiscoveryAccess()` require `use menu autopilot mcp tools` plus any `extraPermissions()` via `AccessResult::allowedIfHasPermissions()` (cache max-age 0). `doExecute()` also re-checks `checkAccess()` for direct PHP callers (Tool API's `execute()` does not call `access()`).
- **Input strictness** — any submitted key not in `getInputDefinitions()` is a caller error → refusal (not a silent no-op).
- **Governance** — resolves the caller's MCP Sentinel policy profile (`governancePolicyResolver->resolve()`); refuses when none. Applies `checkRateLimit()`, then caps the JSON-encoded result at `resultLimit()` = min of `MAX_RESULT_BYTES` (131072) and the profile's `effectiveResponseSizeCap()` when set.
- **No leakage** — a caught `\Throwable` logs only the exception class, file basename, and line; the caller always gets the one fixed message `refused()`. Success returns `ExecutableResult::success()` with the result array.

## `menu_autopilot_status` (read) — `StatusTool`

- **Operation:** `ToolOperation::Read`. **Inputs:** none. **Permission:** `use menu autopilot mcp tools`.
- **Does:** returns `NavSyncManager::parentStatus(50, 25)` — the dynamic parents in the managed menus, each with uuid, title, menu, enabled, source_type, existing-children policy, and counts of `owned` / `adoptable` / `extra` / `disabled` / `disabled_by_save` children, plus up to 25 listed disabled children (title + node id, marked when a sync save left them disabled). Caps at 50 parents; `parents_total` still counts them all. Reports current state, not what the next sync will do.

## `menu_autopilot_link_info` (read) — `LinkInfoTool`

- **Operation:** `ToolOperation::Read`. **Input:** `link` (string, required) — a menu_link_content UUID, validated by a strict UUID `Regex` constraint and re-validated with `Uuid::isValid()` in `run()`. **Permission:** `use menu autopilot mcp tools`.
- **Does:** loads the link by UUID (`entity.repository`) and reports `found`, `role` (`dynamic_parent` | `managed_child` | `plain`), `menu`, `menu_is_managed`, `enabled`, `node` (for a managed child), `disabled_by_save`, `source_type` and `existing_children` (for a parent), `under_dynamic_parent`, `parent_existing_children`, and a plain-language `effect_of_client_edit` describing what renaming/re-weighting/moving/deleting the link would do under autopilot (e.g. a managed child's title/URI are overwritten on the next parent sync; a plain child under a `replace` parent is deleted). Returns a not-found result for an unknown UUID. Never returns a label pattern or node field value.

## `menu_autopilot_normalize_uris` (write) — `NormalizeUrisTool`

- **Operation:** `ToolOperation::Write`. **Input:** `menus` (string, required, multiple) — one to ten menu machine names, each validated by a per-item `Regex` (`/^[a-z0-9_-]{1,32}$/D`) and, in `menus()`, required to be one of `NavSyncManager::managedMenus()`. **Permissions:** `use menu autopilot mcp tools` **and** `normalize menu link uris via mcp` (`extraPermissions()`).
- **Does:** runs `NavSyncManager::normalizeNodeUris([$menu])` **one menu at a time** so a save refused in a later menu does not hide writes already made. For each reported change it reads the live link back from storage (`loadUnchanged()`) and sets `applied` (false when the save became a pending revision instead of reaching the live link). Returns `menus`, `completed` (false if a menu threw), `failed_menu`, `changed_total`, `applied_total`, `changes` (link_id, canonical `to`, `applied`; the pre-change URI is never returned), and `changes_truncated`. Lists at most 100 changes. Safe to repeat: canonical links are left alone. Logs the applied/total count and acting uid; exception details are logged (class/file/line) but never relayed.

## Notes

- The tools carry no config schema, no routes, and no Drush commands. They are discovered by the Tool API plugin manager (`#[Tool(...)]` attributes) and governed entirely through MCP Sentinel and the two permissions.
- `menu_autopilot_status` and `menu_autopilot_link_info` are read-only; only `menu_autopilot_normalize_uris` writes, and it only ever rewrites a node link URI to the canonical `entity:node/<nid>` form.
