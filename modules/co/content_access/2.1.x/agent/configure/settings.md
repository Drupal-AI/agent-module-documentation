# Configure access control

No central settings form — there is **no `configure` route**. Access is configured on two
per-entity tabs. Both require **`bypass node access` + `administer content types`** for the
content-type tab, or the grant permissions for the node tab (see permissions doc).

## Routes / tabs

| Route | Path | Tab | Form |
|---|---|---|---|
| `entity.node_type.content_access_form` | `/admin/structure/types/manage/{node_type}/access` | "Access control" on the content type | `ContentAccessAdminSettingsForm` |
| `entity.node.content_access` | `/node/{node}/access` | "Access control" on a node | `ContentAccessPageForm` |

The content-type tab also appears as an **entity operation** ("Access control") in the content
types list. The node tab only appears when *per-node* control is enabled for that type.

## Per-content-type defaults (the content-type Access control tab)

Tick which roles may perform each of six operations. The six operations
(`_content_access_get_operations()`):

- `view` / `view_own` — the two **new** permissions this module adds.
- `update` / `update_own` — map to core `edit any {type} content` / `edit own {type} content`.
- `delete` / `delete_own` — map to core `delete any {type} content` / `delete own {type} content`.

Edit/delete checkboxes mirror core node permissions (changing them here == changing them at
People → Permissions). Two extra options:

- **Per content node access control** (`per_node`, bool, default `false`) — when on, each node of
  this type gets its own Access control tab.
- **Priority** (`priority`, int, default `0`) — *Advanced*; raise it so this module's grants win
  when several node access modules run (core applies only highest-priority grants).

Storage: these are **third-party settings on the node type** config entity
(`node.type.{type}.third_party.content_access`), not a single config object. Defaults are not
stored (kept in sync with permissions). Read/write in code with `content_access_get_settings()` /
`content_access_set_settings()` (see api doc).

## Per-node overrides (the node Access control tab)

Enabled only when `per_node` is on for the type. Editors override the type defaults for one node;
values are stored in the module's **`content_access` database table** (`nid`, JSON `settings`),
not config. A **Reset to defaults** button clears the row so type defaults apply again. Saving
re-acquires grants and writes them via `node.grant_storage`.

## ACL (per-user) section

If the contributed **acl** module is enabled, the node tab adds a "User access control lists"
details section with a view/edit/delete user picker per operation, letting you grant access to
specific named users. Grants are saved through ACL's `acl_save_form()` / `acl_edit_form()`.

## Config object

`content_access.settings` holds one key: `content_access_roles_gids` — a role-machine-name → numeric
grant-id map (maintained automatically as roles are created/deleted). Schema:
`config/schema/content_access.schema.yml`.

## Applying changes

Changes require a **node access permissions rebuild** to fully take effect (the module links to
`/admin/reports/status/rebuild`). Node grants are written via
`content_access_node_access_records()` (realms `content_access_roles` for role grants,
`content_access_author` for author grants, plus core `all`), optimized so only grants that differ
from core permissions are stored. **Published content only** — unpublished nodes are governed by
core (author / `bypass node access`).
