# Group Term permissions

Group Term defines one **global** permission and one **group** permission; per-vocabulary create rights
come from Group's own generated relationship permissions.

## Global permission (`group_term.permissions.yml`)

| Permission | `restrict access` | Gates |
|---|---|---|
| `create any group_term entity` | **true** | Create any group term entity **regardless of per-group permission restrictions** — a blanket override. Because it is `restrict access: true`, treat it as a trusted-admin permission. Checked in `GroupTermOperationProvider::getGroupOperations()` alongside the per-group `create <plugin> entity` check. |

## Group permission (`group_term.group.permissions.yml`)

Registered in the Group permission matrix (per group role), **not** a global Drupal permission:

| Group permission | Gates |
|---|---|
| `access group_term overview` | View the group's Terms overview (`group/{group}/terms` `group_terms` view) and see the "Terms" operation/tab on the group. |

## Per-vocabulary create permissions (from Group)

Because `group_term` is a Group relation plugin with a per-vocabulary deriver, the Group module also
generates standard relationship permissions per group type/plugin, e.g. `create group_term:<vocab> entity`,
`update`, `delete`, `view`. The operation provider grants the "Create <vocabulary>" group operation when the
user holds `create group_term:<vocab> entity` (per group role) **or** the global
`create any group_term entity`.
