# Permissions

Defined in `resave_all_nodes.permissions.yml`.

| Permission | Title | `restrict access` | Guards |
|---|---|---|---|
| `resave all nodes` | Use the Resave All Nodes form | `TRUE` | The form route `resave_all_nodes.form` (`_permission: 'resave all nodes'`) |

- This is the only permission the module defines, and it is the sole requirement on the
  trigger route — a user needs exactly this permission to open and submit the form. No other
  permission (e.g. node edit) is checked by the route.
- `restrict access: TRUE` flags it on the People ▸ Permissions page as security-sensitive, so
  it should be granted only to trusted/admin roles. It is not granted to any role by default.
- The Drush command has **no** permission check — it runs from the CLI under the site's shell
  user, like any Drush command. Restrict shell access accordingly.

## Grant via Drush

```bash
drush role:perm:add administrator 'resave all nodes'
```
