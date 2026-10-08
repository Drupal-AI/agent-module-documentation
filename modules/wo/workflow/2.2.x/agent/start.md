<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Workflow — agent index

A configurable state machine attached to entities as a **field**. You define a Workflow
(`workflow_type` config entity) with **states** and role-restricted **transitions**, then add a
`workflow` field to a bundle to move content between states with a recorded history. Depends on
core `field`, `options`, `user`. Admin UI at `/admin/config/workflow/workflow`
(route `entity.workflow_type.collection`, permission `administer workflow`). No Drush.

- **Create a Workflow, its states & transitions, workflow options, and attach it to content** →
  [configure/workflows.md](configure/workflows.md)
- **Execute/read transitions programmatically; the manager, events & global functions** →
  [api/transitions.md](api/transitions.md)
- **The `workflow` field type, widgets, formatters, Actions, Block & Views plugins** →
  [plugins/field.md](plugins/field.md)
- **Hooks the module invites (`hook_workflow`, `*_operations`, `*_comment_alter`, `*_alter`)** →
  [hooks/hooks.md](hooks/hooks.md)
- **The dynamic per-workflow permissions and what each gates** →
  [permissions/permissions.md](permissions/permissions.md)

Submodules (own docs under `modules/workflow/modules/<sub>/2.2.x/`): `workflow_access`,
`workflow_cleanup`, `workflow_devel`, and the obsolete/residual `workflowfield`,
`workflow_operations`, `workflow_ui`.

Key facts: config prefixes `workflow.workflow.<wid>` (type), `workflow.state.<sid>` (state,
sid usually `<wid>_<name>`, includes an implicit `<wid>_creation`), `workflow.transition.<tid>`
(config transition). Executed transitions are `workflow_transition` content entities in table
`workflow_transition_history`. A field of type `workflow` binds to a workflow via its storage
setting `workflow_type`.
