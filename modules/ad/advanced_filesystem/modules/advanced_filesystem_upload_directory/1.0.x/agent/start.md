<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Filesystem: Upload Directory (advanced_filesystem_upload_directory) — agent index

Submodule of **Advanced Filesystem**. Moves file/image field uploads to a configured destination
directory at entity save time; per-field rules + global fallback + Drupal-token paths + file browser.

## What it is
- Depends on `drupal:file`, `drupal:user`, `drupal:field`, `advanced_filesystem:advanced_filesystem`.
- Config object `advanced_filesystem_upload_directory.settings` (`enabled`, `global_directory`, `create_directories`, `field_rules` sequence).
- No custom DB tables.
- Permission: `administer advanced_filesystem_upload_directory` (`restrict access: true`).
- `configure` route: `advanced_filesystem_upload_directory.settings`.

## Routes (`advanced_filesystem_upload_directory.routing.yml`) — all admin-gated
- `.settings` `/admin/config/media/advanced_filesystem/upload-directory` — UploadDirectorySettingsForm.
- `.browser` `.../upload-directory/browse` and `.browser_scheme` `.../browse/{scheme}` (`scheme: [a-z0-9+\-]+`) — FileBrowserController::browse.

## Services & code
- `UploadDirectoryManager` (`advanced_filesystem_upload_directory.manager`) — `processEntityFiles()`, `getEffectiveDirectory()`, `resolveTokens()`, `moveFileToDirectory()`. Deps: config.factory, file_system, file.repository, logger, token.
- `advanced_filesystem_upload_directory.module` — `hook_entity_insert()` / `hook_entity_update()` → `_advanced_filesystem_upload_directory_process()` → `manager->processEntityFiles()` (skips non-content entities and `file` entities to avoid recursion).
- `Form\UploadDirectorySettingsForm` — cascading entity-type/bundle/field dropdowns, scheme+path directory picker, token preview, AJAX add/remove rules.
- `Controller\FileBrowserController` — lists files inside each configured directory; scheme filter tabs.

## Solution docs
- Rule resolution, token handling & file moves: [agent/api/manager.md](api/manager.md)
- Settings, rules, file browser & permission: [agent/config/settings.md](config/settings.md)
