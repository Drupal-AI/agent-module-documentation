# Only One for Admin Toolbar — agent index

Bundled glue submodule of **onlyone**. **No config of its own, no configure route, no
permissions, no Drush, no plugin types.** It keeps the Admin Toolbar Tools *Add content* menu
in sync with the Only One restricted types.

What it does (all in `onlyone_admin_toolbar.module` + one service):
- `hook_menu_links_discovered_alter()` — for each type in
  `onlyone.settings.onlyone_node_types` that already has a node, appends **" (Edit)"** to its
  *Add content* link title; when `onlyone.settings.onlyone_new_menu_entry` is on, moves those
  links under the `onlyone.add_page` parent.
- Service **`onlyone.admin_toolbar`** (`OnlyOneAdminToolbar::rebuildMenu($content_type)`),
  called from `hook_entity_insert/update/delete` on nodes to rebuild the menu when a configured
  type's node count changes.
- Event subscriber on `OnlyOneEvents::CONTENT_TYPES_UPDATED` (`onlyone.content_types_updated`)
  → rebuilds routes when the restricted list changes.

Requires modules **`admin_toolbar_tools`** and **`onlyone`**. To use it: just enable it
(`drush en onlyone_admin_toolbar -y`) — no further setup. All behavior is driven by the parent
module's `onlyone.settings`; see `../../../2.0.x/agent/configure/onlyone.md`.
