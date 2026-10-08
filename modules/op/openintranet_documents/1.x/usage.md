Open Intranet Documents adds a folder-based document management area at `/documents`, with custom `oi_folder` and `oi_document` entities, uploads, external-source embeds, search, and a Bootstrap 5 browser UI.

---

Open Intranet Documents is part of the Open Intranet distribution. It provides two custom content entities — `oi_folder` (nestable folders) and `oi_document` (a titled, described, optionally file-backed document) — and a front-end browser at `/documents` for creating folders, uploading files, and navigating a hierarchy with breadcrumbs. Documents are handled through a pluggable "document source" plugin type: the shipped `local_file` source uploads a managed file, while `google_drive`, `dropbox`, `onedrive` and `box` sources let editors register an externally hosted document by its sharing URL and embed/preview it in an iframe. Each entity type has its own permission set and access control handler, revision support, add/edit/delete forms (both full-page and AJAX modal variants), and a full-text search page covering titles, descriptions and filenames. A settings form at `/admin/config/content/documents` controls which sources are enabled, the default source, and the maximum upload size. The module depends on core `file`, `user`, `views`, and the contrib `alpine_js` module, and is designed to run inside the Open Intranet distribution.

---

- Give an intranet a central, browsable document library at `/documents` instead of scattering files across nodes.
- Organize documents into nested folders (departments → teams → projects) using the `oi_folder` entity hierarchy.
- Upload office documents (PDF, DOC/DOCX, XLS/XLSX, PPT/PPTX, ODT/ODS/ODP, RTF, TXT) and images (JPG, PNG, GIF) up to a configurable size limit.
- Register a Google Drive document by its sharing link and preview it inline via the `google_drive` source plugin.
- Register a Dropbox file by its shared link and offer a forced-download link via the `dropbox` source plugin.
- Register OneDrive or Box documents by URL using the `onedrive` / `box` source plugins.
- Add folders and upload documents through AJAX modal dialogs without leaving the browser page.
- Create subfolders in place from within a parent folder's view.
- Attach a title and a longer description to every document for context and searchability.
- Search across document titles, descriptions and filenames (plus folder names/descriptions) at `/documents/search`.
- Show automatic file-type icons (PDF, Word, Excel, PowerPoint, image, archive) in browser and search listings.
- Preview PDFs and images directly on the document view page.
- Provide direct file downloads with proper attachment headers via `/documents/document/{id}/download`.
- Track document authorship and created/changed timestamps, with full revision history and revert.
- Restrict who can view, create, edit, delete or download documents and folders using the module's granular permissions.
- Grant a read-only role that can browse and download but not modify the library.
- Show breadcrumb navigation reflecting the folder path on every folder and document page.
- Display folder statistics (subfolder and document counts) in the browser grid.
- Surface which site content (nodes) references a given document on the document view page.
- Anonymize or delete a user's documents and folders automatically when the user account is cancelled or deleted.
- Theme the browser, document view and search pages by overriding the module's Twig templates and CSS classes.
- Extend the system with a custom document source plugin (e.g. a corporate DMS) by implementing `DocumentSourceInterface`.
- Configure which document sources appear to editors and which is the default at `/admin/config/content/documents`.
