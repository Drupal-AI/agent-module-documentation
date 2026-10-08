<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Admin Menu Swap (amswap) — agent index

Replaces the toolbar's **administration ("Manage") menu** with a chosen menu, per user role.
Depends on `toolbar` + `user`. One settings form, one config object, one permission, one
pre-render element. No plugins, no Drush, no fields.

- **Map roles to menus (the role-menu pairs), config keys, drush/config how-to** →
  [configure/role-menu-pairs.md](configure/role-menu-pairs.md)
- **How the swap actually happens (hook_toolbar_alter + preRender), integrations** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- `configure` route: `amswap.amswap_config_form` at `/admin/config/amswap`.
- Permission: `administer amswap`.
- Config object: `amswap.amswapconfig` → `role_menu_pairs`: a sequence of
  `{role: <role_id>, menu: <menu_id>, ignored_roles: [<role_id>, ...]}`.
- If no pair matches the current user's roles, the default `admin` menu is shown.
