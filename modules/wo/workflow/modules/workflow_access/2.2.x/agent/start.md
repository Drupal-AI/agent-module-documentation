<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Workflow Access — agent index

Workflow submodule: controls **node** access per workflow **state** and role (view/update/delete),
enforced through core's node grant system. Depends on `workflow`. Node-only. No permissions/Drush
of its own; uses `administer workflow`.

- **Grant per-state view/update/delete to roles; where grants & priority are stored** →
  [configure/access.md](configure/access.md)
- **How it maps grants to node access records/grants (realms, rebuild)** →
  [api/node-access.md](api/node-access.md)

Key facts: per-state grants live in config **`workflow_access.role`**, keyed by state id (`sid`),
value = `role => {grant_view, grant_update, grant_delete}`. Conflict priority is
`workflow_access.settings:workflow_access_priority`. Access tab route
`entity.workflow_type.access_form` = `/admin/config/workflow/workflow/{workflow_type}/access`;
global settings at `/admin/config/workflow/workflow/access` (route `workflow.access.settings`).
Realms: `workflow_access` and `workflow_access_owner`.
