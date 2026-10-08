# Permissions

Defined in `redirect.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer redirects` | Create, edit, delete and list individual redirects (the `/admin/config/search/redirect` UI, add/edit/delete routes). Also gates the Redirect Domain submodule's domain form. |
| `administer redirect settings` | The global settings form (`redirect.settings`) — default status code, auto_redirect, normalizer, etc. Trusted/administrative. |

Redirect entity access (view/update/delete) is checked against `administer redirects`.

```
drush role:perm:add site_manager 'administer redirects'
```

Submodule `redirect_404` adds `ignore 404 requests` (lets non-admins ignore specific logged
404s without editing the exclude patterns).
