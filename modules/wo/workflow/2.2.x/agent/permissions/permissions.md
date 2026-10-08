<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

## Static permission

- **`administer workflow`** (`restrict access: true`) — create/edit/delete Workflows, states and
  transitions; gates every `/admin/config/workflow/workflow*` route.

## Dynamic per-workflow permissions

`WorkflowPermissions::getPermissions()` generates a set of permissions **for each workflow type**
(`<wid>` = the workflow id). These are what you grant to roles to let them participate:

| Permission (per `<wid>`) | Grants |
|---|---|
| `create <wid> workflow_transition` | **Participate** — the role may execute state transitions. (The per-transition role settings on the workflow's *Transitions* page refine this further.) |
| `schedule <wid> workflow_transition` | May schedule a transition for a future time. |
| `access own <wid> workflow_transion overview` | See the "Workflow history" tab on **own** content. |
| `access any <wid> workflow_transion overview` | See the "Workflow history" tab on **any** content. |
| `access <wid> workflow_transition form` | See the transition block/widget & submit a change on the entity page. |
| `edit own <wid> workflow_transition` | Edit the comment of own executed transitions. (`restrict`) |
| `edit any <wid> workflow_transition` | Edit the comment of any executed transitions. (`restrict`) |
| `revert own <wid> workflow_transition` | Revert own last transition. (`restrict`) |
| `revert any <wid> workflow_transition` | Revert any last transition. (`restrict`) |
| `bypass <wid> workflow_transition access` | Ignore all transition restrictions (superuser-like). (`restrict`) |

Note the historical typo **`transion`** (not "transition") in the two overview permission
machine names — match it exactly when granting.

On workflow creation, all roles (except the special Author) get a default
`create <wid> workflow_transition` grant (`changeRolePermissions()`); tighten this per role.

## Granting

```bash
drush role:perm:add editor 'create my_wf workflow_transition'
drush role:perm:add editor 'access any my_wf workflow_transion overview'
```

Per-transition role control (which role may use a specific `from → to` edge) is configured on the
workflow's **Transitions** tab (`/admin/config/workflow/workflow/{wid}/transition_roles`), stored
in each `workflow_config_transition`'s `roles` list.
