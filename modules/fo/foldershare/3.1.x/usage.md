FolderShare turns a Drupal site into a private-cloud file manager where users create folders, upload files, organize a hierarchy, and share whole folder trees with chosen users, roles, or the public.

---

FolderShare adds a single `foldershare` content entity type that models both files and folders in one nested tree, plus a graphical browser (like Windows Explorer / macOS Finder) at `/foldershare`. Users with the right module permissions create root items, upload and organize files, and rename/move/copy/duplicate/delete/download them through an AJAX "command" menu. Sharing is set on a folder tree's top-level (root) item as per-user view/author access grants that cascade to everything inside; a separate permission gates sharing with the anonymous public. Files are stored in Drupal's public or private file system under a per-user directory tree, and every file access is routed through an access-checked download controller. The module ships its own permissions, routes, a `FolderShareCommand` plugin type, Views integration, breadcrumb builder, search plugin, scheduled-task queue for long operations, and Drush maintenance commands.

---

- Give authenticated users a personal "My Files" area at `/foldershare` for uploading and organizing documents.
- Build a departmental shared drive where teams share folder trees with view or edit (author) access.
- Publish downloadable assets (docs, software releases, press kits) to anonymous visitors via public sharing.
- Let users drag-and-drop files and whole folders into the browser to upload them in bulk.
- Organize uploads into a deep folder hierarchy that exists only in the database (files live under machine-managed paths).
- Rename, move, copy, and duplicate files and folders through a right-click / toolbar command menu.
- Download a single file, or ZIP-and-download a folder or a multi-item selection in one click.
- Recover deleted items from a per-user trash/recycle folder before permanent deletion.
- Compress selected items into a ZIP archive, or uncompress an uploaded archive, inside the browser.
- Add descriptions and comments to files and folders (optional core Comment integration).
- Search files and folders by name (and optionally file content) with the core Search or Search API modules.
- Restrict which filename extensions may be uploaded site-wide from the admin settings form.
- Cap the maximum upload size, independent of the PHP limit, from the admin settings.
- Choose whether uploaded files are stored in the public or private (recommended) file system.
- Limit which browser commands are available by editing the allowed-command list in configuration.
- Let administrators moderate everyone's content, change ownership, and fix problems via the "administer foldershare" permission.
- Provide a site-wide usage report at `/admin/reports/foldershare` showing per-user file counts and storage totals.
- Embed a folder browser inside other content using the FolderShare field type, widget, and formatters.
- Offer per-user home folders that are auto-created on first login.
- Queue long-running deletes, copies, and moves as scheduled tasks that finish after each page load or at cron.
- Run maintenance from the CLI: integrity check (`foldershare:fsck`), delete-all, inspect locks and pending tasks, and report version.
- Expose files and folders over REST for scripted/remote access when the companion FolderShare REST module is installed.
- Integrate with Views to build custom listings of files and folders.
