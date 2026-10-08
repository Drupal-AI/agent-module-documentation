<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Serves the current file when an old private-file URL (from a superseded media revision) is requested by redirecting to the latest file attached to the media entity.

---

When a file on a media entity is replaced, links stored in old content or bookmarks still point at the previous file URI, which 404s once the file is gone. This module swaps the controller on the core `system.private_file_download` and `system.files` routes for its own `PfarDownloadController::download` (via a `RouteSubscriber`). For each private-file request it loads the file entity by URI, finds the media entity that references it, loads that media's latest revision, and — if the latest revision points at a *different* file — issues a 302 redirect to the current file's private-download URL.

Access control is preserved: every code path that actually streams bytes falls back to `parent::download()` (core `FileDownloadController`), which invokes `hook_file_download` and enforces private-file permissions on whatever file is finally served. The module never returns file contents itself; it only decides whether to redirect. Note it is currently scoped to `media`-referenced files only (other entity types fall through to core unchanged) and requires the core `media` module.

Setup is zero-config: enable the module and the route controller override applies. It is most useful on sites where editors replace media source files in place and want old URLs to resolve to the replacement rather than break.

---

- Redirect an outdated private-file link to the current replacement file
- Keep bookmarked private-file URLs working after a media file is replaced
- Serve the latest revision's file for a media entity's private download
- Preserve email/newsletter links to files that were later updated
- Avoid 404s on private files removed from disk after replacement
- Transparently override the core private file download controller
- Fall back to standard core delivery for temporary files
- Fall back to core delivery when no media references the file
- Fall back to core delivery when the requested file is already the latest
- Enforce private-file access via core `hook_file_download` on the served file
- Support both `system.private_file_download` and `system.files` routes
- Point stale document downloads at the newest uploaded version
- Redirect superseded PDF/image private files to their replacement
- Deploy on media-centric sites where editors swap source files in place
- Reduce broken-link support tickets for updated private assets
- Run with no configuration UI or permissions to manage
- Combine with media revisions to always deliver the current file
- Leave non-media private files handled entirely by core
- Provide predictable redirect behaviour for private file streams
