<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Gin Toolbar Custom Menu lets you replace the Gin admin toolbar's menu with a menu of your choice for specific user roles, so different roles see a different toolbar navigation.

---

The module extends the Gin Toolbar (from the Gin admin theme) by swapping the toolbar's `admin` menu for another menu on a per-role basis. On its settings page (`/admin/config/system/gin-toolbar-custom-menu`, permission `configure gin toolbar custom menu`) you build one or more "rules"; each rule picks a menu, a set of assigned roles, optional excluded roles, per-item toolbar icons, and an administration-menu visibility option. At render time (`hook_preprocess_navigation` / `hook_toolbar_alter` / `toolbar_menu_navigation_links`) the module checks the current user's roles against the rules and, when a rule matches, replaces the toolbar's admin menu items with the chosen menu's tree (applying toolbar icon classes). A global `keep_admin_menu` option controls whether the original administration menu is retained alongside the custom one. All state lives in the `gin_toolbar_custom_menu.settings` config object (a fully-validatable config with a `settings` sequence of rules). Assigned roles must also have the core "Use toolbar" (`access toolbar`) permission for the toolbar to appear. It requires the `toolbar` and `gin_toolbar` modules (and the Gin theme); it adds no plugins or Drush commands.

---

- Show a simplified custom menu in the Gin toolbar for editor roles instead of the full admin menu.
- Give different user roles different toolbar navigation menus.
- Replace the admin toolbar menu with a curated "content" menu for content editors.
- Present a role-specific set of shortcuts in the Gin toolbar.
- Hide the sprawling administration menu from non-developer roles.
- Keep the standard admin menu but add a custom menu for certain roles (keep_admin_menu).
- Exclude a role from a rule so it keeps the default toolbar even if it matches another role.
- Assign custom toolbar icons to individual menu items per rule.
- Build a client-facing toolbar menu that hides technical admin links.
- Route a "shop manager" role to a commerce-focused toolbar menu.
- Show a marketing team only the menus relevant to their tasks.
- Provide a role a menu built from a custom menu created in Structure > Menus.
- Control administration-menu visibility per rule (use global / hide / show).
- Combine multiple rules so several roles each get their own toolbar menu.
- Streamline onboarding by giving new-editor roles a minimal toolbar.
- Reduce clutter for authenticated users who only need a few admin links.
- Swap the toolbar menu for a translated/site-specific menu per role.
- Keep power users on the full admin menu while limiting others.
- Enforce a consistent navigation for a role across the site's admin toolbar.
- Configure the custom toolbar menus entirely through config for deployment.
