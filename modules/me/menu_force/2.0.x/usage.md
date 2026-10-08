<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Menu Force makes the core "Menu settings" mandatory on chosen content types, so a node cannot be saved until it is placed in a menu. It adds two checkboxes to the content-type edit form and stores the choice as a third-party setting on the node type.

---

Menu Force depends on core `menu_ui` and works entirely by altering forms — it defines no field, no entity, no settings page, and no configure route. On the content-type edit form (`NodeTypeForm`) it adds two checkboxes under the *Menu settings* tab: "Make the Menu Settings mandatory for this content type" (`menu_force`) and "Lock the 'Default parent item' as well" (`menu_force_parent`). These are saved as third-party settings on the `node.type.<bundle>` config entity (`third_party_settings.menu_force.menu_force` and `menu_force_parent`, both booleans). When `menu_force` is on, the node add/edit form for that type has the menu fieldset forced open, the "Provide a menu link" checkbox checked and disabled, and the menu link title made required — so editors must add a menu entry. When `menu_force_parent` is also on, the parent-item selector is disabled too, pinning new content under a fixed parent. A common reason to use it is Pathauto's `[node:menu-link:...]`/`menupath` tokens, which need the node to actually live in the menu tree. A bundled submodule, `menu_force_taxonomy_menu_ui`, extends the same behaviour to taxonomy terms via the contrib `taxonomy_menu_ui` module.

---

- Force every node of a content type into the menu system before it can be saved.
- Guarantee Pathauto patterns that rely on `[menupath-raw]` / menu-link tokens always have a menu entry to read.
- Make the menu link title a required field on an "Article" or "Landing page" content type.
- Auto-open and pre-check the "Provide a menu link" option so editors cannot skip it.
- Lock new pages of a type under one fixed parent menu item (e.g. everything under "About").
- Prevent orphaned nodes that are missing from navigation on a documentation site.
- Enforce a consistent navigation structure across an editorial team without custom code.
- Require menu placement only on specific bundles while leaving others untouched.
- Combine forced menu placement with a menu-based breadcrumb module that needs menu links.
- Ensure a "Section landing" content type always appears in the main navigation menu.
- Keep a mega-menu complete by making its source content types menu-mandatory.
- Stop editors from accidentally creating a page that never shows up in any menu.
- Pin campaign pages under a chosen "Campaigns" parent so the tree stays tidy.
- Drive menu-driven access or visibility modules that assume every node is in the menu.
- Enforce menu placement through exported config (`third_party_settings.menu_force`) in a deployment workflow.
- Turn the requirement on or off per environment by overriding the node-type config.
- Support a site build where the menu tree is the canonical information architecture.
- Make sure taxonomy landing terms are placed in the menu (via the taxonomy submodule).
- Standardise onboarding so new content authors are guided to set a menu link every time.
- Reduce QA effort by making "add to menu" impossible to forget at the form level.
- Keep menu-based sitemaps or navigation blocks complete and gap-free.
- Ensure children content is always attached under an existing parent for hierarchical menus.
- Use with `menu_ui` to require menu placement without writing a custom validation constraint.
