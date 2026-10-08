<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds an administrative form to trigger the parent module's unused-file cleanup on demand.

---

Adds an administrative form to trigger the parent module's unused-file cleanup on demand. A submodule of **remove_unused_files** — it provides a way to trigger the parent's file-cleanup, governed by the parent's behavior and the same data-loss caveat.

---

- Trigger unused-file cleanup.
- Provide a UI to run cleanup.
- Review files before removal.
- Verify usage before deleting.
- Back up before running.
- Free disk space.
- Clean orphaned files.
- Restrict who triggers it.
- Use the soft-delete window.
- Beware WYSIWYG embeds.
- Beware config-referenced files.
- Dry-run first.
- Audit proposed deletions.
- Run cleanup deliberately.
- Reclaim storage.
- Understand usage=0 is unreliable.