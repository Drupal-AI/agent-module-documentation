# Permissions

One permission, defined in `commerce_currency_resolver.permissions.yml`:

| Permission | Title | Gates |
|---|---|---|
| `administer commerce currency resolver settings` | Administer currency settings | The settings form (`/admin/commerce/config/commerce_currency_resolver/settings`), the country autocomplete route, and every submodule mapping form (language / geoip / smart_ip mapping pages all require this same permission). |

Grant it:

```bash
drush role:perm:add administrator 'administer commerce currency resolver settings'
```

There is no separate per-submodule permission — the mapping/config pages added by the
language, geoip and smart_ip submodules all reuse this one. The cookie submodule's front-end
currency-selector block is instead controlled by normal block visibility / access.
