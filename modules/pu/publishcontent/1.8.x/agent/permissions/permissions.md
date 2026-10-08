# Permissions

Managed at `/admin/people/permissions/module/publishcontent`. Access is granted if the
user satisfies **any** applicable permission below (evaluated by the `publishcontent.access`
service). Applies to **nodes** only.

## Global permissions (`publishcontent.permissions.yml`)

| Permission | Grants |
|---|---|
| `publish any content` | Publish any node, any type. |
| `unpublish any content` | Unpublish any node, any type. |
| `publish editable content` | Publish any node the user already has `update` (edit) access to. |
| `unpublish editable content` | Unpublish any node the user has `update` access to. |
| `access publish content settings` | Reach the settings form at `/admin/config/workflow/publishcontent`. |

## Per-content-type permissions (dynamic)

Generated for **every** node type by `PublishContentPermissions::permissions()`. For a
bundle machine name `@type` (e.g. `article`), six permissions exist:

| Permission pattern | Grants (for that bundle) |
|---|---|
| `publish any node type @type` | Publish any node of the bundle. |
| `unpublish any node type @type` | Unpublish any node of the bundle. |
| `publish own node type @type` | Publish nodes of the bundle the user authored (owner == current user). |
| `unpublish own node type @type` | Unpublish own nodes of the bundle. |
| `publish editable node type @type` | Publish nodes of the bundle the user has `update` access to. |
| `unpublish editable node type @type` | Unpublish nodes of the bundle the user has `update` access to. |

Example machine name for the article bundle: `publish own node type article`. New content
types automatically get their six permissions with no configuration.

"Own" checks node owner == current user; "editable" additionally requires core `update`
access on the node. Translations that don't exist are always forbidden.
