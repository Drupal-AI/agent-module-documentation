<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Menu Children Filter — agent index

Adds Views handlers (not a new plugin type — it *implements* Views handlers, it does not
*define* one) that list a node's child menu items using the site's menu hierarchy. No
settings form, no configure route (`configure: null`), no permissions, no Drush. All state
lives in a View's own config (`views.view.<id>` → `display.*.display_options.arguments` /
`.filters` / `.sorts`).

- **Add/inspect the menu-children argument, sort, or filter on a View; real plugin ids and
  the Views-data table/field they attach to; how the internal join works** →
  [api/views-handlers.md](api/views-handlers.md)

Key facts:
- Argument (contextual filter): Views plugin id `menu_children`, class `MenuChildren`
  (`argument` type), Views-data key `node.menu_children_filter`.
- Sort: Views plugin id `menu_children`, class `MenuChildren` (`sort` type), Views-data key
  `node.menu_children_sort`.
- Filter: Views plugin id `menu_children_enabled`, class `MenuItemEnabledFilter`, Views-data
  key `node.menu_children_enabled`.
- Join (internal, applied automatically by the three handlers above, not user-selectable):
  plugin id `menu_children_node_join`, joins `menu_link_content_data` to `node_field_data`.
- Only works for **node** entities, and only for menu links using the `entity:node/<nid>` URI
  scheme (links added on a node's own edit form) — `internal:` links are not supported.
