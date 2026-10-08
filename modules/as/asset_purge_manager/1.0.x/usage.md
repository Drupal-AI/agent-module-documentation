<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Asset Purge Manager gives admins a paginated, selectable table of every writable file in the public files directory and deletes the ones they tick (blanking managed files instead of removing them).

---

Asset Purge Manager is a small administrative file-deletion tool. It recursively scans the site's default (public) file scheme, filters to files that are writable by the web process, and presents them in a paginated `tableselect` at `/admin/content/asset_purge_manager`. A user holding the delete permission selects files and submits; each selected file is removed from disk with the core `file_system` service. If a file is still referenced in Drupal's `file_managed` table, it is not left missing — the module deletes it and immediately re-creates a zero-byte placeholder in its place so managed-file references do not dangle. There is no heuristic that decides which files are "unused"; the operator makes that call, so the tool is destructive and should be limited to trusted roles. A separate config form controls only how many files appear per page.

---

- Manually clean up leftover files in `public://` from an admin screen instead of shell access.
- Delete stray uploads, exports, or generated files that accumulate in the public files directory.
- Remove obsolete image-style derivatives or temporary artifacts sitting on disk.
- Browse the full recursive contents of the public files tree in one paginated table.
- Blank (zero out) a managed file while keeping its `file_managed` reference intact, avoiding dangling-reference errors.
- Fully delete a file that is not tracked by Drupal's managed-file system.
- Tick multiple files and delete them in a single submit.
- See which listed files live under access-denied directories (shown without a clickable link).
- Click through to a public file's URL before deciding to delete it.
- Reclaim disk space taken by orphaned public assets.
- Tidy the public files directory after a content migration or import.
- Restrict who can even view the file list via the "access ... page" permission.
- Restrict who can actually delete via the separate delete permission.
- Configure the number of files shown per page to suit large directories.
- Provide a lightweight alternative to shell/FTP file removal for site builders.
- Audit what writable files exist under `public://` during a cleanup review.
- Give editors visibility into public files without granting delete rights (page access only).
- Keep the public files directory tidy on sites that frequently swap media assets.
- Remove test or placeholder files left behind during site building.
