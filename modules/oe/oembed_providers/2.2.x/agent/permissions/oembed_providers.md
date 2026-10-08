# Permissions

Defined in `oembed_providers.permissions.yml`. The module provides a single permission that gates
**all** of its functionality.

| Permission | Gates |
|---|---|
| `administer oembed providers` | The global settings form, and creating/editing/deleting custom providers and provider buckets. It is the `admin_permission` on both the `oembed_provider` and `oembed_provider_bucket` config entities, and the `_permission` requirement on every route in `oembed_providers.routing.yml`. Flagged `restrict access: true` (security-sensitive). |

```
drush role:perm:add site_manager 'administer oembed providers'
```

There is no separate permission for buckets vs. providers vs. settings — one permission covers
everything.
