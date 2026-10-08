<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Optimizely — agent index

Loads Optimizely A/B-testing JS (`//cdn.optimizely.com/js/<code>.js`) onto selected paths,
managed as `optimizely` **project config entities**. Depends on core `path_alias`.

- **Account ID, project entities (code/state/paths), routes, permission, snippet mechanism** →
  [configure/projects.md](configure/projects.md)
- **Services: path checking, cache refresher, account-id helper** →
  [api/services.md](api/services.md)

Key facts:
- Global config `optimizely.settings` → `optimizely_id` (Optimizely **account ID**). Form route
  `optimizely.settings` at `/admin/config/system/optimizely/settings`.
- Project = config entity type **`optimizely`** (`optimizely.optimizely.<id>`) with fields
  `id`, `label`, `code` (int project code), `state` (bool enabled), `paths` (newline-separated
  path patterns; `*` = sitewide).
- Shipped **`default`** project (paths `*`) can't be deleted, only disabled.
- Snippet injected in `hook_page_attachments()` into `#attached['html_head']` when the current
  path (system path OR alias) matches an enabled project's paths.
- Entity list + add/edit/delete under `/admin/config/system/optimizely`; all routes require
  permission `administer optimizely`.
