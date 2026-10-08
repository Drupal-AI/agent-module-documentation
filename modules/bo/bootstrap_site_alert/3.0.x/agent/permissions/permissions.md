# Permissions

Defined in `bootstrap_site_alert.permissions.yml`.

| Permission | What it grants |
|---|---|
| `administer bootstrap site alerts` | Reach and submit the config form (`bootstrap_site_alert.admin` route requirement), i.e. create, edit, and save every alert and the Bootstrap version. |
| `view bootstrap site alerts` | See rendered alerts. `bootstrap_site_alert_page_top()` skips an alert unless the current user holds this permission. |

## Install-time defaults

`hook_install()` (and the `bootstrap_site_alert_update_8101` update) grant `view bootstrap site alerts`
to both the **anonymous** and **authenticated** roles:

```php
user_role_grant_permissions(RoleInterface::ANONYMOUS_ID, ['view bootstrap site alerts']);
user_role_grant_permissions(RoleInterface::AUTHENTICATED_ID, ['view bootstrap site alerts']);
```

So out of the box everyone sees alerts. To make alerts authenticated-only, revoke
`view bootstrap site alerts` from the anonymous role. `administer bootstrap site alerts` is granted to
no role by default and must be assigned deliberately.
