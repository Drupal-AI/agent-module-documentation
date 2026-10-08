# Permissions

Defined in `drupalauth4ssp.permissions.yml`.

| Permission | Machine name | Flags | Grants |
|---|---|---|---|
| Administer DrupalAuth for SimpleSAMLphp configuration | `administer drupalauth4ssp configuration` | `restrict access: true` | Access to the settings form at `/admin/config/people/drupalauth4ssp` (route `drupalauth4ssp.settings`), i.e. editing `returnto_list` and `idp_logout_returnto`. |

This is the only permission the module defines, and it is the only requirement on the settings
route. The other route, `drupalauth4ssp.redirect` (`/drupalauth4ssp/redirect`), is not
permission-gated; it requires `_user_is_logged_in: 'TRUE'`.

Grant/revoke with drush:

```bash
ddev drush role:perm:add administrator 'administer drupalauth4ssp configuration'
ddev drush role:perm:remove authenticated 'administer drupalauth4ssp configuration'
```
