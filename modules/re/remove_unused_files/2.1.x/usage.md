<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Remove Unused Files finds managed files with zero recorded usage and moves them to temporary status so core deletes them on the next cron run.

---
Sites accumulate orphaned files — an image uploaded then removed from a node, a document replaced, a media item deleted — that stay in the files directory and `file_managed` table consuming space. Remove Unused Files identifies managed files whose `file_usage` count is zero and flags them for removal, moving them to temporary status so Drupal's normal temporary-file cleanup deletes them on a later cron run.

The soft-delete is a deliberate safety margin — files are not unlinked immediately but moved to temporary and removed on a subsequent cron, giving a window — and that is the right design. But the premise deserves a clear-eyed warning, because it is where data loss happens: **"zero file_usage" does not reliably mean "unused."** File-usage tracking in Drupal is only as complete as every module registering usage correctly, and many do not — a file embedded in body text via a WYSIWYG, referenced from configuration, used by a custom module that never called `FileUsage::add()`, or linked from another system, can show a usage count of zero while being very much in use. Deleting it breaks the content that referenced it, silently, and the reference discovers the loss later as a broken image or a 404.

So this is a powerful maintenance tool that must be used with verification, not trust: run it first in a reporting/dry-run mode if available, review what it proposes to remove against how the site actually uses files, ensure backups exist, and be especially cautious on sites using WYSIWYG file embeds or any module known not to register usage. Submodules add a form and a link interface for triggering it. The convenience is real; the risk is that file-usage tracking is an unreliable signal for "safe to delete."


---
- Reclaim space from orphaned files.
- Find files with zero usage.
- Clean up unmanaged uploads.
- Remove replaced files.
- Delete orphaned managed files.
- Move unused files to temporary.
- Free disk space.
- Schedule file cleanup on cron.
- Review before deleting.
- Back up before running.
- Verify usage tracking is complete.
- Beware WYSIWYG-embedded files.
- Beware config-referenced files.
- Understand usage=0 is unreliable.
- Run a dry run first.
- Restrict who triggers cleanup.
- Trigger cleanup from a form.
- Trigger cleanup from a link.
- Audit proposed deletions.
- Avoid deleting still-used files.
- Clean a bloated files table.
- Use the grace window before final deletion.