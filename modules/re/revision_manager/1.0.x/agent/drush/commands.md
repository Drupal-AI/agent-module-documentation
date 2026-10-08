<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Revision Manager ships one Drush command (`RevisionManagerCommands`, tagged `drush.command`).

## `rm:queue`

```bash
drush rm:queue
```

Batch-enqueues **all enabled entities** (across every entity type enabled in
`revision_manager.settings`, respecting each type/bundle's enabled plugins) into the
`remove_revisions` queue for revision cleanup. It runs
`RevisionManagerBatch::run(ENQUEUE_TYPE_DRUSH)`:
- prints a title, then
- on success: "Batch processing complete. Entities have been queued for revision cleanup.";
- if nothing matched: a warning "No entities were found to queue for revision cleanup."

It **enqueues** work; the actual revision deletion happens when the `remove_revisions` queue is
processed (e.g. by cron, or `drush queue:run remove_revisions`). Typical usage is from cron or
CI to periodically schedule pruning of all managed entities.

There are no other Drush commands; per-entity or ad-hoc runs go through the settings form's
"Enqueue enabled entities now" checkbox or automatic queue-on-save.
