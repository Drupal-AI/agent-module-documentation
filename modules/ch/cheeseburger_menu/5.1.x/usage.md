<!-- SPDX-License-Identifier: GPL-2.0+ -->
Cheeseburger Menu provides a configurable "hamburger" off-canvas menu for Drupal, built from one or more menus and/or taxonomy vocabularies, placed as a block plus a separate trigger block.

---

The module ships two Block plugins: `cheeseburger_menu` (the sliding panel that renders the aggregated menu tree) and `cheeseburger_menu_trigger` (the button that opens/closes it). All configuration is done in the blocks' settings forms (there is no central admin page and `configure` is null). On the menu block you aggregate any number of source **menus** and **taxonomy vocabularies** into a single ordered, weighted tree, and per source you control max depth, initial visibility level, whether it is expanded by default, and a title (with override/collapsible options) plus an optional SVG icon. A large set of color+opacity settings styles the left/right panels, the trigger, and the scrollbar. Toggles include using the module's default CSS/JS, showing a top navigation, rendering the parent menu item as a link, highlighting the active trail, and `invoke_hooks` (off by default for performance) which enables three alter hooks. The trigger block references the menu block by id and can be shown only at chosen breakpoints or a custom media query. Rendering is cache-aware (custom cache tags like `cheeseburger_menu:<id>`, a `route.taxonomy_term_tree:<vocab>` cache context, and per-menu active-trail contexts). A menu-link plugin/deriver also exposes language-switch links, and settings persist on the `block.block.<id>` config entity under `settings`.

---

- Add a mobile hamburger menu that slides in the site's main navigation.
- Provide an off-canvas menu that works on both desktop and mobile.
- Aggregate several menus (e.g. Main + Footer + a custom menu) into one hamburger panel.
- Render a taxonomy vocabulary (e.g. product categories) as a navigable menu.
- Combine menus and taxonomy terms in a single weighted, ordered tree.
- Limit how deep each menu renders using per-source max depth.
- Control which levels are visible initially (initial visibility level / expanded-by-default).
- Brand the menu with custom left/right panel background and text colors and opacities.
- Style the trigger button and its background color independently of the panel.
- Customize the scrollbar color of a long menu panel.
- Show the menu trigger only below a certain breakpoint (mobile-only hamburger).
- Restrict the trigger to a custom CSS media query for precise responsive control.
- Attach an SVG icon to each aggregated menu/vocabulary in the panel.
- Give a menu a custom, collapsible, or overridden title inside the panel.
- Highlight the active menu item by tracking the active trail.
- Show the parent menu item itself as a clickable link (not just a toggle).
- Disable the module's default CSS/JS to fully theme the menu yourself.
- Add language-switch links into the menu via the provided menu-link deriver.
- Programmatically alter individual menu items (classes/attributes) via `hook_cheeseburger_menu_item_alter()`.
- Retitle or add classes to a whole aggregated menu via `hook_cheeseburger_menu_alter()`.
- Add custom menu tree manipulators via `hook_cheeseburger_menu_tree_manipulators_alter()` (e.g. language filtering).
- Turn off hook invocation (`invoke_hooks`) for better performance when you don't use the alter hooks.
- Place multiple independent cheeseburger menus (each with its own trigger) on one site.
- Deploy the menu configuration via exported block config across environments.
- Keep the menu cache-correct with the module's per-menu and taxonomy tree cache contexts/tags.
- Present a category-tree navigation for a content-heavy site without building a menu by hand.
- Show menu titles in a top navigation bar within the panel for quick section jumping.
