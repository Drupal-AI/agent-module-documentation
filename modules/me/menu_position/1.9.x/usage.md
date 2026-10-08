<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Menu Position lets you define ordered rules that dynamically place the current page into a menu — so all Articles, or every page under `/news/*`, highlight (or get inserted beneath) a chosen menu item without adding one menu link per node.

---

Each rule is a `menu_position_rule` **config entity** (`menu_position.menu_position_rule.<id>`) holding a label, an `enabled` flag, a `weight`, a target `menu_name` + `parent` menu-link id, a derived `menu_link` plugin id, and a `conditions` sequence of **core Condition plugins** — the module defines no condition plugin type of its own, it reuses `entity_bundle:node`, `request_path`, `user_role`, `current_theme`, `language`, etc. via `plugin.manager.condition`. Placement happens through `MenuPositionActiveTrail`, a service **decorating `menu.active_trail`** (`decoration_priority: 9`): on every page it loads the rules for the requested menu sorted by weight, evaluates each rule's conditions (`MenuPositionRule::isActive()`), and the first active rule decides the active link. The single setting `menu_position.settings:link_display` chooses what "active" means — `parent` (default: mark the rule's parent menu item active), `child` (insert the current page's title into the tree as a real menu link, via the `menu_position_link` deriver) or `none`. Rules are managed at `/admin/structure/menu-position` (list + tabledrag ordering, the `configure` route), added/edited/deleted at `/admin/structure/menu-position/add|{rule}|{rule}/delete` under the permission `administer menu positions`, and settings live at `/admin/structure/menu-position/settings` (`administer site configuration`). Because the active trail drives them, the effect reaches theme main/secondary links, breadcrumbs and every menu block.

---

- Highlight the "News" menu item for every Article node without adding hundreds of menu links.
- Put all nodes of a "Press release" content type under a "Newsroom" parent in the main menu.
- Give an entire path prefix (`/support/*`) a consistent breadcrumb trail.
- Insert the current node's title into the menu tree as a child of a section link (`link_display: child`).
- Keep the sidebar menu block expanded on the correct section for taxonomy-driven landing pages.
- Highlight a "Blog" menu item for blog posts while leaving other content untouched.
- Order competing rules so the most specific one (a path rule) wins over a broad content-type rule.
- Disable a rule temporarily during a campaign without deleting its configuration.
- Restrict a placement to a single user role using the core `user_role` condition.
- Apply a placement only for one theme with the `current_theme` condition.
- Apply a placement only in a specific language with the `language` condition.
- Give search-result or view pages a menu position via a `request_path` rule.
- Fix breadcrumbs on pages that are not in any menu at all.
- Position a whole content type under a menu item in a secondary menu rather than the main menu.
- Avoid a per-node "Menu settings" workflow for editors by making placement a site-builder concern.
- Export menu placement rules as configuration so they deploy with `drush config:import`.
- Model a section-based information architecture where content lives outside the menu tree.
- Keep a menu highlighted for a taxonomy term page and everything filed under it (via a path rule).
- Have a rule that matches everything in a menu (a rule with no conditions is always "matched").
- Switch the whole site between "highlight the parent" and "insert the page" behaviour with one setting.
- Turn off menu highlighting entirely for matched rules (`link_display: none`) while still using the rules elsewhere.
- Re-order rule evaluation with drag-and-drop weights on the rules admin page.
- Give an editor role the `administer menu positions` permission without granting menu administration.
- Debug why a menu item is highlighted by reading `menu_position.menu_position_rule.*` config.
- Replace ad-hoc `hook_menu_active_trail_alter`-style custom code with configuration.
