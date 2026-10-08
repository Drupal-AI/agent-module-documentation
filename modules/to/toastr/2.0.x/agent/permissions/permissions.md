# Permissions

Defined in `toastr.permissions.yml`.

| Permission | Title | Grants |
|---|---|---|
| `administer toastr` | Configure toastr messages behaviour | Access to the settings page (route `toastr.settings`, `/admin/config/system/toastr`). |

This is the only permission the module defines, and it is the sole requirement on the
settings route. It is an administrative permission (restrict to trusted roles). Displaying
messages as toasts requires no permission — the JS is attached on every page for all users.

Grant via drush:

```bash
drush role:perm:add administrator 'administer toastr'
```
