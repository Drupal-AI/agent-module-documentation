Menu Block Title adds a "Block title as menu link parent" checkbox to menu blocks so the block's title becomes a link to the active menu item's parent — ideal for sidebar navigation blocks.

---

The module adds one checkbox, **"Block title as menu link parent"**, to the configuration form of
any menu-based block (core system menu blocks and blocks from the contrib `menu_block` module — it
only appears when the block form has a `menu_levels`/`level` setting). The choice is stored as a
third-party setting on the block config entity:
`block.block.<id>` → `third_party_settings.menu_block_title.modify_title: true`. At render time
`hook_block_view_alter()` (implemented as `MenuBlockTitleHooks::blockViewAlter`, an OOP `#[Hook]`)
checks that setting via `_menu_block_title_needs_modifying()`; when enabled it registers a
`#pre_render` callback (`MenuBlockTitle::preRender`, a trusted callback) and adds the cache context
`route.menu_active_trails:<menu>`. The pre-render loads the menu tree for the current route, finds
the item in the active trail, and replaces the block's `label` with a link (`#type => link`) to that
item. The result: the block title links back to the parent/section the visitor is currently in.
There is no settings page, route, permission, service, block or Drush command of its own — just the
per-block checkbox and its third-party setting. It works best on a menu block starting at level 2.

---

- Turn a sidebar menu block's title into a link back to the current section's parent page.
- Show the top-level section name as a linked heading above a second-level navigation block.
- Give a "child pages" menu block a title that links to the parent page you are viewing.
- Provide contextual "you are here" section headers driven by the menu active trail.
- Enable the behaviour on a core system menu block (e.g. Main navigation) without custom code.
- Enable it on a `menu_block`-module block placed at menu level 2 for section navigation.
- Make documentation sidebars where the block title returns to the chapter landing page.
- Build product-category sidebars whose heading links to the current category's parent.
- Keep the block title in sync with whichever menu branch the visitor is browsing.
- Store the toggle in exported block config as `third_party_settings.menu_block_title.modify_title`.
- Turn the feature on or off per block instance rather than site-wide.
- Add section-aware navigation to a multi-level menu without a menu-specific theme template.
- Replace a hard-coded block title with a dynamic parent link that updates with the route.
- Improve deep-hierarchy sites where users need a quick jump up one level.
- Pair with a menu block configured to follow the active trail for context-sensitive sidebars.
- Give knowledge-base or wiki menus a linked section title.
- Provide breadcrumb-like parent linking directly in the sidebar block heading.
- Use on an intranet's departmental menu so the heading links to the department landing page.
- Ensure the modified title is cache-correct via the added `route.menu_active_trails` context.
- Configure it entirely through the block layout UI (`/admin/structure/block/manage/<id>`).
- Apply it to several menu blocks, each showing its own branch's parent as the title.
- Migrate the setting between environments as part of block config.
- Avoid writing a custom `hook_block_view_alter()` just to relabel a menu block.
