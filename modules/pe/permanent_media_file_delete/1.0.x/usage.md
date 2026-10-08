<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Permanent Media File Delete provides additional media file deletion.

---

Permanent Media File Delete **permanently deletes the underlying file when a media item's file is replaced
or removed** — extending the Media File Delete module so that when a media entity's file field changes, the old
file is deleted from storage (not left orphaned). It depends on core File and Media File Delete.

Use it to avoid orphaned files after media edits. It is a media/file-management feature tied to media edit
operations (so it runs under whoever can edit the media). Security/operational caution: it **permanently
deletes** the old file — this relies on Media File Delete's usage checks, but be aware that if a file is shared/
referenced elsewhere, deleting it can break those references; it is irreversible. It has no access-control role.
Enable it to auto-clean replaced media files.

---

- Delete the old file on media replace.
- Avoid orphaned files.
- Extend Media File Delete.
- Depend on core File and Media File Delete.
- Run on media edit operations.
- Clean up storage.
- PERMANENTLY delete the old file (irreversible).
- Rely on Media File Delete's usage checks.
- Beware breaking shared/referenced files.
- Have no access-control role.
- Enable it to auto-clean.
- Handle media file deletion.
- Delete old files.
- Configure nothing (behavior).
- Clean media files.
- Handle the deletion.
- Remove old files.
- Auto-clean files.
- Use deliberately.
- Provide permanent media file deletion.
