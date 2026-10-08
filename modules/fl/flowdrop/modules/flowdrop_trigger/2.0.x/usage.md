<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FlowDrop Trigger runs workflows in response to Drupal events — an entity created, updated or deleted.

---

A workflow that has to be started by hand is a tool; a workflow that starts itself is automation. This submodule supplies the connection between Drupal's entity lifecycle and FlowDrop's execution: when a node is published, a user registers, a media item is uploaded or a record is deleted, a workflow runs.

That covers most of what people actually want automation for — notify a team when content enters review, summarise an article on save, sync a record to a CRM when it changes, clean up related data on delete. Each of those is a hook someone would otherwise write, with the difference that the logic is editable by whoever owns the process rather than by whoever owns the codebase.

Two things to be deliberate about. **Recursion**: a workflow triggered by an entity update that itself updates that entity will trigger itself, and the guard for that needs to be explicit. And **volume**: a trigger on a frequently changing entity type means a workflow run per change, so check what that does to the queue before enabling it on a busy content type.

---

- Run a workflow when content is created.
- React to a content update.
- React to an entity being deleted.
- Notify a team when content enters review.
- Summarise an article automatically on save.
- Sync a record to a CRM when it changes.
- Clean up related data on delete.
- Trigger a workflow on user registration.
- React to a media upload.
- Replace a custom hook with an editable workflow.
- Let a process owner change automation rules.
- Restrict triggers to specific bundles.
- Guard against a workflow triggering itself.
- Estimate queue volume before enabling a trigger.
- Disable a trigger without deleting the workflow.