# Permissions

Defined in `sdc_component_library.permissions.yml`.

| Title | Machine name | Grants |
|---|---|---|
| Access SDC Component Library | `access sdc component library` | Access the component preview page (route `sdc_component_library.component_list`). Declared with `restrict access: true`. |

The preview route requires this permission (`_permission: 'access sdc component
library'`). The settings form route (`sdc_component_library.settings`) is gated
separately by the core `administer site configuration` permission.

## Grant via drush

    drush role:perm:add developer 'access sdc component library'
