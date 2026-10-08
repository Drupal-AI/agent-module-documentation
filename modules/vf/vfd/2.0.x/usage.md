<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views File Downloader maps a View (plus a file/media field) in its settings, then serves `/download-view/{path}`: it runs the mapped View, copies each row's file into a temp folder, zips it, and streams the archive as a download.

---

The download route requires the `access vfd` permission. The `{path}` argument is not a free file path — it must exactly match a View machine name recorded in `vfd.settings` (admin-configured), otherwise the controller returns a "no files" message, so there is no arbitrary path traversal. The archive is built from the View result (`views_get_view_result`); scope the permission and the mapped Views accordingly. The controller emits headers and `readfile()` directly and calls `exit()`, and `mkdir()` is not guarded against an existing directory (possible warning/collision under concurrency).

---

- Offer a one-click "download all files" link for a View.
- Bundle a node's attached documents into a single Zip.
- Let users grab every PDF listed in a document library View.
- Provide bulk media downloads from a gallery or resource page.
- Package file-field attachments across many rows at once.
- Map a specific View + field to a download endpoint.
- Support both File fields and Media (document) references.
- Gate downloads behind the `access vfd` permission.
- Add a downloads link to a publications or reports listing.
- Serve archives from the site's temp directory, cleaned up after send.
- Configure multiple View→field→type mappings in one settings table.
- Restrict `access vfd` to the roles that should download the mapped Views.
- Only expose Views whose rows are safe for the granted audience.
- Avoid mapping Views that surface private or restricted files.
- Review concurrency behaviour of the shared temp Downloads folder.
- Combine with a curated View to control exactly which files are offered.
- Keep the settings route behind `administer site configuration`.
