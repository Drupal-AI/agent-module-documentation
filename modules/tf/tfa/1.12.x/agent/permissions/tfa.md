# Permissions

Defined in `tfa.permissions.yml`.

| Permission | Gates | Restricted |
|---|---|---|
| `admin tfa settings` | The global settings form (`tfa.settings`, `/admin/config/people/tfa`) — enable TFA, choose plugins, encryption profile, required roles. | yes |
| `setup own tfa` | Setting up TFA on one's own account (`tfa.overview`, `tfa.validation.setup`). Grant to Authenticated user for a normal rollout. | no |
| `disable own tfa` | Disabling one's own configured TFA (`tfa.disable`). | no |
| `administer tfa for other users` | Editing/managing TFA for other accounts. | yes |

The account security routes use a `_tfa_permission` route option checked by
`TfaLoginController::accessSelfOrAdmin` — a user may act on their own account with the listed
permission, or on another account with `administer tfa for other users`.

Whether TFA is *required* for a user is driven by the `required_roles` setting (see
[configure/tfa.md](../configure/tfa.md)), not by a permission.

```
drush role:perm:add authenticated 'setup own tfa'
```
