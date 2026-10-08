# Permissions

Defined in `flexslider.permissions.yml`. The module provides a single permission.

| Permission | Gates |
|---|---|
| `administer flexslider` | All optionset admin routes — list/add/edit/delete/enable/disable optionsets (`/admin/config/media/flexslider/...`) and the advanced settings form (`/admin/config/media/flexslider/advanced`). Also the `flexslider` config entity's `admin_permission`. |

This is a trusted/administrative permission (site builders). The field-formatter and
Views-style choices are configured on Manage Display / Views config, which are gated by
their own core permissions (`administer <entity> display`, `administer views`), not by this
permission.

```
drush role:perm:add site_builder 'administer flexslider'
```
