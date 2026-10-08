# Permissions

Defined in `matomo_tagmanager.permissions.yml`:

| Permission | Machine name | Gates | Notes |
|---|---|---|---|
| Administer Matomo Tag Manager | `administer matomo tag manager` | The container collection and all add/edit/enable/disable/delete operations. | `restrict access: true` — trusted admins only. |

Grant at **People → Permissions** (`/admin/people/permissions`). This is the submodule's only
permission; it is separate from the parent module's `administer matomo`.
