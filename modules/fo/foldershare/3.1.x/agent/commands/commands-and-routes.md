<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commands (the `FolderShareCommand` plugin type), the dispatcher, and routes

## The command plugin type

FolderShare models every browser operation as a **command plugin**, not a route. Pieces:

- Annotation `src/Annotation/FolderShareCommand.php` — declares id/label/menu names, `category`,
  `weight`, and the constraint blocks `userConstraints`, `parentConstraints`, `selectionConstraints`,
  `destinationConstraints`, `specialHandling`.
- Manager `src/Plugin/FolderShareCommandManager.php` (service
  `foldershare.plugin.manager.foldersharecommand`) — discovers plugins in namespace
  `Plugin/FolderShareCommand` using the `FolderShareCommand` annotation.
- Base `src/Plugin/FolderShareCommand/FolderShareCommandBase.php` (~2000 lines) — configuration
  (`parentId`, `destinationId`, `selectionIds[]`, `uploadClass`, `locationName`), staged validation,
  and `abstract execute()`.

Shipped commands (`src/Plugin/FolderShareCommand/`): `ChangeOwner`, `Compress`, `Copy`/`CopyMoveBase`,
`Delete*` (`DeleteGeneral`, `DeleteOnRootList`, `DeleteAsAdmin`, `DeleteBase`), `Download`, `Duplicate`,
`Edit`, `Move*` (`MoveGeneral`, `MoveOnRootList`, `MoveAsAdmin`, `MoveBase`), `NewFolder`, `NewObject`,
`Open`, `Recycle*`, `ReleaseShare`, `Rename`, `Share`, `Uncompress`, `UploadFiles`. Which commands are
actually offered is capped by the `command_menu_allowed` setting (see config/settings.md).

## The command dispatcher route

```
entity.foldersharecommand.plugin
  path: /foldershare/command/{encoded}
  form: Form\CommandFormWrapper
  _permission: 'administer foldershare+share foldershare+share public foldershare+author foldershare+view foldershare'
```

`{encoded}` is a base64url-encoded JSON object (`Utilities\Base64Utilities`) carrying `pluginId`,
`configuration` (parentId, destinationId, selectionIds, uploadClass, locationName), return `url`,
`parentFormId`, `enableAjax`, `location`. `CommandFormWrapper::buildForm()` decodes it, instantiates
the plugin via the manager, and calls `validateParentConstraints()` + `validateSelectionConstraints()`
before building the command's own confirm/prompt form. Submit runs
`command->submitConfigurationForm()` → `execute()`, wrapped in AJAX dialog handling.

**Important:** the route `_permission` only requires *any* FolderShare permission. Real authorization
is done **inside the command's validation**, which re-checks per-entity `->access()`:

- `validateUserConstraints()` — user type / permission required by the command annotation.
- `validateParentConstraints()` — parent kind/ownership + `$parent->access(parentConstraints.access)`
  (or `getRootAccessSummary()` for a root list). Default access op `view`; upload uses `create`.
- `validateSelectionConstraints()` — selection size/kind/mime/extension/parentage/ownership, then for
  every selected item `$item->access(selectionConstraints.access, currentUser)` (default `view`;
  delete/rename/move use `update`/`delete`; share uses `share`). A stray selection id belonging to
  another user fails this check → `ValidationException`.
- `validateDestinationConstraints()` — destination kind/ownership + `$destination->access(
  destinationConstraints.access)` (default `update`).

So passing another user's file id in `selectionIds` does not grant access — the per-item
`->access()` gate (permission AND owner/grant) still applies. `validateCommandAllowed()` also enforces
the site's `command_menu_allowed` allow-list.

## Example command annotations

- **UploadFiles** (`foldersharecommand_upload_files`): `parentConstraints.kinds={rootlist,folder}`,
  `parentConstraints.access="create"`, selection `types={none}`, `specialHandling={upload}`.
- **Share** (`foldersharecommand_share`): `userConstraints={authenticated}`,
  `parentConstraints.kinds={rootlist}`, selection `types={one}`, `selectionConstraints.access="share"`
  → the access handler requires the current user to own the selected item's root.

## Page / entity routes (`foldershare.routing.yml`)

| Route | Path | Guard | Controller/Form |
|---|---|---|---|
| `entity.foldershare.rootitems` | `/foldershare` | `view foldershare` | `FolderShareViewController::viewHomeFolder` |
| `entity.foldershare.rootitems.shared` | `/foldershare/shared` | `view foldershare` | `viewSharedFolder` |
| `entity.foldershare.rootitems.public` | `/foldershare/public` | `view foldershare` | `viewPublicFolder` |
| `entity.foldershare.rootitems.all` | `/foldershare/all` | `administer foldershare` + logged in | `viewAllFolder` |
| `entity.foldershare.rootitems.trash` | `/foldershare/trash` | `view foldershare` | `viewTrashFolder` |
| `entity.foldershare.canonical` | `/foldershare/{foldershare}` | `_entity_access: foldershare.view` | `viewEntity` |
| `entity.foldershare.edit` | `/foldershare/{foldershare}/edit` | `_entity_access: foldershare.update` | `_entity_form: foldershare.edit` |
| `entity.foldersharecommand.plugin` | `/foldershare/command/{encoded}` | any FolderShare perm (see above) | `CommandFormWrapper` |
| `entity.foldershare.userautocomplete` | `/foldershare/userautocomplete` | `administer foldershare+share foldershare` | `UserAutocompleteController` |
| `entity.foldershare.file` | `/foldershare/file/{file}` | `administer/author/view foldershare` | `FileDownload::download` |
| `entity.foldershare.download` | `/foldershare/download/{encoded}` | `administer/author/view foldershare` | `FolderShareDownload::download` |
| `entity.foldershare.settings` | `/admin/structure/foldershare` | `administer site configuration` | `Form\AdminSettings` |
| `foldershare.reports.usage` | `/admin/reports/foldershare` | `administer foldershare` | `Form\AdminUsageReport` |
| `entity.foldershare.uninstall` | `/admin/modules/uninstall/entity/foldershare` | `administer modules` | `UninstallFolderShareConfirm` |

`{foldershare}` params use `type: foldershare` → `FolderShareParamConverter`, which loads by **UUID**.
Download routes and their access checks are detailed in api/download-upload.md.

The mutation commands are all reached through the AJAX dispatcher form (POST + Drupal form token); the
GET download route only *reads* after an `access('view')` check. Breadcrumbs come from the
`foldershare.breadcrumb` service; a better HTTP-exception logger and a scheduled-task subscriber round
out `foldershare.services.yml`.
