# Permissions

Declared in `easy_breadcrumb.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer easy breadcrumb` | Access to the settings form at `/admin/config/user-interface/easy-breadcrumb` (route `easy_breadcrumb.general_settings_form`). |

That is the only permission. The breadcrumb itself renders for all users via the core
`system_breadcrumb_block`; this permission only controls who may change its configuration.
