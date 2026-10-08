Adds a client-side depth filter and a "hide disabled items" toggle to Drupal's menu edit pages so long menus are easier to work with.

---

Admin Menu Levels is a small, JavaScript-only convenience module for the menu administration screens. On any menu edit page (admin/structure/menu/manage/{menu_name}) it injects two extra controls: a "Number of levels to display" select (One, Two, Three — inclusive of shallower levels — or All) and a "Hide disabled items" checkbox. An attached jQuery behavior tags each row of the menu-overview table with its indentation depth and then shows or hides rows to match the chosen depth and the disabled-items toggle. The filtering is purely visual and client-side; the choices are not saved to configuration and do not change the menu itself. It is aimed at large menus — the administration menu, for example, which can have hundreds of items — where scrolling the full tree is tedious. The module adds no routes, permissions, config, or PHP beyond a single hook_form_alter, and reuses the existing menu-edit page (already gated by core's "administer menu" access).

---

- Collapse a huge administration menu to just its top level while editing.
- Show only the first two levels of a deep menu to focus on a section.
- Temporarily hide disabled menu links so only active items are visible.
- Make the menu overview table shorter and easier to scan on long menus.
- Quickly switch between one-, two-, and three-level views while reordering items.
- Reduce scrolling when dragging items in a menu with hundreds of entries.
- View all levels again with a single "All" selection when needed.
- Combine a depth limit with the hide-disabled toggle for a minimal working view.
- Speed up menu housekeeping on sites with sprawling navigation structures.
- Help editors avoid losing their place in a very long menu tree.
- Apply the filter per page load without altering the stored menu.
- Work on any menu edit page without extra configuration.
- Improve usability of the menu UI for site builders and content editors with menu access.
- Focus on enabled items when auditing which links are live.
- Avoid third-party dependencies — it uses only core jQuery/Drupal libraries.
- Keep the menu structure untouched (purely a display aid, nothing is saved).
- Serve as a lightweight example of a hook_form_alter plus attached JS behavior.
- Ease review of imported or migrated menus that arrive very deep.
- Let admins toggle depth on the fly instead of manually expanding/collapsing.
- Reduce visual clutter when demonstrating a menu to stakeholders.
