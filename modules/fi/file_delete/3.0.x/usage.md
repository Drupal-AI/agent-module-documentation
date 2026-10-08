File Delete lets administrators delete managed file entities (both public and private) from the Drupal admin UI by replacing core's file delete form with one that adds usage-safety checks, an optional immediate-delete, and an optional force-delete.

---

File Delete replaces the form used at the core file entity delete route by implementing `hook_entity_type_build()` to set the `delete` form class of the `file` entity to its own `FileDeleteForm`. By default deleting a file changes it from `Permanent` to `Temporary` status (via `setTemporary()` + `save()`); Drupal's `file_cron()` then removes temporary files on a later cron run (default after ~6 hours, configurable at the core File System settings). Before deleting, the form checks `file.usage` (`FileUsageInterface::listUsage()`): if the file is registered as in use it refuses to delete and links the user to the file's usages view. Two permission-gated checkboxes extend this: "delete files immediately" skips the temporary step and deletes the file right away, and "delete files override usage" removes the usage records and deletes anyway (which may leave broken links or media — the form warns about this). The module also ships two `file`-type Action plugins for bulk operations in a Files view: `file_delete_mark_temporary` (Mark file for deletion) and `file_delete_immediately` (Immediately delete, filesystem + `file_managed` row), both of which run the same usage check first. It depends only on core `file` and adds no configuration UI or Drush commands.

---

- Delete a public managed file from the admin Files listing by marking it temporary for cron cleanup.
- Delete a private managed file the same way through the admin UI.
- Add a "Link to delete File" field to the Files view so each file row has a delete link.
- Refuse to delete a file that is still registered as in use, and show which modules use it.
- Follow a link straight to a file's usages when a delete is blocked.
- Immediately delete a file (skip the temporary/cron step) when granted "delete files immediately".
- Force-delete a file that has usage records, accepting possibly broken links, with "delete files override usage".
- Remove stale `file` usage records that are keeping a file from being deleted.
- Bulk mark many files for deletion at once with the "Mark file for deletion" action in a view.
- Bulk immediately delete many files with the "Immediately delete (with usage checks)" action.
- Clean up orphaned uploads that are no longer referenced by any entity.
- Free disk space by removing large unused files from public/private storage.
- Let a media workflow delete the underlying file after its Media entity has been removed.
- Give a content-manager role the ability to delete files without full admin rights.
- Reserve force/immediate deletion for trusted roles via restricted permissions.
- Warn editors before an override-usage delete that links or media may break.
- Delete a file directly from filesystem and drop its `file_managed` row (immediate action).
- Keep the default safe behavior where deletion just defers to cron cleanup.
- Confirm a deletion through a standard "Are you sure?" confirm form showing filename and URI.
- Return the user to the Files view after a delete or cancel.
- Understand temporary-vs-permanent file status when planning cleanup.
- Audit which modules reference a file before deciding to delete it.
- Replace core's plain file delete form with usage-aware behavior site-wide.
- Programmatically mark a file temporary in code so cron removes it.
- Batch-process large file cleanups after a content migration.
