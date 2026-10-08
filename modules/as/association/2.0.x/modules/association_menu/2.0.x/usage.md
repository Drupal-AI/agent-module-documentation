Gives each association its own navigation menu and breadcrumb, with items stored in a dedicated table and rendered through the core menu theme.

---

`association_menu` is a submodule of Entity Association (also needs Toolshed). It manages per-association menus separately from core's menu system, storing items in its own `association_menu` DB table via `AssociationMenuStorage`. A menu item may reference an associated entity (created/removed automatically as association content is added or deleted), a routed internal path, or an external URI. Editors manage a menu at `/association/{association}/menu` and add/edit/delete items through form routes, all requiring the association's `manage` access plus the `access association menu management` permission. `AssociationMenuBuilder` turns stored items into a `#theme => 'menu'` render array, running a route access check per routed item so links the viewer can't reach are hidden. The Association display block (from the parent module) can render an association's menu. A "Rebuild association menus" admin form and events allow refreshing and altering the generated links.

---

- Attach a bespoke navigation menu to each association (e.g. a mini site-nav for a campaign package).
- Automatically add a menu link for every entity added to an association, and remove it on deletion.
- Add custom menu items pointing to internal Drupal paths (validated via the path validator).
- Add external links (`https://…`) or special routes (`<front>`, `<nolink>`, `<none>`, `<button>`).
- Nest menu items into a tree (parent/child) when the type allows menu nesting.
- Reorder, enable/disable, and expand/collapse menu items per association.
- Set link attributes (target `_blank`, rel, CSS classes) on custom menu items.
- Hide menu links a given visitor cannot access (per-item route access check at build time).
- Render the association menu inside the Association display block (visible / by-field / hidden).
- Choose which behavior tags are menu-enabled by default via the association type's Toolshed config.
- Rebuild association content menus in bulk from `/admin/structure/association/menu-overview`.
- Derive breadcrumbs for association content from the association's menu structure.
- React to menu link creation/load/alter through the module's dispatched events.
