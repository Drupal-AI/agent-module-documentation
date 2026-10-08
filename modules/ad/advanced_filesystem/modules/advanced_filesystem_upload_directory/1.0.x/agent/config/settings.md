<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, rules, file browser & permission

## Install / enable
`drush en advanced_filesystem_upload_directory` (pulls in `advanced_filesystem`, `file`, `user`,
`field`). Routing is active immediately; with no rules and no global directory, nothing is moved.

## Settings — `advanced_filesystem_upload_directory.settings`
Form `Form\UploadDirectorySettingsForm` at
`/admin/config/media/advanced_filesystem/upload-directory`
(`administer advanced_filesystem_upload_directory`). Config keys (schema in `config/schema`):
- `enabled` (bool, default `true`) — master switch for routing.
- `global_directory` (string, default `''`) — fallback stream-wrapper URI applied to fields without a matching rule; empty keeps the field's default location.
- `create_directories` (bool, default `true`) — auto-create the target directory on save.
- `field_rules` (sequence) — each: `entity_type`, `bundle`, `field_name`, `directory`, `enabled`.

The form composes each directory from a **Storage** scheme select (writable wrappers via
`StreamWrapperManager::getWrappers(WRITE_VISIBLE)`, so temporary:// and internal wrappers are
excluded) plus a **Subdirectory path** textfield, saving them as `scheme://path/`. Cascading
entity-type → bundle → field dropdowns (AJAX) restrict the field select to `file`/`image` fields of the
chosen bundle. `buildPreviewMarkup()` shows how a token path resolves for the current date/user.
Tokens like `[date:year]` or a content field are supported in the subdirectory path and resolved at
save time (ID tokens such as `[node:nid]` are unavailable for new entities).

## File browser
`Controller\FileBrowserController::browse(?string $scheme)`:
- Routes `.browser` (`.../browse`) and `.browser_scheme` (`.../browse/{scheme}`, `scheme: [a-z0-9+\-]+`), both `administer advanced_filesystem_upload_directory`.
- Collects the distinct configured directories (global + each rule), builds scheme filter tabs, and for each directory recursively lists files (`RecursiveDirectoryIterator`) with name, relative path, size, mtime and a generated URL. Directories that still contain tokens are shown with a "cannot browse until resolved" notice.

## Behaviour
File moving is driven from `hook_entity_insert()` / `hook_entity_update()` via
`UploadDirectoryManager::processEntityFiles()` (see api/manager.md). There are no custom tables and no
Drush commands.

## Permission
`administer advanced_filesystem_upload_directory` (`restrict access: true`) gates the settings and
browser routes. There is no anonymous, token-authenticated, or state-changing-GET route in this
submodule.
