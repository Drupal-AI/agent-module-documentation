<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VBO File Status provides the ability to change file status with Views Bulk Operations.

---

VBO File Status adds a **Views Bulk Operations (VBO) action to change file status** — bulk-setting file
entities between permanent and temporary from a view, useful for cleaning up or reclassifying managed files. It
depends on the Views Bulk Operations module, in the Views package.

Use it to bulk-change file statuses. It is an administration/developer tool run from a VBO view (already gated
by the view's access and VBO's action permissions); changing file status affects garbage collection (temporary
files are cleaned up), so use it deliberately. It has no access-control role of its own. Add the action to a VBO
file view.

---

- Bulk-change file status.
- Set files permanent/temporary.
- Run as a VBO action.
- Depend on Views Bulk Operations.
- Reclassify managed files.
- Clean up files.
- Run behind the view's access + VBO perms.
- Know temporary files get cleaned up.
- Have no access-control role of its own.
- Add the action to a VBO view.
- Handle file status.
- Change status.
- Configure the action.
- Handle the bulk op.
- Set file status.
- Configure VBO.
- Handle files.
- Bulk-set status.
- Use the action.
- Provide file-status VBO.
