<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FolderShare (foldershare) — agent index

A private-cloud **file/folder manager with per-folder-tree sharing**. Adds one content entity type
`foldershare` that represents both files and folders in a single nested tree, an AJAX file browser at
`/foldershare`, a `FolderShareCommand` plugin type for operations (upload, rename, move, copy, delete,
share, download…), access-controlled download controllers, Views integration, a search plugin, a
scheduled-task queue, and Drush maintenance commands. Version **3.1.0-beta2** (dir `3.1.x`).
Package *San Diego Supercomputer Center (SDSC)*. Core `^10.3 || ^11`, PHP 8.2. GPL-2.0-or-later.

- **Entity, access-control handler, and the sharing/grant model** → [entity/access-model.md](entity/access-model.md)
- **Command plugin type, the command dispatcher, and all routes/permissions** → [commands/commands-and-routes.md](commands/commands-and-routes.md)
- **File storage, upload handling, and the download endpoints** → [api/download-upload.md](api/download-upload.md)
- **Admin settings, config object/schema, Drush commands** → [config/settings.md](config/settings.md)

## Dependencies

Core: `datetime, field, file, filter, image, link, media, options, system, text, user, views`.
Contrib: `jquery_ui_button ^2.1`, `jquery_ui_menu ^2.1` (composer). Optional integrations: `help`,
`comment`, `search`, `rest`, `search_api`, `search_api_autocomplete`, `realname`, `field_ui`,
`views_ui`. No submodules.

## What it provides (from source)

- **Entity** `foldershare` (`src/Entity/FolderShare.php`), base_table `foldershare`,
  `admin_permission = "administer foldershare"`, `field_ui_base_route = entity.foldershare.settings`,
  canonical `/foldershare/{foldershare}`. Files and folders share one entity; `kind` field
  distinguishes `file`/`folder` (also image/media/object). Access grants stored on the root item in
  `grantviewuids` / `grantauthoruids` fields.
- **Access handler** `FolderShareAccessControlHandler` — permissions AND per-root access grants.
- **Permissions** (`foldershare.permissions.yml`): `view foldershare`, `author foldershare`,
  `share foldershare`, `share public foldershare` (separate — public exposure), `administer foldershare`.
- **Plugin type** `FolderShareCommand` (annotation `src/Annotation/FolderShareCommand.php`,
  manager `src/Plugin/FolderShareCommandManager.php`, base `…/FolderShareCommandBase.php`), ~25 command
  plugins in `src/Plugin/FolderShareCommand/`.
- **Controllers/routes**: view (`FolderShareViewController`), per-File download
  (`Controller/FileDownload`), entity/ZIP download (`Controller/FolderShareDownload`), command wrapper
  form (`Form/CommandFormWrapper`), user autocomplete, admin settings, usage report, uninstall forms.
- **Services**: breadcrumb builder, command plugin manager, scheduled-task event subscriber, HTTP
  exception subscriber, user-folder-create subscriber, `paramconverter` (loads foldershare by **UUID**).
- **Config**: `foldershare.settings` (+ schema). **Drush**: `foldershare:fsck|deleteall|locks|tasks|version`.
- **Field API**: `FolderShareItem` field type, `FolderShareWidget`, several formatters
  (`src/Plugin/Field/…`). Views data via `FolderShareViewsData`. Search via `Plugin/Search/FolderShareSearch`.

## Get-right notes

- Root lists are addressed by negative pseudo-IDs: `USER_ROOT_LIST` (-100), `PUBLIC_ROOT_LIST` (-101),
  `ALL_ROOT_LIST` (-102, admin), `SHARED_ROOT_LIST` (-103), `TRASH_ROOT_LIST` (-104). Routes:
  `/foldershare`, `/foldershare/shared`, `/foldershare/public`, `/foldershare/all`, `/foldershare/trash`.
- Access = **module permission AND** (own the item **OR** granted view/author on its **root** item).
  Admins (`administer foldershare` or site admin) bypass grants. See entity/access-model.md.
- File storage scheme (public vs private) and extension restriction are **admin settings**; see
  config/settings.md and api/download-upload.md for how file URLs are access-checked.
