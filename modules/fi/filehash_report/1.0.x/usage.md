<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Filehash Report provides a list of duplicate files, using File Hash-computed hashes to detect duplicates.

---

Filehash Report provides a report of duplicate files — listing files that share the same content hash
(computed by the File Hash module), so administrators can find and clean up duplicate uploads and reclaim
storage. It depends on the Filehash module, is configured at `filehash.reportduplicates`, and provides its
own permissions, in the Utility package.

Use it to audit duplicate files. It is an administration/reporting feature reading file hashes; it is
informational (finding duplicates) and does not delete files or change access itself. Gate the report with
its permission (file listings can reveal what's uploaded). Configure/view the duplicates report.

---

- Report duplicate files.
- List files sharing a hash.
- Use File Hash hashes.
- Depend on the Filehash module.
- Find duplicate uploads.
- Reclaim storage.
- Provide its own permissions.
- Not delete files itself.
- Gate the report by permission.
- Configure at filehash.reportduplicates.
- Audit duplicate files.
- Read file hashes.
- Clean up duplicates.
- View the duplicates report.
- Detect duplicate content.
- Report on files.
- Find duplicates.
- List duplicate files.
- Handle file auditing.
- Report duplicates.
