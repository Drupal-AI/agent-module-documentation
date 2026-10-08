# Permissions

Defined in `simple_gse_search.permissions.yml`. Neither is granted to any role by default.

| Permission | Title | Gates |
|---|---|---|
| `administer gse search` | Administer config settings | Settings form `simple_gse_search.admin_settings` (`/admin/config/search/simple_gse_search`) |
| `access gse search page` | Access the search page | Results page `simple_gse_search.search_page` (`/search`) |

- Grant `access gse search page` to the roles that should reach `/search` — for a public site that
  usually means Anonymous + Authenticated. Without it, `/search` returns 403 and the search box
  (which redirects there) leads nowhere.
- `administer gse search` is the admin permission for setting the CSE id on the settings form.

Grant via drush:
```
drush role:perm:add anonymous 'access gse search page'
drush role:perm:add authenticated 'access gse search page'
```
