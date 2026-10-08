Accessible File Manager is an accessibility-first toolkit for browsing, inventorying, uploading, naming, protecting, and cleaning up Drupal-managed and physical files under the public:// and private:// file systems.

---

The module adds a permission-gated administration dashboard (under Content) that ties together five areas: a WAI-ARIA File Explorer that walks the physical public and private stream roots without letting operations escape those roots; an enhanced files inventory that reuses Drupal's core files View at runtime and enriches it with file type, folder, usage, permission, physical-status and download-count columns plus reference-based filters; a statistics/analytics dashboard covering disk quota, distribution and top downloads; configurable File Access Rules that restrict private-file downloads and render-time display by path, entity/field reference, role, user, owner and time window; and guarded lifecycle tools — token-based automatic filenaming templates, bulk renaming, and orphan file/media cleanup queued through cron with explicit confirmation. It also replaces the core file and image field widgets with accessible variants that keep Drupal's managed-file validation while adding screen-reader announcements, semantic multiple-file lists, keyboard reordering, predictable AJAX focus, and extended image descriptions (up to 2048 characters). A private-directory .htaccess security guard verifies and repairs the private root protection file on cron and on every module admin request.

---

- Give editors a keyboard- and screen-reader-friendly file browser for the public and private file systems, straight from the admin UI.
- Inspect physical files and folders whether or not they are registered as Drupal File entities.
- Download any explorer file, or a whole folder as a bounded ZIP archive (with configurable file, size and depth limits).
- Upload validated files directly into a chosen public directory from the explorer, with an accessible progress announcer.
- Enforce an allowlist of upload extensions and a per-file size limit for explorer uploads.
- Permanently delete unmanaged physical files and empty/unreferenced folders that have no File entity, behind a restricted permission and confirmation form.
- Enrich the core files listing with file type, file system, folder, usage details, effective permissions, physical-on-disk status and download counts as Views fields.
- Filter the files listing by referencing entity type/bundle, referencing field, public/private scheme, or orphan (unused) status.
- Track how many times each managed file is downloaded, with per-request deduplication and role/extension exclusion.
- Exclude specific roles (e.g. administrators, editors) or file extensions (e.g. images) from the download counter.
- Let privileged users opt out of the download counter for their own downloads.
- Restrict private-file downloads with rules matching a path glob, or a referencing entity type/bundle/field.
- Grant or deny file access by role, by user ID, or by file-owner policy, with optional start/end time or a duration measured from upload.
- Hide inaccessible file, image and media items from rendered entities without leaving empty field wrappers.
- Automatically rename uploaded files using token-aware templates (entity tokens, original name, timestamp) with transliteration, separators, lowercasing and length caps.
- Bulk-apply a filename template to existing managed files through a cron queue.
- Rename a single managed file from the core file operations dropdown, choosing the entity/field context that supplies tokens.
- Automatically delete orphaned files or media when their owning entity is deleted, opt-in per file/media field and processed safely in the cron queue.
- Queue orphaned (unused) files for deletion as a Views Bulk Operations action with an explicit acknowledgement checkbox.
- Monitor disk usage against a configurable hosting-package quota (GB) on the analytics dashboard.
- Automatically create and self-heal the private:// directory's .htaccess protection file on cron and on admin access.
- Keep the accessible widgets as the default for new file and image fields while preserving core storage and no-JavaScript fallback.
