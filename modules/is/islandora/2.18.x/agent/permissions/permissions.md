# Islandora Core permissions

Defined in `islandora.permissions.yml` (only three). Most repository access is governed by core
node/media/taxonomy permissions plus the route access checks in [../api/services.md](../api/services.md).

| Permission | Gates |
|---|---|
| `view checksums` | Viewing file checksums (e.g. fixity/`filehash` values) in the UI. |
| `manage members` | Managing a node's member/child objects — the "Add child" / "Batch upload children" actions and the manage-members view. |
| `manage media` | Managing a node's media — the "Add media" / "Batch upload media" actions and the manage-media view. |

Notes:
- The batch wizards and add-* pages additionally require the relevant core entity-create access
  (`_entity_create_any_access` for node/media) — `manage members`/`manage media` control the tabs/links,
  core permissions control the actual create.
- The REST media-source routes are gated by `update media` / node `update` + `create media` / media
  `update`, **not** by these three permissions.
- Deleting a node together with its media/files requires `administer media` + `delete any media`.
