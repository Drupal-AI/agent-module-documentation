Draggable Dashboard lets privileged users build multi-column dashboards out of arbitrary Drupal blocks and then place each dashboard anywhere on the site as a single block.

---

The module defines a `dashboard_entity` config entity (title, description, column count, and an ordered `blocks` array) managed at *Structure → Draggable Dashboard* (`admin/structure/draggable-dashboard`, route `entity.dashboard_entity.collection`). For each dashboard you pick a column, browse the standard block library (filtered by `block_ui`, context-aware), and add block plugins; each added block stores its own plugin configuration plus a `column` and `weight`. A block deriver (`DraggableBlockDeriver`) exposes one placeable block per dashboard (`draggable_dashboard_block:draggable_dashboard_<id>`), which you then position via core's Block layout. At render time `DraggableBlock::build()` rebuilds the columns, instantiates each inner block, and — importantly — calls `$block_instance->access($currentUser)` on every inner block so per-block access is still enforced; title blocks receive the current page title. A JS layer (`core/sortable`) provides drag-and-drop reordering in the admin UI and a collapsible front-end presentation (`assets/js/*`). All dashboard admin routes and the entity's `admin_permission` are gated by the single `administer_draggable_dashboard` permission; the placeable block itself is visible to anyone with `access content`. Templates `draggable-dashboard-view.html.twig` and `block--dashboard-item.html.twig` render the grid. No Drush, no submodules.

---

- Build a curated "quick links / favourite functions" landing dashboard for editors.
- Assemble a multi-column admin start page out of existing blocks.
- Create a marketing landing page composed of blocks arranged in columns.
- Let staff drag blocks between columns to reorder a dashboard without code.
- Reuse the same dashboard as a block on several pages via Block layout.
- Group Views blocks, custom blocks, and system blocks into one placeable unit.
- Provide role-specific dashboards by placing different dashboards with block visibility rules.
- Configure each embedded block's settings (label, count, etc.) inline while adding it.
- Set the number of columns (grid width) per dashboard.
- Reorder blocks within a column by weight via drag-and-drop.
- Present a collapsible/minimizable widget layout on the front end.
- Compose a "my account" style hub of user-relevant blocks.
- Keep block placement for a page bundled in one config entity for export.
- Build a departmental intranet homepage from shared blocks.
- Add a dashboard block to the sidebar or content region of any theme region.
- Create several independent dashboards for different sections of a site.
- Show page-title-aware blocks inside a dashboard (title block support).
- Duplicate a dashboard's structure by cloning its config entity.
- Give content teams a no-code way to rearrange homepage widgets.
- Surface reports/metrics blocks together on one screen.
- Export dashboards as configuration for deployment across environments.
