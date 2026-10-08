<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Patterns Media Source (ui_patterns_media_source) — agent index

**A "Media Browser" UI Patterns source type that selects media through the Media Library modal.**

- **Version:** 1.0.0-beta1 → dir 1.0.x
- **Core:** ^9.5 || ^10 || ^11
- **Dependencies:** ui_patterns, media_library, media, image
- **Configure:** `/admin/config/media/ui-patterns-media-source` (`administer site configuration`)
- **Routes:** `/ui-patterns-media-source/{media-library,selection-done,preview}` (`view media`)
- **Service:** `ui_patterns_media_source.opener` (`MediaLibraryBrowserOpener`, `media_library.opener` tag)
- **Security:** Media routes require `view media`; `MediaPreviewController` additionally filters each entity by `access('view')` for the current user before rendering. Settings gated by `administer site configuration`. No `_access: TRUE`, no anonymous mutation. No security findings.
