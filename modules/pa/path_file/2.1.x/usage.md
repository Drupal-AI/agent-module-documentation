Path File adds a lightweight `path_file_entity` content entity that stores an uploaded file plus a stable URL alias, then streams that file from the alias — so a public download URL can stay constant even when the underlying file is replaced.

---

The module defines one content entity type, `path_file_entity`, with base fields for a name, a file reference (`fid`), an editable URL alias (`path`), and a publishing status. Editors create a Path File at `/admin/structure/path_file_entity/add`, upload a file, and set the alias (e.g. `/downloads/report`). The canonical route `/path-file/{path_file_entity}` runs `PathFileController::file()`, which loads the referenced file and returns it as a `BinaryFileResponse`; the entity's `path` alias points at that canonical route, so the human-facing alias always serves the current file. Because you can edit a Path File and swap in a new upload without changing the alias, links referenced from content, menus, or external sites keep working — solving Drupal's habit of renaming an uploaded file (`report_0.pdf`) instead of overwriting it. A single settings form (`/admin/structure/path_file_entity/settings`) controls the `allowed_extensions` config that drives the upload field's `file_extensions` setting. The module ships a full permission set and, at install, grants anonymous and authenticated users the "view published" permission so downloads work out of the box. There are no plugins, hooks, or Drush commands — it is a small custom content entity with an access control handler and a download controller.

---

- Publish a downloadable PDF at a memorable, permanent URL such as `/downloads/brochure`.
- Replace a document (new version of a price list) without breaking the URL already printed on marketing material.
- Give editors a way to overwrite a file in place instead of Drupal creating `file_0.pdf`, `file_1.pdf`.
- Serve a company logo or asset at a fixed path referenced from external systems.
- Maintain a canonical "latest terms & conditions" download link that always resolves to the current file.
- Let non-developers manage file downloads as content entities with add/edit/delete forms.
- Restrict which file extensions can be uploaded site-wide via the allowed-extensions setting.
- Control download visibility with publish/unpublish (unpublished files need the "view unpublished" permission).
- Expose a list of all managed downloads to administrators at `/admin/structure/path_file_entity`.
- Grant a "downloads editor" role only the add/edit permissions without full site admin.
- Keep a stable URL for a file linked from a printed QR code or email campaign.
- Provide a stable endpoint for a partner to poll for the newest data export file.
- Serve files through a controller so access is checked by entity permissions on each request.
- Build a simple document library where each document has its own editable slug.
- Alias `/press-kit` to whatever the current press-kit archive is.
- Swap a seasonal menu PDF each quarter while keeping `/menu` constant.
- Offer authenticated-only downloads by unpublishing and granting only trusted roles view access.
- Track who created each managed download via the entity owner field.
- Replace a broken/expired external file link with an internally managed, editable one.
- Use Views (the entity ships `views_data`) to build custom listings of Path File entities.
- Allow `pdf`, `doc`, `xls`, `odt`, and image extensions by default, tightened or widened per site.
- Reference a Path File alias from a menu link so the menu always points to the current file.
- Give a marketing team self-service control over a fixed set of download URLs.
- Provide a predictable download URL for automated tests or monitoring.
- Migrate legacy hard-coded file URLs onto managed, editable aliases.
