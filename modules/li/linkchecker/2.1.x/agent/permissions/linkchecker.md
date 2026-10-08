# Permissions

Defined in `linkchecker.permissions.yml`.

| Permission | Gates |
|---|---|
| `access broken links report` | View the global broken-links report (`/admin/reports/linkchecker`). |
| `access own broken links report` | View a broken-links report scoped to the user's own content. |
| `administer linkchecker` | The settings form (`/admin/config/content/linkchecker`) and administration of link data. `restrict access: true`; also the `linkcheckerlink` entity's `admin_permission`. |
| `edit linkchecker link settings` | Edit an individual broken-link's settings (the `LinkCheckerLinkForm`). |

`linkcheckerlink` entity access is handled by `LinkCheckerLinkAccessControlHandler`.

```
drush role:perm:add editor 'access broken links report'
```
