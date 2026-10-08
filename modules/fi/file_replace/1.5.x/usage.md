File Replace is a small admin utility that lets site administrators overwrite the contents of an existing managed file (`file_managed` entity) with a newly uploaded file **while keeping the original file URI, filename, and file entity ID intact** — so every existing link, embed, or reference keeps working and just points at the new content.

---

The module adds a "Replace" form for core `file` entities at `/admin/content/files/replace/{file}`, exposed via a `replace-form` entity link template, an automatic "Replace" entity operation, and a Views field ("Link to replace file"). On the form the admin sees the current file and a single upload widget that is constrained to the **same extension** (an upload validator) and hints the original MIME type via the `accept` attribute; on save it uses `file_system->copy(..., FileExists::Replace)` to overwrite the file in place, re-saves the file entity to recalculate size and change date, deletes the temporary upload, and invokes `hook_file_replace($file)`. The module's own `hook_file_replace` implementation flushes image-style derivatives for the URI when the file is an image and the `image` module is on, so cached thumbnails regenerate from the new content. Access is gated by the `replace files` permission plus a custom access check that additionally requires the file to be **permanent** (temporary files cannot be replaced). It has no settings form and no configuration entities — you wire the replace link into your file listings yourself. Its `file_replace_shell_exec` submodule hooks the same `hook_file_replace` to run a configurable shell command after each replacement. Depends only on core's `file` module.

---

- Update a PDF (price list, brochure, terms & conditions) that is linked from many pages, without changing any of the URLs.
- Swap out a logo or image so that everywhere it is embedded shows the new version, keeping the same file URI.
- Replace a corrupted or wrong upload with the correct file while preserving its file entity ID and references.
- Push a new version of a downloadable asset (spec sheet, manual, form) at a stable, bookmarkable URL.
- Correct a typo in a document without re-uploading, re-linking, and hunting down old links.
- Keep permanent, hardcoded links in custom templates or menus valid after a content update.
- Refresh image-style thumbnails automatically after replacing a source image (image cache flush on replace).
- Add a "Replace" operation button to the admin file listing at `/admin/content/files`.
- Add a "Link to replace file" column to a custom View of files (`file_managed` base table).
- Expose a manual replace link in a text field or template using the pattern `admin/content/files/replace/{{ fid }}`.
- Give a specific editor role the `replace files` permission so they can update assets but not manage other file settings.
- Enforce that replacements keep the same file extension as the original (built-in upload validator).
- Prevent replacing temporary/unmanaged files by only allowing permanent files to be replaced.
- Trigger custom post-replace logic (CDN purge, cache clear, notification) by implementing `hook_file_replace()`.
- Run a shell command (e.g. re-optimize, sync, invalidate a cache) after each replacement via the `file_replace_shell_exec` submodule.
- Maintain a stable media asset URL for third-party integrations that cannot be told about new URLs.
- Replace a font, CSS, or JS asset stored as a managed file while keeping its reference intact.
- Update a QR-code target document that has already been printed with a fixed URL.
- Version a legal or compliance document in place while preserving the download link and file ID.
- Let editors fix an accidentally-uploaded low-resolution image by replacing it with the high-resolution one.
- Recalculate a file's size and change date after swapping its contents (done automatically on save).
- Provide a governed, permission-controlled replacement workflow instead of deleting and re-uploading files.
- Keep OpenGraph/social share images fresh at the same URL by replacing the underlying image file.
