# Permissions

`commerce_license.permissions.yml` defines one static permission:

| Permission | Gates |
|---|---|
| `administer commerce_license` | Full admin of licenses and license config: the `commerce_license` admin routes (`/admin/commerce/licenses`, license types, dashboard), and it is the entity's `admin_permission`. Flagged `restrict access: true`. |

## Per-bundle permissions

The entity also uses a **`permission_provider`** handler,
`\Drupal\commerce_license\LicensePermissionProvider` (Commerce/entity API), which generates
the usual granular per-bundle permissions for the `commerce_license` entity (e.g. view/update
own/any of a given License type) in addition to the blanket admin permission above.

Grant, e.g.:

```bash
drush role:perm:add commerce_administrator 'administer commerce_license'
```
