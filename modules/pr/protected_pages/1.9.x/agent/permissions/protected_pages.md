# Permissions

Defined in `protected_pages.permissions.yml`.

| Permission | Restricted | Gates |
|---|---|---|
| `bypass pages password protection` | yes | Holder is **never** prompted — the response subscriber returns early, so all protected pages are directly accessible. Give to trusted/admin roles. |
| `access protected page password screen` | no | Access to the `/protected-page` password prompt (`protected_pages_login_page`). Without it (and not being user 1) a visitor cannot reach the form to enter a password. |
| `administer protected pages configuration` | yes | The whole admin UI: list, add, edit, delete, send-email, and the settings form (all `admin/config/system/protected_pages/...` routes). |

Notes:
- The password screen's custom access also allows **user 1** regardless of the
  `access protected page password screen` permission, and requires a numeric `protected_page`
  query parameter.
- To let anonymous visitors actually unlock pages, grant `access protected page password screen`
  to the anonymous role; otherwise only authenticated users with the permission (or uid 1) can
  reach the prompt.

```
drush role:perm:add anonymous 'access protected page password screen'
drush role:perm:add editor 'bypass pages password protection'
```
