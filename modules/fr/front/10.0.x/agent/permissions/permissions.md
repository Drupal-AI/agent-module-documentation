# Permissions

Defined in `front_page.permissions.yml`.

| Permission | Machine name | Restrict access | Grants |
|---|---|---|---|
| Administer front page | `administer front page` | yes | Access to all three admin routes: `front_page.admin_index` (`/admin/config/system/front`), `front_page.settings` (settings form), and `front_page.home_links` (HOME links form). |

This is the module's only permission; every route in `front_page.routing.yml` requires it. It is marked
`restrict access: true` because holders can change the site's front page and HOME link behavior for all
users. The runtime redirect logic itself is not permission-gated — it applies to whichever role a
visitor holds — but only holders of this permission can configure it.

### Grant with Drush

```bash
ddev drush role:perm:add editor 'administer front page'
```
