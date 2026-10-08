<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Download Files provides an action for the webform submission bulk form to download all attachments together in a zip file.

---

Webform Download Files provides a Views Bulk Operations (VBO) action for webform submissions — bundling
the file attachments of the **selected** submissions into a single ZIP for download, so admins can export
uploaded files in bulk. It depends on the Webform and Views Bulk Operations modules, in the Webform package.

Use it to bulk-download submission attachments. **Security caveat — access rests entirely on the VBO view's
access configuration.** The action zips files from the private submission-files directory
(`private://webform/{webform_id}/`) for the selected submission IDs, and its own `access()` method
**returns TRUE unconditionally** (its code comment: *"If the view can be accessed, there is no need for extra
access check."*) — so the action performs **no independent per-submission/per-file access check**; whoever
can reach the VBO view and select submissions can download those submissions' private uploaded files. Because
webform submission uploads are **private files (often sensitive)**, you must **restrict the VBO view to
trusted roles** (e.g. gated by an appropriate "access webform submissions"/administer permission) — a loosely
configured view would expose private submission files. The ZIP is scoped to the selected submissions (not the
whole folder). Configure the action on a properly access-restricted view.

---

- Bulk-download submission attachments as a ZIP.
- Provide a VBO action for webform submissions.
- Bundle selected submissions' files.
- Depend on Webform and VBO.
- Zip files from the private submission dir.
- KNOW the action's access() returns TRUE unconditionally.
- Understand it does NO independent per-file access check.
- Rely ENTIRELY on the VBO view's access config.
- Restrict the VBO view to trusted roles.
- Gate the view by an appropriate submissions permission.
- Know a loose view exposes private submission files.
- Note the ZIP is scoped to selected submissions.
- Configure the action on a restricted view.
- Handle bulk file download.
- Export submission files.
- Restrict access via the view.
- Download attachments.
- Handle the ZIP export.
- Secure the view.
- Export webform files.
