# Configure — Menu Per Role

## Global settings

- Route: `menu_per_role.settings` (path `/admin/config/system/menu_per_role`), also linked
  under Configuration » System. Requires permission `administer menu_per_role`.
- Config object: `menu_per_role.settings`. Form: `MenuPerRoleAdminSettings` (`ConfigFormBase`).

### Keys, types, defaults (config/install)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `hide_show` | int | `0` | Which checkbox sets show on menu-link forms. `0`=both, `1`=only "Hide from" set, `2`=only "Show to" set. |
| `hide_on_content` | int | `2` | Whether role fields appear on links pointing to nodes. `0`=Always, `1`=only if NO node-access modules enabled, `2`=Never. |
| `admin_bypass_access_front` | bool | `false` | If true, admin users (UID 1 / admin role) bypass Menu Per Role checks in the **front** context. |
| `admin_bypass_access_admin` | bool | `true` | If true, admin users bypass checks in the **admin** context. |

Note default divergence: install config sets `hide_show: 0` and `hide_on_content: 2`
(Never show on content links). The code fallbacks when config is unset are
`MODE_DISPLAY_BOTH` (0) and `MODE_DISPLAY_ON_CONTENT_ALWAYS` (0).

`hide_on_content` mode `1` ("If NO Node Access modules") hides the fields on node links
only when some module implements `hook_node_grants`.

Set via Drush:

```
drush config:set menu_per_role.settings hide_show 2 -y
drush config:set menu_per_role.settings admin_bypass_access_front 0 -y
```

## Per-link role fields (the actual restriction)

Editing a menu link (in menu admin or a node's menu settings) shows one or two fieldsets of
role checkboxes, controlled by `hide_show`/`hide_on_content` above:

- **Roles able to see the menu link** → field `menu_per_role__show_role`
- **Roles not able to see the menu link** → field `menu_per_role__hide_role`

Rules:
- Leave both empty → the link keeps its default access (module adds no restriction).
- Any "show" role set → link is forbidden unless the account has at least one of those roles.
- Any "hide" role set → link is forbidden if the account has any of those roles.
- Applies only to `menu_link_content` entities (see api doc for programmatic use).

`WARNING` from the UI: changing `hide_show` to hide a checkbox set does not clear existing
selections — hidden selections still apply but become invisible in the form.
