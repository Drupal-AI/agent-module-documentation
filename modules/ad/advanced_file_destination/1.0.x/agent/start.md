<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced File Destination (advanced_file_destination) — agent index

Adds a "Destination folder" selector to file/image upload widgets and Media forms so editors choose or create the directory an upload lands in, overriding the field's fixed path. Core `^10 || ^11`. Depends on core `file`, `system`, `config`. Configure route: `advanced_file_destination.settings`.

## What it provides
- **Content entity** `afd_directory` (`AdvancedFileDestinationDirectory`) — a revisionable, owned, weighted directory record (fields: name, path, status, weight, roles, uid). Managed at `/admin/content/directories`. Storage `AFDDirectoryStorage`, access handler `Entity\Access\DirectoryAccessControlHandler`.
- **Field widget** `advanced_file_destination` (`Plugin/Field/FieldWidget/AdvancedFileDestinationWidget`, extends core `FileWidget`) for `file` and `image` fields.
- **Service** `advanced_file_destination.manager` (`Service\AdvancedFileDestinationManager`) — builds the directory list, normalizes paths, and stores/reads the per-user selection in `State`.
- **Controllers** `DirectoryModalController` (create-directory modal, AJAX), `DirectoryStateController` (AJAX `POST` to persist the selection), plus revision/list/state builders.
- **Forms** settings, directory add/edit/delete, bulk-confirm, and `NewDirectoryModalForm`.
- **Event subscriber / hooks** — `file_presave`/`entity_presave` move the saved file into the selected directory; widget/form alters inject the selector; `focal_point_file_paths_alter` re-points renditions.
- **Config** `advanced_file_destination.settings` (has schema): `enabled_entity_types`, `default_directory`, `use_private`, `scan_filesystem`, `widget_position`, `display_style`, plus include_* stream-wrapper toggles.
- **8 permissions** (all `restrict access: true`): administer / access / create directories / access private files / create / delete / enable / disable.

## Routes
- `advanced_file_destination.settings` → `/admin/config/media/advanced-file-destination` (settings form).
- `entity.afd_directory.*` → collection/add/edit/delete/revisions under `/admin/content/directories`.
- `advanced_file_destination.directory.modal` / `.media_modal` → AJAX create-directory modal.
- `advanced_file_destination.update_state` → AJAX `POST /advanced-file-destination/ajax/update-state`.
- `advanced_file_destination.bulk_confirm` → bulk action confirmation.

## Solution docs
- [Configuration & settings](config/settings.md) — settings object, keys, schema, install defaults.
- [Directory entity & admin UI](entities/afd_directory.md) — the `afd_directory` entity, routes, permissions, access.
- [Upload-destination flow & widget](api/upload-flow.md) — how the selector, manager service, path normalization and file-move work end to end.
