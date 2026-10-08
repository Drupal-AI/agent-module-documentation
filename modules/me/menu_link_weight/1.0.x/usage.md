Menu Link Weight replaces the numeric "weight" dropdown on menu link forms (including the menu settings on the node edit form) with a drag-and-drop tabledrag widget, so editors order a menu item among its siblings visually instead of guessing a weight number.

---

On the node edit form (`menu_link_weight_form_node_form_alter`) and the menu-link UI, the module hides core's `weight` select (`#access = FALSE`) and injects a **tabledrag table** listing the chosen parent's existing children plus the current link, letting the editor drag the item into position; a process callback (`menu_link_weight_node_element_process`) rebuilds the sibling list via AJAX whenever the parent changes, and hidden `db_weights` fields plus submit/validate handlers translate the drag order back into real menu-link weights (recomputed across the −50…50 range). Its logic is split across `.inc` files (`menu_link_weight.node.inc`, `menu_link_weight.menu_ui.inc`, `menu_link_weight.reorder.inc`). The only configuration is `menu_link_weight.settings:menu_parent_form_selector` (`default` or `cshs`), set at `/admin/config/user-interface/menu-link-weight` (route `menu_link_weight.settings`, permission `administer site configuration`). When set to `cshs` **and** the Client-side hierarchical select (`cshs`) module is installed, a service provider (`MenuLinkWeightServiceProvider`) swaps core's `menu.parent_form_selector` for `CshsMenuParentFormSelector`, giving a nicer hierarchical parent picker; a config subscriber invalidates the container when the setting changes so the swap takes effect. It defines no permissions, entities, plugins, or Drush of its own and depends on `menu_ui` and `node`.

---

- Let content editors drag a page's menu item into the right position among its siblings instead of setting a weight number.
- Order menu links visually directly on the node edit form's Menu settings.
- Avoid the confusing −50…50 weight dropdown for non-technical editors.
- Reposition a menu item and immediately see the sibling order update via AJAX when changing its parent.
- Recompute clean sibling weights automatically after a drag reorder.
- Provide a friendlier menu-ordering UX on large menus with many siblings.
- Switch the parent menu link selector to a client-side hierarchical select (`cshs`) for deep menu trees.
- Keep the default parent selector while still getting the tabledrag weight widget (`default`).
- Configure the parent selector widget at /admin/config/user-interface/menu-link-weight.
- Restrict who can change the selector via the 'administer site configuration' permission.
- Reduce editor errors when two menu items would otherwise share the same weight.
- Order items in the main navigation menu by dragging during content editing.
- Reorder footer or utility menu links from the node form.
- Give editors a WYSIWYG-style ordering experience consistent with core tabledrag tables.
- Deploy the selector choice as exportable configuration (`menu_link_weight.settings`).
- Pair with the cshs module to combine hierarchical parent selection and drag ordering.
- Let editors move a link under a new parent and drop it exactly where they want.
- Standardize menu ordering UX across content types that use menu settings.
- Handle disabled menu links gracefully in the reorder list (shown as disabled).
- Insert a brand-new menu link at a precise position relative to existing siblings.
