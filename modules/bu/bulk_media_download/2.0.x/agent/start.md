<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bulk Media Download (`bulk_media_download`) — agent index
**Intended bulk ZIP download of media by bundle; shipped code is largely non-functional/dev-leftover.**

- **Version:** 2.0.x  | **Core:** ^8 || ^9 || ^10
- **Depends on:** core `media`
- **Settings:** `/admin/config/bulk_media_download/settings` (`bulk_media_download.settings`)
- **Download:** `/admin/config/bulk_media_download/button` (`bulk_media_download.button`)
- Both routes gated by `administer site configuration` (admin only). No permissions.yml.
- Controller `BulkDownloadController::downloadMedia()` is a `var_dump()/die()` stub; zipping lives in procedural `get_all_node_types()` in `.module`.

**Security:** both routes are admin-only (`administer site configuration`); file URLs are built from admin-configured bundles, not request input, so no anon SSRF/path-traversal. The `file_get_contents($file)` in `get_all_node_types()` iterates admin-configured media URLs only. No verified finding; module is incomplete/buggy rather than vulnerable.
