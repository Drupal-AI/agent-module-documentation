CSHS Menu Link (a submodule of Client-side Hierarchical Select) turns the "Parent item" menu-link dropdown on node forms — and taxonomy term forms with taxonomy_menu_ui — into the client-side hierarchical CSHS drill-down selector.

---

Drupal's menu_ui module adds a "Parent item" select to the node edit form so you can place the node in a menu; on large menus this becomes an unwieldy flat list. This submodule alters that form (`hook_form_BASE_FORM_ID_alter` on the node form, and the taxonomy term form when `taxonomy_menu_ui` is enabled) and swaps the parent-item select for the `cshs` element, giving level-by-level dropdowns instead. It guards against double-transforming an element that another module already converted, and attaches its own small CSS library. It requires the parent `cshs` module plus core `menu_ui`. There is no configuration — enable it and the menu parent picker becomes hierarchical automatically.

---

- Make the "Parent item" menu picker on node forms hierarchical.
- Drill down a deep site menu instead of scrolling a flat select.
- Place a node under a deeply nested menu item quickly.
- Apply the same CSHS selector to taxonomy term menu placement (with taxonomy_menu_ui).
- Reduce menu-placement mistakes on large navigation trees.
- Improve editor UX on sites with hundreds of menu items.
- Keep menu parent selection consistent with hierarchical term selection.
- Speed up choosing a parent menu item on mobile/narrow screens.
- Avoid a giant single dropdown for the main navigation menu.
- Enable hierarchical menu-parent selection with zero configuration.
- Let editors see the menu structure level by level while placing content.
- Prevent accidental placement at the wrong menu depth.
- Provide a cleaner menu-parent UI for content authors.
- Standardize the parent-picker experience across node and term forms.
- Use CSHS drill-down for menu placement without touching field config.
- Handle multi-level main menus gracefully during content editing.
