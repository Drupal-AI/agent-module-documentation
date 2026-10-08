Document Library (dl) is a self-contained document-management system that stores files as a custom "document" content entity organized into a hierarchical, slug-addressed folder tree, with version history, favorites, download tracking, search, and a granular permission model.

---

The module defines a `document` content entity (base table `document`) whose file, description, version and tags are standard configurable fields managed through Field UI, plus base fields for title, owner, folder id, published status and a download counter. Documents live in folders held in the custom `dl_folders` table and are reachable both by numeric id (`/documents/{id}`) and by nested slug path (`/documents/finance/reports`). A front-end controller renders the library, folder, search, favorites and single-document pages; an admin section at `/admin/content/documents` lists everything (including unpublished) and exposes AJAX bulk publish/unpublish/delete. Every file download flows through `/documents/{id}/download`, which logs the user, IP and timestamp to `dl_downloads` and increments the entity's download count before streaming the file bound to the document. Version history is kept in `dl_versions` and favorites in `dl_favorites`. Global behavior (items per page, feature toggles for versioning/downloads-tracking/favorites/comments, theme, thumbnails) is stored in the `dl.settings` config object; file extension, size and storage-scheme limits are set on the entity's File field. Access is governed by twelve permissions with owner-based edit/delete plus "manage all" and "administer" overrides.

---

- Give editors a browsable document library at `/documents` instead of scattering files on nodes.
- Organize documents into nested folders (e.g. `Finance > Reports > 2025`) with clean slug URLs.
- Serve downloadable policy documents, forms, spreadsheets and presentations to authenticated users.
- Track how many times each document has been downloaded and by whom (user, IP, timestamp).
- Let contributors upload documents with title, description, version number and tags.
- Keep a full version history per document, preserving each uploaded file and its notes.
- Let users bookmark documents as favorites and revisit them at `/documents/favorites`.
- Provide keyword search across document title, description and tags at `/documents/search`.
- Restrict who can upload, download, edit, delete, and manage documents via distinct permissions.
- Allow authors to edit/delete only their own documents while giving admins a "manage all" override.
- Bulk publish, unpublish or delete many documents at once from the admin listing.
- Publish and unpublish documents to control visibility without deleting the underlying file.
- Build an internal knowledge base or DAM-style file repository inside an existing Drupal site.
- Expose a "Reports" or "Policies" folder linked from the main menu (a `Document Library` menu link is added).
- Manage the folder hierarchy (create, rename, move via drag-and-drop, delete) from `/admin/content/documents/folders`.
- Choose whether deleting a folder moves its contents to the parent or removes them.
- Constrain uploads to approved file types and a 50 MB ceiling by default, configurable per field.
- Store document files in public or private stream wrappers by switching the File field's URI scheme.
- Customize which fields (description, version, tags) appear and how they display via Field UI.
- Present per-file-type icons, statistics dashboards and a responsive card layout to end users.
- Integrate documents into Views (the entity ships `EntityViewsData`) for custom listings.
- Toggle site-wide features (versioning, download tracking, favorites) from the settings form.
- Provide a taxonomy-tag field on documents for lightweight categorization alongside folders.
