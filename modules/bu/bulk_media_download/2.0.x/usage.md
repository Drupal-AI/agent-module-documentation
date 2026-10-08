<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Bulk Media Download is intended to let an administrator download all media of selected bundles as a single ZIP archive, with a settings form to pick the media bundles and a button injected on the `/admin/content/media` page.

In the shipped 2.0.x code the actual download controller (`BulkDownloadController::downloadMedia()`) is a stub that calls a helper, `var_dump()`s and `die()`s — so the button route does not produce a working ZIP; the real zipping logic lives in the procedural `get_all_node_types()` in the `.module` file and shows signs of being development-leftover code (debug calls, commented blocks).
---
Enable with `drush en bulk_media_download` (depends on core `media`). Configure which media bundles are included at `/admin/config/bulk_media_download/settings` (route `bulk_media_download.settings`). The download endpoint is `/admin/config/bulk_media_download/button` (route `bulk_media_download.button`). Both routes require the core `administer site configuration` permission (admin only).

`get_all_node_types()` loads media of the configured bundles, resolves each bundle's file field, builds file URLs, and streams a ZIP via `ZipArchive` + `readfile()`. Because the controller stub short-circuits, treat this module as incomplete without a code fix.
---
- Bulk-download media files of selected bundles as a ZIP.
- Pick which media bundles are included via settings.
- Add a download button to the admin media list page.
- Export images, documents, video, and audio media files.
- Package multiple media files into one archive.
- Give admins a one-click media export.
- Archive a site's media for backup or migration.
- Restrict the download to site administrators.
- Resolve each media bundle's file field automatically.
- Stream large archives with ZipArchive + readfile.
- Collect remote_video oembed URLs alongside files.
- Avoid downloading media items individually.
- Prepare a media bundle for offline review.
- Hand off all documents to an external team at once.
- Configure inclusion by media type rather than node type.
- Extend or repair the stub controller to enable downloads.