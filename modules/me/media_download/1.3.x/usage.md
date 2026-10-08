<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Download turns a media entity's canonical page (`/media/{id}`) into a direct download of the media's source file instead of a rendered entity page.

---

The module replaces core's `entity.media.canonical` route with its own `/media/{media}` route handled by `Drupal\media_download\DownloadController::save()`. That controller finds the media's source field, locates the first referenced file that exists on disk, and returns it as a `CacheableBinaryFileResponse`. By default the file is served with a `Content-Disposition: inline` header (so browsers display it), but appending `?dl=1` to the URL switches to `attachment`, forcing a save-to-disk download. Because these canonical URLs only work when core Media's "standalone media URL" is enabled, the module ships a `config.factory.override` (`MediaSettingsOverride`) that forcibly sets `media.settings:standalone_url` to `TRUE` at runtime — so the feature works regardless of the stored value, and the media settings form shows a warning that the toggle has no effect while the module is installed. A page-cache response policy denies caching of binary/streamed responses, the response carries a `Content-Security-Policy: sandbox` header (to neutralise XSS via SVG), and the MIME type comes from the file entity. Access is still gated by `media.view` entity access. The module has no settings, permissions, plugins, schema or Drush commands of its own; it depends on core `file` and `media`.

---

- Serve a PDF, document or image media at `/media/{id}` so the URL points straight at the file.
- Give editors a clean, shareable download link for any uploaded media asset.
- Force a "Save as" download by linking to `/media/{id}?dl=1` (e.g. a "Download" button).
- Provide an inline-viewable link (`/media/{id}`) for PDFs and images that open in the browser.
- Replace the default media view page with a direct file response for a file-library site.
- Let a Views "media name" link resolve to the actual file download instead of an entity page.
- Distribute datasheets, brochures or manuals stored as document media via their canonical URL.
- Offer report downloads where each report is a media entity and the link is its `/media/{id}` path.
- Guarantee standalone media URLs are on without depending on the core setting being toggled.
- Prevent caching problems by ensuring binary media responses are never page-cached.
- Mitigate SVG-based XSS by serving media with a `Content-Security-Policy: sandbox` header.
- Respect `media.view` permissions so private/unpublished media still enforce access on download.
- Build a "download center" landing page linking to `/media/{id}?dl=1` for each asset.
- Let a decoupled front-end fetch the raw media file from a predictable `/media/{id}` URL.
- Serve audio/video media files for direct playback or download via the canonical path.
- Return the correct `Content-Type` (from the file entity) so browsers handle the file properly.
- Send `ETag`/`Last-Modified` headers automatically so clients can cache/download efficiently.
- Avoid writing a custom controller or route just to expose media files for download.
- Support multi-file media by serving the first valid, on-disk file in the source field.
- Migrate a site that used custom file-download links to standard `/media/{id}` media URLs.
