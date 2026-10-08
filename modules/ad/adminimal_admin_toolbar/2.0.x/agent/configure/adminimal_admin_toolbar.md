# Configure

There is essentially no setup: enabling the module applies the styling. It depends on the
contrib `admin_toolbar` module (declared as `admin_toolbar:admin_toolbar` in info.yml), which
itself depends on core `toolbar`.

```
composer require drupal/adminimal_admin_toolbar
drush en adminimal_admin_toolbar -y   # also enables admin_toolbar + core toolbar
```

## The single setting

Config object `adminimal_admin_toolbar.settings` (schema
`config/schema/adminimal_admin_toolbar.schema.yml`). UI at
**Admin → Configuration → User interface → Adminimal Admin Toolbar**
(`/admin/config/user-interface/adminimal_admin_toolbar`, route
`adminimal_admin_toolbar.settings`, form `SettingsForm`, permission
`administer site configuration`).

| Key | Type | Default | Meaning |
|---|---|---|---|
| `avoid_custom_font` | bool | `FALSE` | When TRUE, the `google-fonts` library (Open Sans from Google) is **not** attached. Use for languages Open Sans supports poorly (e.g. Japanese). |

Set it via drush:

```
drush config:set adminimal_admin_toolbar.settings avoid_custom_font true -y
```

The key was introduced by the `adminimal_admin_toolbar_post_update_avoid_custom_font()`
post-update, which seeds it to `FALSE` on existing sites.

## Notes

- No permissions are defined by the module. Whether the styling loads for a given user is
  gated by the core `access toolbar` permission (checked in the module's hooks); the settings
  form is gated by the core `administer site configuration` permission.
- The module defines no plugins, services, or Drush commands.
