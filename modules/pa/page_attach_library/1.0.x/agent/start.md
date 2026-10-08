<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Page Attach Library (page_attach_library) — agent index
**Attaches configured Drupal asset libraries (`module/library`) to pages whose path matches admin-defined patterns, via `hook_page_attachments`.**

**Version:** 1.0.x  ·  **Core:** ^8 || ^9 || ^10 || ^11  ·  **Configure:** `/admin/config/page-attach-library/page-attach-library-settings`
- **Route:** `page_attach_library.page_attach_library_settings_form` (`_permission: administer site configuration`, `_admin_route`).
- **Form:** `PageAttachLibrarySettingsForm` — draggable table of rules (status, pages, page_library) saved to config `page_attach_library.settings` (`page_library_table`).
- **Runtime:** `hook_page_attachments` matches the current path/alias with `path.matcher` and appends each listed library to `#attached['library']`.
- **Security:** admin-only (`administer site configuration`); no anonymous or mutating endpoints, no outbound HTTP, no secrets. Library IDs are attached verbatim (only real declared libraries load). No security findings.

See [configure/page_attach_library.md](configure/page_attach_library.md)
