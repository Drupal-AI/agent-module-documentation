Media entity download adds a permanent `/media/{media}/download` route (and a matching field formatter, Views field, and Linkit substitutions) that streams a media entity's referenced file to the browser, forcing a "Save as…" download via `Content-Disposition: attachment`.

---

The module registers a single route, `media_entity_download.download` at `/media/{media}/download`, handled by `DownloadController::download()`. Given a media entity it reads the media source's configured `source_field`, loads the referenced `file` entity (optionally by a `?delta=N` query parameter for multi-value fields), verifies the file exists on a valid stream wrapper, and returns a `BinaryFileResponse`. By default the response sets `Content-Disposition: attachment` (a forced download); passing `?inline` in the query switches it to `inline` so the browser decides how to handle it. The route is protected by the `media.view` entity access check plus a dedicated `download media` permission, and the controller also invokes `hook_file_download` so other modules can add headers or deny access (a `-1` result raises access denied). A `media_entity_download_download_link` field formatter (extending core's `LinkFormatter`, applicable to `file`/`image` fields on media entities) renders each file as a download link pointing at that route, with a "Download behavior" setting that chooses between forcing "Save as…" (attachment) or "Browser default" (inline). A Views field (`media_download_link`) and two Linkit substitution plugins (`media_download` for forced download, `media_download_inline`) provide the same download URL in Views and rich-text link contexts. Because the URL is keyed by media ID rather than the physical file path, it stays permanent even when the underlying file is replaced. The module depends only on core `media`.

---

- Give visitors a permanent download URL for a media asset that survives file replacement.
- Force a file to download ("Save as…" dialog) instead of opening in the browser via `Content-Disposition: attachment`.
- Link to a media file by media ID without exposing or depending on the physical file path.
- Add a "Download link" formatter to a media type's file/image field in a view display.
- Configure the formatter to force "Save as…" or fall back to the browser's default handling.
- Offer an inline preview link (`?inline`) that lets the browser render the file instead of downloading it.
- Gate who may download media files with the dedicated `download media` permission.
- Restrict downloads to users who can also view the media entity (`media.view` access).
- Provide a download column/link in a Views listing of media via the `media_download_link` Views field.
- Insert a direct media download link into CKEditor/rich text using the Linkit `media_download` substitution.
- Insert an inline (browser-default) media link in rich text via the `media_download_inline` Linkit substitution.
- Download a specific file from a multi-value file field using the `?delta=N` query parameter.
- Let other modules add response headers or deny access to a download through `hook_file_download`.
- Serve downloads from private file schemes with correct (non-cacheable) headers.
- Provide document/PDF "Download" buttons on a media library or resource page.
- Distribute images as downloadable originals rather than rendered image styles.
- Build a press-kit or asset-library page where every asset has a stable download link.
- Return a proper 404 when a media item has no file referenced or the file is missing on disk.
- Keep marketing links to downloadable assets stable across file re-uploads.
- Expose downloadable attachments on content that references media entities.
- Add per-file MIME-type icon classes to download links via the formatter's generated markup.
- Deploy the formatter's disposition setting as configuration (config schema is provided).
