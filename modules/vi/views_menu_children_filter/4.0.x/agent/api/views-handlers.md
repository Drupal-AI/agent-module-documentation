<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Views handlers this module adds

The module has no service to call and no configuration page. Its entire surface is four
Views plugins registered via `hook_views_data_alter()` in `views_menu_children_filter.views.inc`
and `*.services.yml` / PHP attributes. Ground truth for every id below is that `.views.inc`
file plus the plugin classes in `src/Plugin/views/`.

## 1. Argument (contextual filter) — `menu_children`

- Class: `Drupal\views_menu_children_filter\Plugin\views\argument\MenuChildren`, extends
  `NumericArgument`. Declared via `@ViewsArgument("menu_children")`.
- Views-data attachment: `node.menu_children_filter` (added only for entity type `node`),
  `argument.id = menu_children`. Title "Menu children", data key `menu_children_filter`.
- In a saved View, this shows up as:
  `display.<display>.display_options.arguments.<machine_name>.plugin_id: menu_children`
  with `table: node`, `field: menu_children_filter`.
- Option: `target_menus` (array, machine menu names) — restricts which menus are searched
  for the parent's menu link. Empty = search all menus.
- Behavior: takes a node ID (or a path) as its argument value and restricts the View to
  nodes whose menu link `parent` equals the menu link of that node/path. If the argument
  value is `0`, it filters to top-level menu items (`menu_link_content_data.parent IS NULL`).
  Calls `setRelationship()` which applies the internal join (see #4) and, if `target_menus`
  is set, adds `menu_link_content_data.menu_name IN (...)`.
- To add it: on the View's edit page, "Add contextual filter" → look for **"Content: Menu
  children"** (title comes from `node.menu_children_filter`'s `title`). Configure "Target
  menus" in the handler's own options form. Typically paired with "Provide default value" →
  "Content ID from URL" so the current node feeds the argument.

## 2. Sort — `menu_children`

- Class: `Drupal\views_menu_children_filter\Plugin\views\sort\MenuChildren`, extends
  `SortPluginBase`. Declared via `@ViewsSort("menu_children")`.
- Views-data attachment: `node.menu_children_sort` (table group "Menu Tree", base `field`),
  `sort.id = menu_children`. Title "Menu children weight".
- In a saved View: `display.<display>.display_options.sorts.<machine_name>.plugin_id:
  menu_children` with `table: node`, `field: menu_children_sort`.
- Behavior: applies the internal join, then orders by `menu_link_content_data.weight`, then
  `node_field_data.title`, then `menu_link_content_data.id`, all in the sort's configured
  `order` (ASC/DESC). This mirrors the editor-controlled drag-and-drop weight from the menu
  admin UI.
- A **deprecated** duplicate is also registered globally on the `views` base table
  (`views.menu_children`, same plugin id `menu_children`, title "Menu children weight
  (Deprecated)") — kept only for backward compatibility with older exported Views; prefer
  the `node.menu_children_sort` field on new Views.
- To add it: "Add sort criterion" → **"Content: Menu children weight"**.

## 3. Filter — `menu_children_enabled`

- Class: `Drupal\views_menu_children_filter\Plugin\views\filter\MenuItemEnabledFilter`,
  extends `FilterPluginBase`. Declared via PHP attribute `#[ViewsFilter("menu_children_enabled")]`.
- Views-data attachment: `node.menu_children_enabled` (table group "Menu Tree", base
  `field`), `filter.id = menu_children_enabled`. Title "Menu children enabled".
- In a saved View: `display.<display>.display_options.filters.<machine_name>.plugin_id:
  menu_children_enabled` with `table: node`, `field: menu_children_enabled`.
- Option/value: a radio, `1` = Enabled, `0` = Disabled (default `1`). Applies the internal
  join, then `WHERE menu_link_content_data.enabled = <0|1>`.
- To add it: "Add filter criterion" → **"Content: Menu children enabled"**, choose Enabled
  or Disabled.

## 4. Join (internal only) — `menu_children_node_join`

- Class: `Drupal\views_menu_children_filter\Plugin\views\join\MenuChildrenNodeJoin`,
  extends `JoinPluginBase`. Declared via PHP attribute
  `#[ViewsJoin("menu_children_node_join")]`, and also registered as the service
  `views_menu_children_filter.join_handler` (in `*.services.yml`) with defaults `type:
  INNER`, `table: menu_link_content_data`.
- It is **not** exposed as a selectable Views relationship in the UI — no
  `hook_views_data_alter()` entry adds it as a `relationship`. Instead, each of the three
  handlers above injects the join service and calls `$this->joinHandler->joinToNodeTable($this->query)`
  from its own `query()`/`setRelationship()`, which does
  `$query->queueTable('menu_link_content_data', 'node_field_data', $this)` (guarded against
  duplicate joins).
- `buildJoin()` joins `menu_link_content_data` to `node_field_data` with the condition
  `CONCAT('entity:node/', node_field_data.nid) = menu_link_content_data.link__uri` — i.e. it
  matches menu links whose link URI is exactly `entity:node/<nid>`. Menu links using
  `internal:` URIs will never match.
- Practical consequence: simply adding the argument, sort, or filter to a View is enough to
  get the join; there is nothing to configure for it directly.

## Adding these to a View (summary)

1. Base table: `Content` (`node_field_data`) or any node-based View.
2. Add whichever of: contextual filter **"Content: Menu children"**, sort **"Content: Menu
   children weight"**, filter **"Content: Menu children enabled"** — any combination, they
   share the same join automatically.
3. For the argument, set "Target menus" to scope which menu(s) are searched (empty = all).
4. Only nodes with a menu link using the `entity:node/<nid>` URI (created directly on the
   node's own edit form's "Menu settings") participate — `internal:` links are ignored.
5. Requires only Drupal core's Views module as a dependency; no extra config beyond the
   handler's own options (`target_menus`, filter value) is needed.
