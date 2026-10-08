# Permissions

Defined in `commerce_vado.permissions.yml`.

| Permission | `restrict access` | Gates |
|---|---|---|
| `access vado administration pages` | — | The settings/field form route `commerce_vado.manage` (`/admin/commerce/config/vado`). |
| `administer commerce_vado_group` | **TRUE** (marked a security-sensitive/admin permission) | Full CRUD on `commerce_vado_group` and `commerce_vado_group_item` entities — it is the `admin_permission` in both entity annotations, so it governs their add/edit/delete/collection routes under `/admin/commerce/vado-groups`. |

Additional access facts (from code, not permission.yml):
- The **groups admin view** `commerce_vado_groups` (`/admin/commerce/vado-groups`) uses its own Views access:
  permission **`administer commerce_product`** (set in `config/install/views.view.commerce_vado_groups.yml`).
- `RouteSubscriber` adds a `_custom_access` check (`ProductVadoGroupAccessCheck::access`) to the optional
  per-product groups tab `view.commerce_vado_groups.page_1`; it only *reveals* the tab when the product has a
  variation referencing a group. The view's `administer commerce_product` permission still applies (requirements
  are ANDed).

Grant example:

```bash
drush role:perm:add commerce_store_admin 'access vado administration pages'
drush role:perm:add commerce_store_admin 'administer commerce_vado_group'
```
