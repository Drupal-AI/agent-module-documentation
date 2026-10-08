Node Revision Delete tracks and prunes old node revisions according to per-content-type rules, so the revision tables don't grow without bound. It deletes surplus revisions in the background via queue workers and cron, and also on demand through forms or Drush.

---

Drupal keeps every node revision forever by default, which bloats the database on content-heavy sites. This module lets administrators define, per content type, how many revisions to keep and/or how old a revision may be before it is eligible for deletion, using pluggable candidate strategies. Built-in `NodeRevisionDelete` plugins cover the common policies: `amount` (keep at most N revisions), `created` (delete revisions older than a time period), `drafts` (delete revisions newer than the current/default revision), and `only_drafts` (delete unpublished revisions older than the active one). Rather than deleting synchronously, it enqueues candidate nodes and processes them with queue workers on cron, with a configurable bulk-delete threshold and optional verbose logging; automatic queueing can be disabled if you prefer to run it manually. Site builders configure everything at Admin → Configuration → Content authoring → Node Revision Delete, including a form to reset a content type's settings and a queue form to trigger runs. Two Drush commands let you queue content or delete all prior revisions of a node from scripts and cron jobs. A public service (`node_revision_delete`) exposes methods to inspect previous revisions, check queue membership, and create queue items, and developers can add new deletion strategies by implementing the `NodeRevisionDelete` plugin type. It is a standard maintenance/housekeeping tool for keeping revision history under control.

---

- Keep only the last N revisions per content type.
- Delete node revisions older than a set age (e.g. 6 months).
- Prune orphaned draft revisions newer than the published version.
- Remove unpublished revisions older than the active revision.
- Shrink a bloated `node_revision` table on a large site.
- Reduce database size and speed up backups.
- Apply different retention rules to Articles vs Basic pages.
- Run revision cleanup automatically on cron.
- Disable automatic queueing to run pruning only on demand.
- Set a bulk-delete threshold to cap how much is processed per run.
- Enable verbose logging to audit what got deleted.
- Trigger a queue run from an admin form.
- Reset a content type's revision-delete configuration to defaults.
- Queue candidate nodes from the command line with Drush.
- Delete all prior revisions of a specific node via Drush.
- Enforce a data-retention/compliance policy on revision history.
- Clean up revisions after a large content migration or import.
- Free storage before provisioning a new environment from prod.
- Schedule nightly revision pruning in a deploy/cron pipeline.
- Inspect a node's previous revision IDs programmatically.
- Check whether a node is already queued for revision deletion in code.
- Create a queue item for a node from custom code.
- Add a custom pruning strategy via a NodeRevisionDelete plugin.
- Prune revisions per language on multilingual nodes.
- Prevent revision tables from degrading admin content-listing performance.
