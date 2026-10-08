<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

`theme_switcher.permissions.yml` defines five permissions:

| Permission | `restrict access` | Gates |
|---|---|---|
| `administer theme switcher rules` | yes | Everything — the access handler short-circuits to *allowed* for any operation |
| `view theme switcher rules` | no | `view` operation; together with the admin permission it grants access to the list route |
| `create theme switcher rules` | yes | `entity.theme_switcher_rule.add_form` (`_permission` requirement on the route) |
| `edit theme switcher rules` | yes | `update` operation → edit form and the AJAX enable/disable route |
| `delete theme switcher rules` | yes | `delete` operation → delete form |

Route requirements:

- `theme_switcher.admin` → `_permission: 'administer theme switcher rules+view theme switcher rules'`
  (the `+` means **either** permission is enough).
- `entity.theme_switcher_rule.add_form` → `_permission: 'create theme switcher rules'`.
- edit / delete / inline enable-disable → `_entity_access: theme_switcher_rule.update` or
  `.delete`, resolved by the handler below.

## Access handler

`Drupal\theme_switcher\Access\ThemeSwitcherAccessControlHandler::checkAccess()`:

```
administer theme switcher rules  -> allowed (any operation)
view   + 'view theme switcher rules'   -> allowed
update + 'edit theme switcher rules'   -> allowed
delete + 'delete theme switcher rules' -> allowed
otherwise                              -> forbidden
```

Note the entity type also declares `admin_permission: "administer site configuration"`, which
core's `EntityAccessControlHandler` would honour — but this handler overrides `checkAccess()`
entirely, so **`administer site configuration` alone does not grant per-entity access**; it
still matters for config-entity operations that go through the generic handler (e.g. config
sync).

Grant a role the manage-everything permission:

```bash
drush role:perm:add editor 'administer theme switcher rules'
```

Read-only auditor role:

```bash
drush role:perm:add auditor 'view theme switcher rules'
```
