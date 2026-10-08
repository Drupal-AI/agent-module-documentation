<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure role-menu pairs

## Where

- Route: `amswap.amswap_config_form` → `/admin/config/amswap` (form
  `Drupal\amswap\Form\AmswapConfigForm`, a `ConfigFormBase`).
- Permission: `administer amswap`.
- Config object: `amswap.amswapconfig` (schema: `amswap.schema.yml`).

## The stored shape

`amswap.amswapconfig` has one key, `role_menu_pairs`, a **sequence** of mappings:

```yaml
role_menu_pairs:
  - role: editor            # user role machine name this pair applies to
    menu: main              # menu machine name to show as the admin (Manage) tray
    ignored_roles:          # optional: if the user ALSO has any of these roles, skip this pair
      - administrator
  - role: shop_manager
    menu: commerce-admin
```

- `role` — the role that triggers the swap (matched against `\Drupal::currentUser()->getRoles()`).
- `menu` — the menu whose tree replaces the administration tray for that role. Any menu
  entity id works (e.g. `admin`, `main`, or a custom menu you built under
  *Structure > Menus*).
- `ignored_roles` — optional list; if the current user has **any** of these roles the pair is
  skipped (lets you exempt e.g. `administrator` from a simplified menu).

Multiple pairs can match one user (each matching pair's menu tree is merged). If **no** pair
matches, amswap falls back to the default `admin` / `system.admin` menu.

## Via the UI

1. Go to `/admin/config/amswap` (Configuration > System > Admin Menu Swap).
2. In **Role-Menu Pair 1** choose the *Menu to display* and the *role* it applies to.
3. Optionally tick roles under *and when these roles are not assigned* (the ignored roles).
4. Use **Add another role-menu pair** for more mappings; **Remove N** deletes one.
5. **Save configuration.** Duplicate role+menu pairs are rejected by validation. A pair
   missing either a role or a menu is dropped with a warning.

## Via drush / config (scriptable)

```php
\Drupal::configFactory()->getEditable('amswap.amswapconfig')
  ->set('role_menu_pairs', [
    ['role' => 'editor', 'menu' => 'main', 'ignored_roles' => ['administrator']],
  ])
  ->save();
```

Read it back:

```bash
drush cget amswap.amswapconfig role_menu_pairs
```

To restore the default (no swaps), set `role_menu_pairs` to an empty array `{}` / `[]`.

## Notes

- The menu you point at must contain the links you want in the toolbar; amswap only changes
  *which* menu tree is rendered, it does not create menu links.
- Changes are cache-dependent: the administration tray is tagged
  `config:amswap.amswapconfig`, so saving the config invalidates it (run `drush cr` if testing
  by hand).
