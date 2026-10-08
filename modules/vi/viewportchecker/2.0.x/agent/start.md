<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# jQuery-viewport-checker (viewportchecker) — agent index

jQuery-viewport-checker library integration for scroll-triggered classes. Version **2.0.1**.

- **Config**: `/admin/config/development/viewportchecker` (`SettingsForm`, perm
  `administer viewportchecker configuration`, restricted). Options: devel/uncompressed toggle, path
  list, include/exclude condition.
- **Attach**: `hook_page_attachments` adds `viewportchecker/viewportchecker[-min]` library, filtered by
  core `request_path` condition against configured paths.
- **Security**: admin-only config, no dynamic routes/controllers, no user-rendered input. Keep the
  uncompressed build off in production.
