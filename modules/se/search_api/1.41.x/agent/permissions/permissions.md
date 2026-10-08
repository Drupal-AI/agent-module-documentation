# Permissions

Defined in `search_api.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer search_api` | Create and configure Search API servers and indexes — the entire admin UI (`/admin/config/search/search-api`), fields, processors, tracker, and indexing operations. Restricted/trusted. |

Grant via drush:
```
drush role:perm:add content_admin 'administer search_api'
```
Front-end search access is controlled by the search page/View, not by this module's
permissions.
