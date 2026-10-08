<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Workflow Clean Up — agent index

Workflow submodule: a manual maintenance form to delete **orphaned** and **inactive** workflow
states (and the transitions referencing them). Depends on `workflow`. Not for production. No
config, schema, permissions, or Drush of its own.

- **The cleanup form: what it lists, what it deletes, and the route** →
  [configure/cleanup.md](configure/cleanup.md)

Key facts: form route `workflow.cleanup.settings` = `/admin/config/workflow/workflow/cleanup`
(permission `administer workflow`, class `WorkflowCleanupSettingsForm`). "Orphaned" =
`workflow_state` whose `getWorkflow()` is null; "Inactive" = state belonging to a workflow but
`!isActive()`. Submitting deletes each selected state plus every `workflow_config_transition`
using it as `from_sid`/`to_sid`.
