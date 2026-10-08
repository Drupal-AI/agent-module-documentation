# Permissions

Defined in `domain_access_logo.permissions.yml`.

| Permission | Title | Grants |
|---|---|---|
| `administer domains access logos` | Administer domain access logo | Access to the settings form at `/admin/config/domain/domain_access_logo` (route `domain_access_logo.settings`), i.e. upload/clear the per-domain logos. |

- This is the only requirement on the settings route — the module uses its own
  permission rather than `administer site configuration`, so per-domain logo
  management can be delegated without granting full site-config access.
- Grant via UI at `/admin/people/permissions`, or:

```bash
drush role:perm:add editor 'administer domains access logos'
```
