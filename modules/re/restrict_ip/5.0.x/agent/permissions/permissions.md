# Restrict IP — permissions

## Static permission

- **`administer restricted ip addresses`** — grants access to the config page
  (`/admin/config/people/restrict_ip`) and to administer the module. Defined in
  `restrict_ip.permissions.yml`.

## Dynamic per-role bypass permission

`restrict_ip.permissions.yml` also declares a `permission_callbacks` entry
(`Drupal\restrict_ip\Access\RestrictIpPermissions::permissions`). When the config setting
`allow_role_bypass` is TRUE, this callback exposes a "bypass" permission that lets roles holding
it skip the IP check entirely. Grant it to trusted roles (e.g. editors working off-network) and
set `bypass_action` (`provide_link_login_page` or `redirect_login_page`) to control what an
anonymous, would-be-bypassing visitor sees. If `allow_role_bypass` is FALSE the bypass
permission is not offered.

Grant/inspect with drush:

```bash
drush role:perm:add editor 'administer restricted ip addresses'
drush php:eval 'print_r(array_keys(\Drupal::service("user.permissions")->getPermissions()));' | grep -i restrict
```
