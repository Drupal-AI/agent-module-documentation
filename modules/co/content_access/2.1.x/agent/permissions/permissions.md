# Permissions

Defined in `content_access.permissions.yml`:

| Permission | Gates |
|---|---|
| `grant content access` | View and modify content access (the per-node **Access control** tab) for **any** node. |
| `grant own content access` | View and modify content access for the user's **own** nodes only. |

These gate the **per-node** tab (`/node/{node}/access`), checked by the
`_content_access_node_page_access` access check (`ContentAccessNodePageAccessCheck`), which also
invokes `hook_content_access_node_page()` so other modules can allow/deny.

The **content-type** Access control tab (`/admin/structure/types/manage/{type}/access`) is gated
differently — by the `_content_access_admin_settings_access` check
(`ContentAccessAdminSettingsAccessCheck`), which requires the core **`bypass node access`** and
**`administer content types`** permissions. The same pair gates the "Access control" entity
operation on the content types list.

## Operation permissions surfaced on the settings form

The module adds two brand-new operations: **view any** (`view`) and **view own** (`view_own`).
The edit/delete rows shown on the tab are the *core* per-type permissions
(`edit any {type} content`, `edit own {type} content`, `delete any {type} content`,
`delete own {type} content`) — displayed there for a complete overview; editing them on the tab is
equivalent to editing them at People → Permissions.

> Users still need core **`access content`** ("View published content") to view anything.
> **`bypass node access`** overrides everything. Unpublished content is not managed by this module.
