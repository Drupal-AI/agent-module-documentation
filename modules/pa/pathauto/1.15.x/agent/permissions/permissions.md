# Permissions

Defined in `pathauto.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer pathauto` | Full access: settings form, pattern add/edit/delete, and the bulk forms. Restricted (trusted) permission. |
| `notify of path changes` | Whether the user is shown a message when an alias is created/changed (works with the `verbose` setting). |
| `bulk update aliases` | Access the bulk **generate** form (combined with `administer pathauto`). |
| `bulk delete aliases` | Access the bulk **delete** form (combined with `administer pathauto`). |

Note the bulk routes require `administer pathauto+bulk update aliases` /
`+bulk delete aliases` (the `+` means either permission grants access, but in practice
`administer pathauto` already covers it).

Grant via drush (any role machine name, e.g. the standard-profile `content_editor`):
```
drush role:perm:add content_editor 'administer pathauto'
```
