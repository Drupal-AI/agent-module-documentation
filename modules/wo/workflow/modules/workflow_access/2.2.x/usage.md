<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Workflow Access controls **node** access by workflow state: for each state of a workflow you grant view / update / delete to specific roles, and Drupal's node grant system then enforces those permissions as content moves between states.

---

A submodule of Workflow. It adds an **Access** tab to each workflow (`/admin/config/workflow/workflow/{workflow_type}/access`) where, per **state**, you tick view/update/delete for each role. Those grants are stored in the config object `workflow_access.role`, keyed by state id (`sid`), each value a map of `role => {grant_view, grant_update, grant_delete}`. The module implements `hook_node_access_records()` / `hook_node_grants()` to publish those as node access grants under the realms `workflow_access` and `workflow_access_owner` (the latter for the content author), so a node's current workflow state decides who may see or edit it. Because it rides on core's **node_access** system, it works **only for `node` entities** (one workflow per entity type). A settings form (`/admin/config/workflow/workflow/access`) exposes `workflow_access_priority` (config `workflow_access.settings`) to resolve conflicts with other node-access modules. Changing grants flags a node-access rebuild. It has no permissions or Drush of its own.

---

- Hide Draft nodes from anonymous users while letting editors see and edit them.
- Let only a Reviewer role view content in a "Needs Review" state.
- Grant update access to authors only while content is in Draft, and lock it once Published.
- Make Published nodes viewable by everyone but editable only by editors.
- Restrict delete access so content can only be deleted in an "Archived" state.
- Give the content author (owner) different access than other users in the same role (owner realm).
- Enforce editorial confidentiality by denying view to most roles until a "Published" state.
- Combine per-state grants with the parent Workflow's per-transition role permissions for full control.
- Raise or lower `workflow_access_priority` so Workflow Access wins (or yields) against other node-access modules.
- Model a legal/medical review pipeline where each stage exposes content to a different team.
- Prevent editors from modifying content that has moved into an approval state.
- Allow a "Legal" role view-only access during a compliance-review state.
- Keep unpublished/embargoed news hidden until it transitions to Published.
- Provide staged visibility for a multi-step publishing process on the Article type.
- Deny all access to a "Rejected" state except to administrators.
- Grant view to a partner role only for content in a "Shared" state.
- Ensure a node-access rebuild happens automatically after you change state access rules.
- Configure state access as exportable config (`workflow_access.role`) for repeatable deployments.
- Use it alongside the Workflow transition history to audit who could act at each stage.
- Restrict who can edit while a scheduled transition is pending.
