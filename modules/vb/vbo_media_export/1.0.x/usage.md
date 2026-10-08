<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VBO Media Export adds export actions to Views Bulk Operations, enabling bulk download of media entities as a ZIP file.

---

VBO Media Export adds an export action to Views Bulk Operations (VBO) — letting administrators select
media entities in a View and bulk-download them as a single ZIP file, useful for exporting/backing up media
in bulk. It depends on core File and the Views Bulk Operations module, in the Views Bulk Operations package.

Use it to bulk-export media as a ZIP. It is a content/media bulk-operation feature. The security-relevant
point: bulk export bundles the underlying files, so it should respect access — ensure the action is available
only to users who may access those media/files (VBO actions run in the context of the View and the user's
permissions), so a user can't export media they shouldn't have. It has no access-control role of its own
beyond the VBO/View access. Add the export action to the media View.

---

- Bulk-download media as a ZIP.
- Add a VBO export action.
- Export selected media entities.
- Depend on core File and VBO.
- Back up media in bulk.
- Bundle files into a ZIP.
- Respect media/file access.
- Restrict to users who may access the media.
- Have no access-control role of its own.
- Add the action to a media View.
- Export media in bulk.
- Handle bulk media export.
- Download media archives.
- Configure the export.
- Export via VBO.
- Bulk-export files.
- Handle ZIP export.
- Add media export.
- Restrict the export.
- Export media.
