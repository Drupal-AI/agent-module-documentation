<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Folder Management — agent index

A **Windows-Explorer-style folder file manager for media** (folder tree, move/rename, revisions). Provides
permissions. Version **1.0.0-rc4**. Core `^10.3||^11`.

Media — **properly access-controlled**: routes require `access media folder file explorer`; folder ops run a
**custom per-folder access check** (`MediaFolderFileAccessCheck`), granular permission set (keep `bypass`/
administer to trusted admins). No unauthenticated surface.
