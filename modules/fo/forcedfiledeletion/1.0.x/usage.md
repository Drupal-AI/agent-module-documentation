<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Forced File Deletion forces a complete file deletion from managed files.

---

Forced File Deletion **forces a complete deletion of a managed file** — extending the File Delete module's
form to also physically `unlink()` the file from disk, so a file is removed even where a normal managed-file
delete would be blocked (e.g. by usage records). It provides its own permissions, in the Custom package.

Use it to fully remove a file, disk and record. It is a file-management admin operation, gated by the file-
delete access it extends and its own permission. Security/operational caution: it is **destructive and
irreversible** — it deletes the physical file bypassing usage checks, so anything still referencing the file
will break; gate the delete permission to **trusted admins**, and be sure before deleting (there is no undo). It
has no unauthenticated surface. Grant the permission carefully and use deliberately.

---

- Force complete file deletion.
- Physically unlink the file.
- Extend the File Delete form.
- Provide its own permissions.
- Delete despite usage records.
- Remove disk + record.
- BE destructive and irreversible.
- Gate the permission to trusted admins.
- Know references to the file will break.
- Have no unauthenticated surface.
- Use it deliberately (no undo).
- Handle forced deletion.
- Delete files.
- Configure the permission.
- Remove files.
- Handle the deletion.
- Unlink files.
- Force delete.
- Restrict the permission.
- Provide forced file deletion.
