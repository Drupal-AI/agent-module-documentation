<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Custom Admin Menu lets a site build its own menu and show it in the Admin Toolbar, either merged into the default admin menu (prepended or appended) or as a separate toolbar item that replaces the default admin tree entirely. Per-role and per-language visibility can hide individual custom items.

---

Admin Toolbar renders Drupal's `admin` menu as toolbar drop-downs, but that tree is organized for developers, not editors. Custom Admin Menu adds a hand-built alternative: you create an ordinary menu whose machine name is exactly `custom-admin-menu`, add links to it, and the module injects those links into the toolbar. On the settings form (`/admin/config/system/custom-admin-menu`) you enable the feature and choose an insertion mode. With "Insert custom items in admin toolbar" checked, the custom links are merged into the existing default admin menu — prepended or appended — and you may optionally wrap the whole default admin tree under a single collapsed "Admin" root so the custom links take priority. With that box unchecked, the default admin menu is removed from the toolbar for non-privileged users and the custom menu appears as its own root-level toolbar item instead. Two permissions, `access_custom_menu` and `access_default_menu`, decide per role which of the two menus each user sees, so different roles can get completely different toolbar navigation. Individual custom-menu items can be limited to certain roles or languages by setting `metadata` (need_roles / disallowed_roles / allowed_languages) on the menu-link definition. A separate "Shortcuts" feature can pull the blocks of a chosen admin-theme region into the toolbar as an extension. The module also ships a "Theme Condition" plugin (limit blocks/visibility by active theme) and convenience redirect routes that jump to the edit form of an entity matched by query parameters. Requires Admin Toolbar; core `^11`.

---

- Replace Drupal's developer-oriented admin toolbar tree with an editor-friendly custom menu.
- Build the toolbar navigation from an ordinary menu you edit at Structure to Menus.
- Merge custom links into the existing admin menu, prepended before the default items.
- Merge custom links into the existing admin menu, appended after the default items.
- Wrap the whole default admin menu under one collapsed "Admin" root so custom links lead.
- Drop the default admin menu from the toolbar entirely and show only the custom menu as its own item.
- Give editors a short, task-focused toolbar while admins keep the full default tree.
- Show the custom menu to some roles and the default menu to others via two permissions.
- Grant `access_custom_menu` to editors so they see the curated menu.
- Grant `access_default_menu` to admins so they retain the standard admin toolbar.
- Hide a specific custom-menu item from certain roles (disallowed_roles metadata).
- Restrict a custom-menu item to only certain roles (need_roles metadata).
- Show a custom-menu item only in specific interface languages (allowed_languages metadata).
- Deep-link the toolbar to any admin path by adding a normal menu link to the custom menu.
- Add quick links to Views, reports, or external URLs directly in the toolbar.
- Surface a chosen admin-theme region's blocks in the toolbar as a shortcuts extension.
- Show contextual page-title blocks in the toolbar via the shortcuts region.
- Let modules/themes tweak the rendered custom menu with hook_custom_admin_menu_alter.
- Let modules/themes tweak a single custom item with hook_custom_admin_menu_item_alter.
- Restrict block placement or other conditions by active theme with the Theme Condition plugin.
- Jump straight to the edit form of the newest node matching query parameters.
- Jump straight to the edit form of a taxonomy term matched by query parameters.
- Redirect to the edit form of any entity type matched by query parameters.
- Pair with the Gin / Gin Toolbar theme for a polished custom admin toolbar.
- Keep the full default admin menu for the superuser (user 1) regardless of item metadata.
- Give each role its own toolbar shape without touching the underlying admin menu structure.
