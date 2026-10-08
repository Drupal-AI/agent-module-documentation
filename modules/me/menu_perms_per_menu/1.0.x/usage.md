<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Menu Perms per Menu extends the Menu Admin per Menu module with a set of fine-grained, per-menu permissions that control which individual menu-link operations (add, delete, enable/disable, expand, edit the link, translate) a role may perform on each menu.

---

Menu Admin per Menu already lets you grant a role "administer" access to specific menus rather than all of them. Menu Perms per Menu builds on that by dynamically generating six extra permissions **for every menu** on the site, so you can allow a role to, say, reorder and rename links in the Main menu but forbid it from adding or deleting them. It has no configuration UI of its own (`configure` is null); everything is done at *People → Permissions* (`admin/people/permissions`). Enforcement happens two ways: a route subscriber (running after menu_admin_per_menu at priority -225) attaches `_custom_access` checks to the add-link, delete and translate routes, and `hook_form_alter()` implementations on the menu-link edit form (`menu_link_content_menu_link_content_form`) and the per-menu overview form (`menu_edit_form`) disable or remove the Link/Enable/Expand fields and the Delete/Translate/Add-child operations for users lacking the matching permission. It also overrides the menus overview controller to hide the "Add link" operation per menu. The permission machine names embed the menu id (e.g. `add new links to main menu from menu interface`), so new permissions appear automatically whenever a menu is created. The Link/Enable/Expand field restrictions are applied as form `#disabled`.

---

- Let an editor rename and reorder links in the Main menu but block them from adding new links.
- Prevent a role from deleting links in the Footer menu while still allowing edits.
- Allow a translator role to translate Main-menu links but not change their targets.
- Give a content team enable/disable rights on the Main menu without delete rights.
- Restrict who can toggle "Show as expanded" on links in a mega-menu.
- Forbid editing the destination URL of links in a curated navigation menu while allowing label changes.
- Grant "add child link" on one menu but not another to different roles.
- Hide the "Add link" button on menus a role may not extend.
- Delegate day-to-day menu maintenance of a single menu to a junior editor safely.
- Separate "structure" rights (reorder) from "content" rights (edit link) on menus.
- Lock down the admin/navigation menu so only super admins can delete its items.
- Let a marketing role manage a promotions menu end to end while other menus stay read-only for them.
- Prevent accidental deletion of critical menu links by removing the Delete operation for most roles.
- Allow enable/disable of seasonal menu links without granting full menu administration.
- Combine with menu_admin_per_menu to scope both *which* menus and *what operations* a role gets.
- Give multilingual teams per-menu translate permissions aligned with their language duties.
- Keep the "expand" behaviour of a menu under change control by a single role.
- Build a workflow where one role drafts links (add) and another approves/publishes (enable).
- Audit exactly which role can perform which menu operation from the permissions page.
- Restrict a client role on a multi-site to editing only their own menu's links.
- Remove the Translate operation from menus that are not translated to reduce UI clutter for editors.
- Grant granular menu rights to a "menu manager" role without giving broad `administer menu`.
- Ensure new menus automatically get the same six-permission scheme with no extra setup.
- Constrain a headless/API editor role's menu capabilities through the standard permissions system.
