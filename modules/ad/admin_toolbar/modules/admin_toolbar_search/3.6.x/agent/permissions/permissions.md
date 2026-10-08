# Permissions

Defined in `admin_toolbar_search.permissions.yml`.

| Permission | Gates |
|---|---|
| `use admin toolbar search` | Access to the search UI and the AJAX endpoint `/admin/admin-toolbar-search` (route `admin_toolbar.search`) that returns matching admin links. |

The settings form itself uses the core `administer site configuration` permission, not this one.
