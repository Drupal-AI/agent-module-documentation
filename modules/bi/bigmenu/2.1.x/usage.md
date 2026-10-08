Big Menu makes editing very large menus manageable by replacing core's single-page menu overview form with a shallow, depth-limited tree that loads only the top levels and lets you drill into child items on demand.

---

Big Menu targets the one place core Drupal struggles with menus: the menu edit screen at `/admin/structure/menu/manage/{menu}`. Core's `menu_ui` renders the *entire* menu tree as one giant draggable table, so a menu with thousands of links can time out, exhaust memory, or produce an unusable page. Big Menu swaps the `menu` entity's `edit` form class for its own `BigMenuForm` (via `hook_entity_type_alter()`), subclassing `menu_ui`'s `MenuForm` but loading the tree only to a configurable `max_depth` (default 1, i.e. just the top level). Each parent that has children gets an "Edit child items" link that reloads the same form rooted at that link (`?menu_link=<plugin_id>`), with a breadcrumb back to the top, so you navigate the menu one level at a time instead of rendering it all at once. The module ships a single setting — `max_depth` (0–10) — configured at `/admin/config/bigmenu` (route `bigmenu.settings`, permission `administer site configuration`), stored in `bigmenu.settings`. There are no new permissions, entities, plugins, services, or Drush commands; it simply overrides the existing menu-management UI. It depends only on core `menu_ui`.

---

- Make an oversized menu (thousands of links) editable again when core's menu overview page times out or runs out of memory.
- Replace the core menu management screen globally without changing how you reach it (`/admin/structure/menu/manage/{menu}`).
- Load only the top level of a huge menu, then drill into branches via "Edit child items" instead of rendering the whole tree.
- Set how many levels of the menu render at once by tuning `max_depth` (e.g. 1 for the shallowest, 2–3 for a bit more context per page).
- Speed up the menu editor on sites with imported catalog, taxonomy, or product menus that have grown very deep.
- Avoid PHP `max_execution_time` / memory-limit errors when opening a large menu for editing.
- Reorder or re-parent links within a single branch using the familiar drag-and-drop table, scoped to that branch only.
- Enable/disable individual menu links on a large menu without loading every sibling and descendant.
- Keep editors oriented in a deep menu with the breadcrumb trail that Big Menu adds above the link table.
- Drop-in accelerate menu editing on multilingual or commerce sites where menus mirror large content structures.
- Reduce browser-side lag from rendering thousands of table rows and tabledrag handles at once.
- Give content teams a workable admin menu editor on low-memory hosting tiers.
- Limit the initial menu page to the top level so it opens quickly, deferring child loads until needed.
- Preserve core menu features (weights, enable toggles, operations dropbuttons, add-link) while only limiting depth.
- Use as a lightweight alternative to restructuring or splitting a legitimately large menu.
- Configure a shared depth policy for every menu on the site from one settings form.
- Troubleshoot a specific broken branch of a large menu by navigating straight to it via its `menu_link` query parameter.
- Roll out safely: because it only overrides the edit form, disabling the module instantly restores core behavior.
- Support site builders who must maintain mega-menus that would otherwise be uneditable in the UI.
- Keep menu editing responsive as a menu keeps growing over the life of a site.
