<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File URL provides a `file_url` field type whose widget lets an editor either upload a local file or paste a URL to an external file, storing both cases as a URI and rendering a link to the file.

---

The module extends core's File field: the `file_url` field type subclasses `FileItem` but stores its reference in a `target_id` string column (varchar 2048) holding a URI instead of a numeric file ID. Its `file_url_generic` widget adds a "Upload file / Remote file URL" radio pair to the standard managed-file widget; on submit, uploaded files are converted to an internal dereference URL (`/file-dereference/{fid}`) while remote URLs are stored verbatim. A `RemoteFile` content entity (a `File` subclass backed by `ContentEntityNullStorage`, keyed by its URI) represents external files without a database row, so both local and remote references round-trip through the same field API. The static helper `FileUrlHandler` converts between files and URLs (`fileToUrl()`, `urlToFile()`, `isRemote()`), distinguishing local from remote by regex on the URI. The `file_url_default` formatter renders each item as a themed file link or a plain URL (its `mode` setting), and a `FileUrlRedirect` controller on the `file-dereference` route 302-redirects an internal file URL to the real file location so external systems can resolve it. A single `file_url.settings.dereference_host` config value optionally overrides the host used when building dereference URLs. There is no admin settings form (`configure: null`); everything is configured per field on Manage fields / form display / display.

---

- Let editors attach either an uploaded file or an external file URL in one field without choosing a field type up front.
- Reference PDFs, images, or documents that live on a remote CDN or third-party host by URL.
- Store a mix of locally hosted and externally hosted files in the same multi-value field.
- Expose a stable, dereferenceable link (`/file-dereference/{fid}`) that external/decoupled consumers can resolve to the real file.
- Serve dereference links from a canonical public host by setting `file_url.settings.dereference_host`.
- Display file references as a clickable file link (with name and extension) using the default formatter.
- Display file references as a plain URL string by switching the formatter `mode` to `plain`.
- Migrate legacy content that recorded files as absolute URLs into a first-class field.
- Track file usage for uploaded (local) files automatically via `{file_usage}`, while leaving remote URLs untracked.
- Rename the widget's "add new" label per field (`add_new_label`) on multi-value fields.
- Provide a documents field on an article where some files are uploaded and others are linked externally.
- Attach downloadable assets to a product/node where marketing hosts some files off-site.
- Build a media-library-free "external asset" reference for lightweight sites.
- Let content authors paste a Google/Dropbox/S3 file URL instead of re-uploading a file.
- Keep a single field type across bundles so displays and views stay consistent for local and remote files.
- Use the `file_url_default:file` entity-reference selection plugin to validate referenceable file URIs.
- Convert an uploaded file's ID to a public URL in code with `FileUrlHandler::fileToUrl($file)`.
- Resolve a stored file URL back to a `File`/`RemoteFile` object with `FileUrlHandler::urlToFile($url)`.
- Detect whether a stored reference is remote with `FileUrlHandler::isRemote($file)`.
- Present external files in a listing/view alongside uploaded files with one formatter.
- Provide an "attachment" field on a webform-adjacent content type that accepts links.
- Avoid duplicating remote assets locally while still referencing them from entities.
- Support decoupled front ends that need an absolute, redirect-backed file URL.
- Offer a fallback for editors who have a link but not the file itself.
