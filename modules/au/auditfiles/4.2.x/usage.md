<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Audit Files provides seven admin reports that compare the files on disk, the `file_managed` and `file_usage` database tables, and file references in content, and lets you correct the mismatches (delete, add, or merge) with batch operations.

---

The module surfaces discrepancies between three views of a site's files: the physical files under the configured file-system scheme (e.g. `public://`), the managed-file and file-usage database tables, and the actual file-field references on entities. Its seven reports live under *Reports → Audit Files* (`/admin/reports/auditfiles`): **Not in database**, **Not on server**, **Managed not used**, **Used not managed**, **Used not referenced**, **Referenced not used**, and **Merge file references**. Each report lists offending records and offers fix actions (delete rows, add records, or merge duplicate `file_managed` entries) run through Drupal's Batch API. A settings form at *Configuration → System → Audit Files* (`/admin/config/system/auditfiles`, route `auditfiles.configuration`) tunes which scheme to scan, exclusions (files, extensions, paths, domains), items-per-page, maximum records, and date format — all stored in the `auditfiles.settings` config object. Deliberately, the fix operations manipulate the file tables directly (via dispatched events handled by `AuditFilesListener`) rather than through the File API, to avoid triggering the very problems being repaired. It defines two permissions (`access audit files reports`, `configure audit files reports`) and no Drush commands. Auditor logic is exposed as injectable services (one per report) so other code can reuse the comparisons.

---

- Find files uploaded via FTP that were never registered in `file_managed` ("Not in database").
- Detect database file records whose physical file is missing from the server ("Not on server").
- List managed files that no content uses, to review candidates for cleanup ("Managed not used").
- Find `file_usage` rows with no matching `file_managed` record ("Used not managed").
- Spot files marked as used but no longer referenced by any content field ("Used not referenced").
- Find file-field references on entities that lack a `file_usage` entry ("Referenced not used").
- Merge duplicate `file_managed` records that point at the same file name ("Merge file references").
- Delete orphaned physical files that are safe to remove, in a batch.
- Add stray on-disk files to `file_managed` so Drupal starts tracking them.
- Delete stale database file records that point at nonexistent files.
- Re-create missing `file_usage` entries for references discovered in content.
- Clean up after a module that failed to remove its files/records on uninstall.
- Reconcile files after a botched migration or partial content import.
- Reduce database bloat and disk usage by consolidating duplicate file references.
- Exclude system paths (css, js, ctools) or the `.htaccess` file from audits via settings.
- Restrict audits to a particular file-system scheme (public/private) before reconciling.
- Cap the number of records scanned to keep reports responsive on huge sites.
- Investigate why an image no longer displays by checking "Not on server".
- Verify a content model change did not orphan uploaded files.
- Prepare a site for a clean file backup by removing untracked cruft first.
- Audit file integrity as part of a periodic maintenance routine.
- Reuse the auditor services programmatically to build a custom file-integrity check.
- Subscribe to Audit Files events to run custom logic when files/usages are added or deleted.
- Gate the reports behind the `access audit files reports` permission for a maintenance role.
