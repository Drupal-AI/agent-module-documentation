<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Menu Children Filter adds Views handlers that let a View list the child menu items (and their nodes) of a given parent node, based on the site's menu hierarchy rather than an entity reference field.

---

The module registers a contextual filter (argument), a sort, and a filter with Views, plus an internal join plugin that all three share. The argument (`menu_children`, Views plugin id `menu_children`, attached to the `node` Views-data table as field `menu_children_filter`) takes a node ID (or is left unset for top-level items) and restricts the View to nodes whose menu link's `parent` is the menu link of that node, optionally scoped to one or more `target_menus`. The sort (also plugin id `menu_children`, attached to `node` as field `menu_children_sort`) orders results by the menu link's `weight`, then node title, then link ID. The filter `menu_children_enabled` (attached to `node` as field `menu_children_enabled`) restricts results to menu links that are enabled or disabled. All three join `node_field_data` to `menu_link_content_data` through the custom `menu_children_node_join` Views join plugin, which matches `menu_link_content_data.link__uri` against `entity:node/<nid>` — so it only understands menu links created with the "entity:" URI scheme (typically menu links added directly on a node's edit form), not "internal:" links. The join is applied automatically by the handlers; it is not a user-facing Views relationship. A legacy, deprecated global `menu_children` sort is also registered on the `views` base table for backward compatibility with older configurations.

---

- List the direct child pages of the current node in a sidebar or footer block.
- Build a "sub-navigation" View that mirrors a node's position in the Main navigation menu.
- Show a node's children ordered by their menu link weight (editor-controlled ordering) instead of by title or date.
- Add the "Menu children" contextual filter to a View and pass the current node's ID via "Content ID from URL".
- Restrict the menu-children argument to a specific set of menus using its "Target menus" option.
- Build a landing page that automatically lists its children as defined by the site's menu structure.
- Hide a "children" block entirely when a node has no menu-linked children, using "Hide view when filter is not available".
- List only the *enabled* menu-linked children of a node, filtering out disabled/administratively hidden menu items with `menu_children_enabled`.
- List only the *disabled* menu-linked children of a node for an admin-facing audit View.
- Combine the `menu_children` argument with the `menu_children` sort to get an ordered menu-driven child listing in one View.
- Recreate a simple site map section that follows menu hierarchy without needing an entity reference/parent field.
- Show top-level menu items as nodes by passing no argument value (or 0), which filters to menu links with no parent.
- Build a "related pages" block placed on node pages, using block context mapping to feed the current node into the argument.
- Migrate a legacy site that organizes content purely through menu parent/child relationships into a Views-driven listing.
- Order a category-style listing by menu weight so editors can drag-and-drop reorder it via the menu admin UI.
- Combine `target_menus` scoping with the enabled filter to show only active links from "Main navigation".
- Use the module instead of writing a custom argument/sort/filter plugin when menu hierarchy needs to drive Views query results.
- Add a debug/admin View that lists which menu-linked children of a node are currently disabled.
- Build breadcrumb-like "siblings" or "children" navigation widgets sourced from the menu tree rather than taxonomy.
- Expose the `menu_children` sort so anonymous users can toggle ascending/descending order of menu-weighted results.
- Recreate the module's Main navigation "children of the current node" footer-block example from its README.
- Layer the enabled filter on top of the argument to avoid showing disabled menu items to end users.
- Query children scoped to multiple menus at once by selecting several menus in "Target menus".
