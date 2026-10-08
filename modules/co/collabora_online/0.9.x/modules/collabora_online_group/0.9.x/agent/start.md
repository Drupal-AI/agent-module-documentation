<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Collabora Online Group (collabora_online_group) — agent index

Optional submodule of **[collabora_online](../../../../agent/start.md)** that integrates its
document preview/edit access with the **Group** ecosystem, so Collabora view/edit rights can follow
group membership. Package `Collabora Online`. Core `^10 || ^11`. License MPL-2.0. Version
**0.9.0-beta13**.

## Dependencies

- `collabora_online:collabora_online` (parent).
- `groupmedia:groupmedia` (which itself depends on `group`). Compatible with Group Media **3.x and
  4.x**.
- `container_rebuild_required: true` in the `.info.yml` (ensures groupmedia optional config is
  present at install).

## What it provides (from source)

No routes, controllers, tokens or file I/O of its own — it only **decorates Group Media's relation
handlers** (`collabora_online_group.services.yml`):

- **`CollaboraPermissionProvider`** (`src/Plugin/Group/RelationHandler/CollaboraPermissionProvider`)
  — decorates `group.relation_handler.permission_provider.group_media`. Extends
  `GroupMediaPermissionProvider`; `buildPermissions()` adds group-scoped Collabora permissions
  (Preview published, Preview own unpublished, Edit any, Edit own) and `getPermission()` maps the
  Collabora operations (`preview in collabora`, `preview in collabora unpublished`,
  `edit in collabora`) to the concrete `{op} {scope} {pluginId} in collabora` permission names.
- **`CollaboraAccessControl`** (`src/Plugin/Group/RelationHandler/CollaboraAccessControl`) — wraps
  `group.relation_handler.access_control` (`AccessControl`). `entityAccess()` appends
  ` unpublished` to the `preview in collabora` operation when the entity is unpublished (so the
  own-unpublished permission is used), then delegates to the parent group access control.
- **`hook_install`** (`collabora_online_group.install`) — adds `collabora_preview` /
  `collabora_edit` fields (plugins `media_collabora_preview` / `media_collabora_edit`) to the
  `group_media` view and folds them into its operations dropbutton. No-op when syncing config or when
  Views / the `group_media` view is absent.

## Access model

The submodule does not weaken the parent's checks — the WOPI controllers still enforce the JWT +
proof + live `edit in collabora` re-check. It only supplies the group-scoped permission definitions
and the published/unpublished operation routing that Group's access framework consults when deciding
`media.preview in collabora` / `media.edit in collabora` for group content. See the parent module's
[api/wopi.md](../../../../agent/api/wopi.md) for the underlying access model.
