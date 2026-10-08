<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `ai_context.permissions.yml`. Enforced by
`Entity\AiContextItemAccessControlHandler` (items), `Entity\AiContextUsageAccessControlHandler`
(usage), the function-call base `Plugin\AiFunctionCall\AiContextFunctionCallBase::hasContextPermission()`,
and the route `_permission` requirements. `administer ai context` is the entity `admin_permission`
and bypasses the item checks (except revision ops).

| Permission | restrict access | Grants |
|---|---|---|
| `administer ai context` | yes | Full admin: all settings routes, all item ops, agent config. |
| `view ai context items` | yes | The CCC listing + view items the user may see; own unpublished items. |
| `view any unpublished ai context item` | yes | View unpublished items regardless of author. |
| `create ai context item` | yes | Create items (`checkCreateAccess`). |
| `edit own ai context item` | yes | Edit items you authored. |
| `edit any ai context item` | yes | Edit any item. |
| `delete own ai context item` | yes | Delete items you authored. |
| `delete any ai context item` | yes | Delete any item. |
| `view all ai context item revisions` | yes | View revision history (also needs view on the item). |
| `revert all ai context item revisions` | yes | Revert revisions (also needs edit). |
| `delete all ai context item revisions` | yes | Delete revisions (also needs delete). |
| `schedule publishing of ai context items` | yes | Set Scheduler publish/unpublish dates. |
| `view scheduled ai context item` | yes | View items scheduled for publishing. |
| `access published ai context` | **no** | Use published context in AI features (selection + `context_tools`) and view published items — but not the editorial listing. |
| `view ai context usage` | yes | View the usage-tracking page/records. |

Notes:
- `access published ai context` is intentionally **not** restrict-access: it is the low-trust
  consumer permission that lets an AI feature surface already-published context. Authoring
  permissions (create/edit) are trusted because published context steers other users' prompts.
- The `context_tools` function-call plugins allow use when the caller has **any** of
  `access published ai context`, `view ai context items`, or `administer ai context`, and only
  ever expose **published** items.
- Push injection into an agent system prompt is governed by per-agent config
  (`allow_context_injection`), not by the running user's permission — only published items are
  ever rendered (`Service\AiContextRenderer` skips unpublished).
