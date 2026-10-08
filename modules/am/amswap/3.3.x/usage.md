<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Admin Menu Swap (amswap) replaces the toolbar's "Manage" administration menu with a different menu of your choosing on a per-role basis, so different roles see a tailored admin navigation.

---

The module lets you map user roles to menus: at `/admin/config/amswap` (route `amswap.amswap_config_form`, permission "administer amswap") you build one or more **role-menu pairs**, each pairing a role with the menu to show as the toolbar's administration tray, optionally with a set of "ignored roles" that suppress the pair. Pairs are stored in the single config object `amswap.amswapconfig` under `role_menu_pairs` (a sequence of `{role, menu, ignored_roles[]}`). At render time `hook_toolbar_alter()` swaps the administration tray's `#pre_render` to `Drupal\amswap\Render\Element\Amswap::preRender`, which walks the configured pairs, and for the current user's roles loads the paired menu's tree (respecting any ignored roles) instead of the default `admin`/`system.admin` menu. If a pair matches, the chosen menu's links are built with the standard toolbar manipulators; if no pair matches, the normal administration menu is shown. It integrates with `admin_toolbar` (menu depth) and `gin_toolbar` (active trail and link manipulators) when those are present, and forces its `toolbar_alter` to run last so it wins over other toolbar-altering modules. There is no field, entity, or Drush command — just the settings form, one config object, one permission, and the pre-render element.

---

- Show editors a stripped-down "Manage" menu containing only Content and Media, hiding site-building tools.
- Give a "Shop manager" role a Commerce-focused administration menu instead of the full admin menu.
- Present a custom curated admin menu to a client/site-owner role.
- Point the toolbar's administration tray at a hand-built menu you created under Structure > Menus.
- Swap the admin menu per role without writing a custom module or theme override.
- Combine role and "ignored roles" so a user with both Editor and Administrator keeps the full menu.
- Suppress a simplified menu for power users by listing "administrator" in a pair's ignored roles.
- Provide different admin navigation to Authors vs. Editors vs. Publishers.
- Reduce admin-menu clutter for non-technical roles to lower support requests.
- Map multiple roles to the same simplified menu via several role-menu pairs.
- Keep the default administration menu for roles that have no configured pair.
- Tailor the admin toolbar for a "content moderator" role during an editorial workflow rollout.
- Work alongside Admin Toolbar so the swapped menu still respects the configured menu depth.
- Work alongside Gin Toolbar so the swapped menu uses Gin's active trail and styling.
- Build a task-focused menu (e.g. "Daily tasks") and surface it only to the relevant role.
- Hide configuration and module pages from roles that should never see them in the toolbar.
- Give a translation team a menu limited to translation and content pages.
- Export the role-menu configuration (`amswap.amswapconfig`) for deployment across environments.
- Migrate an existing multi-role site to per-role admin menus through config only.
- Standardise admin navigation per role across a multisite via shared config.
- Show a support/helpdesk role a menu pointing at reports and user management only.
- Ensure amswap's toolbar changes take precedence over other toolbar-altering modules.
- Offer a simplified onboarding menu to newly created roles.
- Quickly A/B different admin menu structures per role by editing the pairs.
- Remove a role-menu pair to instantly restore the default admin menu for that role.
