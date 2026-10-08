<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Menu Permissions replaces core's single all-or-nothing "Administer menus and menu links" permission with fine-grained, per-menu permissions, letting you grant a role rights over one specific menu (and even split viewing, editing links, and deleting the menu itself) without handing over control of every menu on the site.

---

Core Drupal only ships one `administer menu` permission that grants a role full control of every menu. Simple Menu Permissions breaks that down into dynamically generated permissions: for each menu that exists it creates six permissions — `view <id> menu in menu list`, `edit <id> menu`, `delete <id> menu`, `add new links to <id> menu`, `edit links in <id> menu`, and `delete links in <id> menu` — plus one global `create new menu` permission. New permissions appear automatically whenever a menu is created. It enforces these through several mechanisms: a `hook_entity_type_build()` swaps in custom access-control handlers and list builder for the `menu` and `menu_link_content` entity types; a `RouteSubscriber` sets `create new menu` as the requirement on the menu add route and attaches a custom access checker (`MenuRoutesAccessChecker`) to the menu edit, delete, and add-link routes; a `MenuListBuilder` filters the menus overview by the "view … in menu list" permission; and a `MenuParentFormSelectorDecorator` (decorating `menu.parent_form_selector`) restricts which menus appear in the parent-menu dropdown on menu-link and node forms. A `hook_form_node_form_alter()` disables and hides menu fields on node forms when the selected parent menu is restricted. There is no configuration UI — you simply assign the generated permissions on People → Permissions (`/admin/people/permissions`). Requires core's Menu UI and Menu Link Content modules. The core `administer menu` permission still grants full control and bypasses these checks.

---

- Let a "Content editor" role manage only the Main navigation menu's links.
- Give a "Footer editor" role rights to edit links in the Footer menu alone.
- Allow a role to add new links to a menu but not delete the menu itself.
- Let editors edit links in a menu while forbidding them from deleting links.
- Grant a role permission to create brand-new menus with `create new menu`.
- Show a menu in the menu-list overview only to roles that may view it.
- Delegate a department's sub-menu to that department's staff.
- Keep core `administer menu` reserved for true site administrators.
- Restrict the parent-menu dropdown on node forms to permitted menus.
- Hide menus a user can't manage from the menu-link parent selector.
- Split view / edit / delete rights on a single menu across different roles.
- Let a microsite team manage its own navigation menu in a shared install.
- Allow agency clients to edit only their own site's menu links.
- Enforce least-privilege access to navigation across many roles.
- Prevent junior editors from renaming or deleting menus while editing links.
- Give a translator role edit access to a language-specific menu.
- Let a role reorder and edit existing links without adding or deleting any.
- Permit deleting stale links in one menu without touching other menus.
- Combine "add new links" and "edit links" to fully delegate a menu's items.
- Grant per-menu view access so a role can browse but not modify a menu.
