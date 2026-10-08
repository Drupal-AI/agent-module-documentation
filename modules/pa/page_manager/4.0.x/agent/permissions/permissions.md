# Permissions

`page_manager.permissions.yml` defines one permission:

| Permission | Gates |
|---|---|
| `administer pages` | Full access to create, edit, delete and reorder Page Manager pages and their variants (the Structure → Pages UI). Also the `admin_permission` on both the `page` and `page_variant` config entity types. |

This is a "restrict access" / administrative permission — grant only to trusted roles, since
managing pages can override core routes (e.g. `/node/{node}`).

Per-page *view* access is controlled separately by each page's `access_conditions` /
`access_logic` (evaluated by the `_page_access` check, `Entity\PageAccessCheck`), not by this
permission.
