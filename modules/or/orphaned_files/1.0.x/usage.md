<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Orphaned Files provides a list of orphaned files.

---

Orphaned Files provides a **list of orphaned managed files** — files in the system that are no longer
referenced by any entity — so admins can review and clean them up, reclaiming storage and reducing clutter. It
depends on core File, provides its own permissions, in the Other package.

Use it to find unreferenced files for cleanup. It is a file-management/administration feature. Security note:
the report lists file details (paths/names), which can be **sensitive** (private files, revealing content), so
gate its permission to trusted admins; and when deleting orphaned files, **verify** they are truly unreferenced
(some references — e.g. in text/config — may not be tracked) before removing. It has no access-control role
beyond its permission. Review the orphaned-files list.

---

- List orphaned managed files.
- Find unreferenced files.
- Support cleanup/storage reclaim.
- Depend on core File.
- Provide its own permissions.
- Reduce file clutter.
- KNOW the report can reveal sensitive file paths.
- Gate the permission to trusted admins.
- Verify files are truly unreferenced before deleting.
- Have no access-control role beyond permission.
- Review the orphaned-files list.
- Handle orphaned files.
- List orphans.
- Configure the report.
- Find orphans.
- Clean up files.
- Handle the list.
- Reclaim storage.
- Review files.
- Provide an orphaned-files list.
