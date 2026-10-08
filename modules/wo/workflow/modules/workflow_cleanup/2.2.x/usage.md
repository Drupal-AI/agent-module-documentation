<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Workflow Clean Up is a maintenance submodule of Workflow that provides a form to delete leftover **orphaned** workflow states (whose workflow no longer exists) and **inactive/deleted** states, along with the transitions that reference them.

---

A small submodule (do **not** enable on production). It adds one admin form at
`/admin/config/workflow/workflow/cleanup` (route `workflow.cleanup.settings`, permission
`administer workflow`, class `WorkflowCleanupSettingsForm`). The form lists two groups of states:
**Orphaned States** — `workflow_state` config entities whose parent workflow has been deleted
(`$state->getWorkflow()` is null) — and **Inactive (Deleted) States** — states that still belong to
a workflow but were marked inactive (`!$state->isActive()`). You tick the states to remove and
submit; for each, the form deletes every `workflow_config_transition` that uses the state as its
`from_sid` or `to_sid`, then deletes the state itself, reporting counts. It ships no config, no
schema, no permissions and no Drush; it is purely a manual cleanup UI. It exists because editing a
workflow can leave behind states/transitions that the normal UI no longer surfaces.

---

- Delete workflow states left orphaned after a workflow was removed.
- Remove states that were marked inactive/deleted but still linger in config.
- Clean up transitions that reference a deleted state.
- Tidy a development database after experimenting with workflows and states.
- Recover from a partially-deleted workflow that left dangling `workflow.state.*` config.
- Reduce config noise before a config export by pruning obsolete states.
- Fix a states list cluttered with old, unused states.
- Bulk-select several obsolete states and delete them in one submit.
- Investigate which states no longer belong to any workflow (the Orphaned States list).
- Investigate which states are inactive within an existing workflow (the Inactive States list).
- Prepare a workflow for hand-off by removing leftover cruft.
- Clear inactive states created while restructuring an editorial workflow.
- Remove states (and their transitions) that block a workflow from being deleted cleanly.
- Use as a one-off maintenance step, then uninstall (not meant to stay enabled in production).
- Confirm a workflow's state list is clean before adding it to content.
- Delete test states created during workflow development.
- Audit orphaned vs inactive states side by side before deciding what to purge.
- Complement the main Workflow module's admin UI when it can't reach stale states.
