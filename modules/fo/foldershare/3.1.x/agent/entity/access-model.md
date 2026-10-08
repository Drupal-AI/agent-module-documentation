<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FolderShare entity & the access / sharing model

## The entity

`Drupal\foldershare\Entity\FolderShare` (`src/Entity/FolderShare.php`) is a single
`@ContentEntityType` (`id = foldershare`, base_table `foldershare`) that represents **both files and
folders** in one nested tree. Key annotation:

- `admin_permission = "administer foldershare"`, `permission_granularity = entity_type`,
  `fieldable = TRUE`, `render_cache = FALSE`, `list_cache_contexts = { user }`.
- `entity_keys`: id, uuid, uid (owner), label = **`name`**, langcode. Canonical link
  `/foldershare/{foldershare}`. `field_ui_base_route = entity.foldershare.settings`.
- Handlers: `access = FolderShareAccessControlHandler`, `view_builder`, `views_data =
  FolderShareViewsData`, forms `default`/`edit = Form\EditFolderShare`.

The huge entity API is split into traits under `src/Entity/FolderShareTraits/` — get/set for
name/description/owner/parent/root/kind/mime/size/file, and `Operation*Trait` files implementing
add-file, archive, change-owner, copy, delete, duplicate, move, new-folder, recycle, rename, share,
etc. Kinds: `FOLDER_KIND='folder'`, `FILE_KIND='file'` (plus image/media/object). A file/folder that
has no parent is a **root item**; **access grants live only on the root item** and cascade to the
whole tree.

Pseudo-IDs for the well-known root lists (negative, `FolderShareInterface`):
`USER_ROOT_LIST=-100`, `PUBLIC_ROOT_LIST=-101`, `ALL_ROOT_LIST=-102`, `SHARED_ROOT_LIST=-103`,
`TRASH_ROOT_LIST=-104`.

## Permissions (`foldershare.permissions.yml`)

| Permission | Grants | Notes |
|---|---|---|
| `view foldershare` | View + download own/granted content | Often given to anonymous |
| `author foldershare` | Create/upload/edit/delete own or author-granted content | Usually authenticated users; `restrict access` not set |
| `share foldershare` | Share a root item with other **users** (view/author grants) | Never available to anonymous |
| `share public foldershare` | Share with the **anonymous public** (view only) | Separate, trusted-authors permission |
| `administer foldershare` | Full access to **all** users' content, change ownership, change sharing | `restrict access: TRUE`; content-moderator role |

## The access control handler

`Drupal\foldershare\Entity\FolderShareAccessControlHandler` (extends core
`EntityAccessControlHandler`). Operations checked: `view`, `update`, `delete`, `create`, `share`,
`chown`. The rule for a non-admin is a boolean **AND**:

> user has the module permission for the operation **AND** (user owns the item **OR** the item's
> **root** item has granted that user the matching view/author access).

Flow (`access()` → `checkAccess()`):

1. **Admin short-circuit** — `AccessResult::allowedIfHasPermission($account, "administer foldershare")`
   (or the entity-type admin permission). Site admins and content admins get full access, grants
   ignored. Same short-circuit repeats in `checkCreateAccess()`, `mayAccess()`, `getAccessSummary()`,
   `getRootAccessSummary()`.
2. **System hidden/disabled** items are forbidden (with a recycle-folder exception so the trash tree
   stays reachable) — `isSystemHidden()` / `isSystemDisabled()`.
3. **Permission gate** per op: view→`view foldershare`; create/update/delete→`author foldershare`;
   share→`share foldershare` **or** `share public foldershare` (and never anonymous). `create` also
   requires the target be a folder.
4. **Grant gate** (non-owner): `$rootItem->isAccessGranted($userId, 'view'|'author')`. For `share`,
   instead requires the current user to **own the root item** (`$rootOwnerId === $userId`); non-admins
   can never `chown`.

`checkFieldAccess()` hides internal fields: `FIELDS_VIEW_NEVER = {langcode, uuid, systemhidden}`,
`FIELDS_EDIT_NEVER = {id, uid, uuid, created, changed, langcode, parentid, rootid, size, kind, mime,
file, image, media, grantauthoruids, grantviewuids, systemhidden, systemdisabled}`. So the
grant/owner/hierarchy fields cannot be edited through the normal form/field API.

Helper summaries used by the UI: `getAccessSummary($entity)` and `getRootAccessSummary($rootId)`
return an assoc array of `chown/create/delete/share/update/view => bool` for menu rendering;
`canView($rootId)` gates whether a root-list page may be shown (non-admins never see `ALL_ROOT_LIST`).

## The sharing / grant model

Grants are stored on the **root item** in two entity-reference fields, `grantviewuids` and
`grantauthoruids` (user IDs), managed by `src/Entity/FolderShareTraits/GetSetAccessGrantsTrait.php`:

- `isAccessGranted(int $uid, 'view'|'author')` — is this uid in the grant list? (author implies view.)
- `isSharedWith(int $uid, 'view'|'author')`, `isSharedBy(int $uid)` (owner has shared with anyone),
  `share()/unshare()` append/remove `target_id` entries.
- The **owner is always implicitly granted** full view+author on their own tree; grants only matter
  for *other* users. Granting the **anonymous** user (uid 0) publishes the tree to the public root
  list — this is what `share public foldershare` authorizes via the Share command/form.

Because grants are on the root and cascade, everything inside a shared top-level folder inherits the
same access — you cannot share a sub-folder independently of its root.

## Sharing is enforced everywhere via `->access()`

Every mutation path re-checks `->access($op)` on the specific target entity rather than trusting the
route permission:

- **Command dispatcher**: `FolderShareCommandBase::validateSelectionConstraints()` /
  `validateParentConstraints()` / `validateDestinationConstraints()` call `$item->access($op, …)` for
  each selection/parent/destination id, using the op named in the command's annotation
  (`selectionConstraints.access`, default `view`). See commands/commands-and-routes.md.
- **Downloads**: `FolderShareDownload` and `FileDownload` call `$entity->access('view')` /
  `$wrapper->access('view')` per file; the private-file `hook_file_download` re-checks too. See
  api/download-upload.md.

The entity route `/foldershare/{foldershare}` is guarded by `_entity_access: foldershare.view` and
the edit route by `foldershare.update`; the `FolderShareParamConverter` loads the entity by **UUID**
(not sequential id), so the canonical/edit URLs are not trivially enumerable.
