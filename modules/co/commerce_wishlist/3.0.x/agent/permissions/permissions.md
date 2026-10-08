# Permissions

## Declared in `commerce_wishlist.permissions.yml`

| Permission | Restricted | Gates |
|---|---|---|
| `access wishlist` | no | View the wishlist page (`/wishlist`, `/user/{user}/wishlist`). |
| `administer commerce_wishlist_type` | yes | Manage wishlist **types** and their fields. |

## Commerce-generated entity permissions

Because `commerce_wishlist` is a Commerce content entity, the standard Commerce entity
permission provider also generates permissions such as:

- `administer commerce_wishlist` — full admin over wishlists (gates the settings form and
  `/admin/commerce/config/wishlists`).
- `view own commerce_wishlist`, `update own commerce_wishlist`,
  `delete own commerce_wishlist` — owner-scoped operations (exact set depends on the
  entity/permission provider configuration).

`WishlistItemPermissionProvider` provides the analogous permissions for
`commerce_wishlist_item`.

Grant via role config or drush, e.g.:

```bash
drush role:perm:add authenticated 'access wishlist'
drush role:perm:add administrator 'administer commerce_wishlist'
drush role:perm:add administrator 'administer commerce_wishlist_type'
```
