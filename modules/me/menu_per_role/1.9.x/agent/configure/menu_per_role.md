<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — Menu Per Role

## Global settings

- Route: `menu_per_role.settings` (path `/admin/config/system/menu_per_role`), also linked
  under Configuration » System (`menu_per_role.links.menu.yml`). Requires permission
  `administer menu_per_role`.
- Config object: `menu_per_role.settings`. Form: `MenuPerRoleAdminSettings` (`ConfigFormBase`).

![Menu Per Role settings form](../../../../../../../screenshots/menu_per_role/1.9.x/settings-form.png)

### Keys, types, defaults (config/install)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `hide_show` | int | `0` | Which checkbox sets show on menu-link forms. `0`=both (`MODE_DISPLAY_BOTH`), `1`=only "Hide from" set (`MODE_DISPLAY_ONLY_HIDE`), `2`=only "Show to" set (`MODE_DISPLAY_ONLY_SHOW`). |
| `hide_on_content` | int | `2` | Whether role fields appear on links pointing to nodes. `0`=Always, `1`=only if NO node-access modules enabled, `2`=Never. |
| `admin_bypass_access_front` | bool | `false` | If true, admin users (UID 1 / `is_admin` role) skip Menu Per Role checks in the **front** context. |
| `admin_bypass_access_admin` | bool | `true` | If true, admin users skip checks in the **admin** context. |

Note default divergence: install config sets `hide_show: 0` and `hide_on_content: 2`
(Never show on content links). The code fallbacks when config is unset are
`MODE_DISPLAY_BOTH` (0) and `MODE_DISPLAY_ON_CONTENT_ALWAYS` (0) — see the `?? …` defaults in
`menu_per_role_form_menu_link_content_form_alter()`.

`hide_on_content` mode `1` ("If NO Node Access modules") hides the fields on node-pointing
links only when some module implements `hook_node_grants` (checked via
`\Drupal::moduleHandler()->hasImplementations('node_grants')`). Mode `2` hides them on all
node-pointing links. The alter only inspects existing (non-new) links whose route has a
`node` parameter; new links always show the fields.

Set via Drush:

```
drush config:set menu_per_role.settings hide_show 2 -y
drush config:set menu_per_role.settings admin_bypass_access_front 0 -y
```

## Per-link role fields (the actual restriction)

Editing/adding a menu link (in menu admin or a node's menu settings) shows one or two
fieldsets of role checkboxes, controlled by `hide_show`/`hide_on_content` above:

- **Roles able to see the menu link** → field `menu_per_role__show_role`
- **Roles not able see the menu link.** → field `menu_per_role__hide_role`

![Show/hide role fields on a menu link form](../../../../../../../screenshots/menu_per_role/1.9.x/menu-link-fields.png)

Rules (enforced in `MenuPerRoleLinkTreeManipulator::menuLinkCheckAccess()`):
- Leave both empty → the link keeps its default access (module adds no restriction).
- Any "show" role set → link is forbidden unless the account has at least one of those roles.
- Any "hide" role set → link is forbidden if the account has any of those roles.
- Applies only to `menu_link_content` entities (see api doc for programmatic use).
- Affects menu-link **visibility** only, not access to the link's target page.

`WARNING` from the UI: changing `hide_show` to hide a checkbox set does not clear existing
selections — hidden selections still apply but become invisible in the form.
