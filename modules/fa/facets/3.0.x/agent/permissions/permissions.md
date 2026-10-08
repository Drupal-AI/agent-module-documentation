# Permissions

Defined in `facets.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer facets` | Create and configure facets: the collection, add/edit/delete/clone forms, settings form, and facet-source config at `/admin/config/search/facets`. Restricted (trusted) permission. |

Grant via drush (e.g. to a `site_admin` role):
```
drush role:perm:add site_admin 'administer facets'
```

Note: facet **blocks** themselves are shown to end users through normal block visibility /
Search API access — no separate view permission is required to see or use a facet.
