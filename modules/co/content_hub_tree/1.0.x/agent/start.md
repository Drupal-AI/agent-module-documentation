<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Hub Tree — agent start

Admin content-overview screen that renders nodes in a **menu-tree** shape instead of the
flat core Content view. `info.yml` name **"Content Hub Tree"**, version **1.0.0-beta2**,
package `Content`. Core `^8.9 || ^9 || ^10 || ^11`. Depends on core `menu_link_content`.
No dedicated settings form; no permissions of its own.

## What it does

- Adds a **`content_hub_tree`** boolean setting to the core **menu** config entity
  (`hook_entity_type_build` appends it to the menu entity's `config_export`;
  `hook_form_menu_edit_form_alter` / `_menu_add_form_alter` add an **"Include in Content
  tree"** checkbox to the menu add/edit form). `provides_config_schema: true` refers to
  this added menu-config key (no config schema file ships; it rides on the menu entity).
- For every menu flagged with that checkbox, exposes a **"Content tree"** local task tab
  under **Admin → Content** (`system.admin_content`). The tab derivative
  (`Plugin/Derivative/ContentTreeLocalTask`) links to the `main` menu if flagged, else the
  first flagged menu. `hook_menu_local_tasks_alter` keeps the tab active on the route.
- Route **`content_hub_tree.content_hub_tree`** — path `/admin/content/content-tree/{menu}`,
  `_entity_form: menu.content_hub_tree`, requirement **`_permission: 'administer menu'`**.
- `hook_install` flags the `main` menu (`content_hub_tree = TRUE`) on enable.

## The screen (`src/Form/MenuContentTreeForm.php`, an `EntityForm` on the menu entity)

- A **"Select menu"** dropdown (AJAX) listing all flagged menus; changing it redirects to
  that menu's tree route.
- Loads the menu link tree (`menu.link_tree->load(...)`), runs the core `checkAccess` +
  `generateIndexAndSort` manipulators (sets `_menu_admin = TRUE` on the request during the
  check, as core menu_ui does), and renders only links whose `access->isAllowed()`.
- Builds a draggable/collapsible **table** (`#theme table__menu_content_hub_tree`) with
  columns Title, Content type, Status, Author, Updated, Operations. Rows are nested by menu
  depth with a collapse button; JS in `js/content-tree-collapse.js` (library
  `content_hub_tree/content_hub_tree_collapse`) shows/hides sub-rows. Rows deeper than
  `HIDE_MENUS_LVL = 2` start collapsed/hidden.
- **Menu-link → node mapping** (`findNode`): loads `menu_link_content` entities for the
  menu; for each whose URL is routed to `entity.node.canonical` (or `<front>` resolved to
  the front-page node), maps the link's plugin id to that node id, then loads the nodes via
  `entityRepository->getActiveMultiple('node', …)`.
  - Links that map to a node render the node's **title, type, status, author (uid),
    changed** fields via `HelperService::viewField()`, reusing the field formatter settings
    from the `content` view's display when that view exists (else a plain formatter). The
    Operations column shows the node's entity-operation links (edit/delete/etc.).
  - Links that map to **no** node render the menu link itself (`Link::fromTextAndUrl`) and a
    non-actionable "Menu link" label; their bulk-select checkbox is disabled.
- **Bulk operations**: an "Action" select populated from all `action` entities of type
  `node` (filtered through the `content` view's `node_bulk_form` selected-actions config if
  present). "Apply to selected items" runs the chosen node action over the selected nodes.
  Each node is re-resolved via `findNode`, and the action's plugin **`access($entity,
  currentUser())` is checked per node** before execution (nodes failing access are skipped
  with an error message).

## Services / helpers

- `content_hub_tree.helper` (`HelperService`, arg `@entity_type.manager`): `viewField()`,
  `getBulkOptions()`, `getActions()`, `getContentView()` (loads the `content` view), and the
  static `clearRouteDefinitionsCache()` submit handler that rebuilds the router when a menu's
  `content_hub_tree` flag changes (so the tab appears/disappears).

## Security / operational notes (public, factual)

- The tree screen is gated by the core **`administer menu`** permission (a restricted admin
  permission); it is an admin content-management tool, not an anonymous-facing feature.
- Bulk node actions perform a **per-node access check** (`action plugin ->access()`) before
  executing.
- No external HTTP/API calls, no webhooks, no secrets. Node/menu fields are rendered through
  standard field formatters and `Link` render arrays (no raw markup).

## Related docs

- Setup / usage for site builders → [../human-docs/index.md](../human-docs/index.md)
- Install → [../human-docs/installation/index.md](../human-docs/installation/index.md)
