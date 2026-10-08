# Permissions

Defined in `editoria11y.permissions.yml`.

| Permission | Gates |
|---|---|
| `view editoria11y checker` | Loads the in-page checker and the report/dismiss endpoints. Give to all content editors. |
| `mark as hidden in editoria11y` | Adds a button to suppress a check for the current user only. |
| `mark as ok in editoria11y` | Adds a button to suppress a check for all users (requires sync enabled). |
| `manage editoria11y results` | Site-wide dashboard access + purge/reset dismissals. `restrict access` (trusted). |
| `administer editoria11y checker` | Change configuration and purge results. `restrict access` (trusted). |

Typical setup: editors get `view editoria11y checker` (+ `mark as hidden`); accessibility leads
also get `mark as ok in editoria11y` and `manage editoria11y results`; admins get
`administer editoria11y checker`.
```
drush role:perm:add editor 'view editoria11y checker'
```
