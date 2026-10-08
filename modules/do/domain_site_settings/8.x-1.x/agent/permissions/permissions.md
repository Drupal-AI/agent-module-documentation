# Permissions

Defined in `domain_site_settings.permissions.yml`.

| Permission | Title | Grants |
|---|---|---|
| `domain site settings` | Domain site settings | Access to both module routes: the domains list (`domain_site_settings.list`) and every per-domain edit form (`domain_site_settings.config_form`). |

This is the module's only access control. It is a single flat permission — it is not marked
`restrict access` and there is no per-domain scoping, so any role granted it can view and edit the
site settings of **all** domains, not just a subset.

Grant via drush:

```bash
drush role:perm:add editor 'domain site settings'
```
