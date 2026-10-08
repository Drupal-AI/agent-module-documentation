<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Files Handler makes sure all files get deleted on updates of a media entity, preventing orphaned files.

---

Media Files Handler ensures files are cleaned up on media updates — when a media entity is updated (e.g.
its source file replaced), it makes sure the previously-attached file(s) are deleted rather than left as
orphans, keeping file storage tidy and avoiding accumulation of unreferenced files. It depends on core File
and Media.

Use it to prevent orphaned files after media updates. It is a media/file-lifecycle feature (positive
housekeeping); deleting the old file on update is the intended behaviour, so be aware it removes the prior
file (ensure that's desired — if the same file is shared/referenced elsewhere, confirm the module's handling
matches expectations). It has no access-control role. Enable it to have media updates clean up old files.

---

- Delete orphaned files on media update.
- Clean up replaced media files.
- Prevent unreferenced file accumulation.
- Depend on core File and Media.
- Keep file storage tidy.
- Remove the prior file on update.
- Confirm shared-file handling.
- Ensure deletion is desired.
- Have no access-control role.
- Enable media file cleanup.
- Avoid orphaned files.
- Handle media file lifecycle.
- Clean up on updates.
- Delete old files.
- Manage media files.
- Prevent orphans.
- Handle file cleanup.
- Tidy file storage.
- Remove old media files.
- Clean media files.
