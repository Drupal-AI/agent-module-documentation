<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Fancy File Delete is an administrative housekeeping tool that removes files Drupal's UI cannot easily clear: managed files by file ID (FID), orphaned managed files still referenced by deleted nodes, and unmanaged files sitting on disk that were never tracked in `file_managed`.

---

The module adds an admin section at **Admin → Config → Content → Fancy File Delete** (`/admin/config/content/fancy_file_delete`) plus a Drush command. It offers four deletion workflows: (1) a **LIST** view of every managed file with Views Bulk Operations (VBO) actions to delete or *force*-delete selected rows; (2) a **MANUAL** form where you paste FIDs (one per line) and optionally force the delete; (3) an **ORPHANED** filter (`ffd_orphan_filter`, added to the `file_managed` Views data as "Orphan File Delete") that surfaces managed files whose only `file_usage` reference is a `node` that no longer exists; and (4) an **UNMANAGED** view backed by an `unmanaged_files` content entity that scans the public/private file directories for files absent from `file_managed`. A normal delete calls `File::delete()` and refuses when the file is still referenced; a **force** delete bypasses that by deleting the `file_managed` and `file_usage` rows and the entity directly. All deletions run through the `fancy_file_delete.batch` service (`FancyFileDeleteBatch::setBatch()`), and the Drush command `fancy:file-delete` (aliases `ffd`, `fancy-file-delete`) accepts a comma-separated list of FIDs with an optional `--force`. Access to the admin pages is gated by the `administer fancy file delete` permission; the unmanaged-files entity has its own CRUD permissions.

---

- Bulk-delete a large set of managed files from the LIST view without clicking each one.
- Force-delete files that Drupal refuses to remove because they are still referenced in `file_usage`.
- Clean up orphaned files left behind after nodes were deleted but their file references were not.
- Reclaim disk space by deleting unmanaged files that exist on disk but were never recorded in `file_managed`.
- Delete a single problematic file by its FID from the Manual form.
- Delete a batch of FIDs at once by pasting a newline-separated list into the Manual form.
- Remove files by FID from the command line during a deployment or cron script with `drush ffd`.
- Force-remove a stuck file from a scripted cleanup with `drush ffd <fid> --force`.
- Audit which managed files are orphaned by applying the "Orphan File Delete" filter in the LIST view.
- Purge leftover files after a bulk content migration that removed nodes but not their attachments.
- Clear test/fixture files uploaded during QA that are no longer attached to any entity.
- Delete files whose owning user was removed and whose references dangle.
- Remove duplicate uploads that accumulated in `sites/default/files` outside Drupal's knowledge.
- Restrict the unmanaged scan to specific directories (public/private and sub-directories) before deleting.
- Wipe unmanaged temp/export files a module wrote to the files directory but never registered.
- Delegate file cleanup to a non-admin role by granting only the unmanaged-files entity permissions.
- Trigger a full managed-file purge as part of a site decommissioning process.
- Free space before a database/file backup by dropping orphaned and unmanaged files first.
- Fix "file still referenced" errors during content deletion by force-deleting the blocking files.
- Batch-process very large file tables safely via the module's chunked batch operations.
- Regenerate the unmanaged-files listing on demand with the view's "Update View" button.
- Script periodic orphan cleanup by combining the orphan query logic with `drush ffd`.
