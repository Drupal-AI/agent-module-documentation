<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Folder Management provides a windows-style file explorer for media.

---

Media Folder Management provides a **Windows-Explorer-style folder file manager for media** — organizing
media items into a browsable folder tree (create/move/rename folders, drag files) with revisions. It provides
its own permissions, in the Media package.

Use it to give editors a folder-based media organizer. It is a media-management feature that is **properly
access-controlled**: its routes require the **`access media folder file explorer`** permission, and folder
operations additionally run a **custom per-folder access check** (`MediaFolderFileAccessCheck::accessFolder`),
backed by a granular permission set (administer folders / own folders, `bypass media folder files permissions`,
per-revision permissions). Grant these permissions deliberately (a folder manager touches media files across the
site), keeping `bypass` and administer permissions to trusted admins. It has no unauthenticated surface.
Configure the folders and permissions.

---

- Provide a folder-based media manager.
- Organize media into a folder tree.
- Create/move/rename folders + revisions.
- Provide its own permissions.
- Require 'access media folder file explorer'.
- Run a custom per-folder access check.
- Back it with a granular permission set.
- Keep bypass/administer perms to trusted admins.
- Grant folder permissions deliberately.
- Have no unauthenticated surface.
- Serve editors organizing media.
- Configure folders + permissions.
- Handle media folders.
- Organize media.
- Configure the manager.
- Manage folders.
- Handle the explorer.
- Browse media.
- Restrict the permissions.
- Provide media folder management.
