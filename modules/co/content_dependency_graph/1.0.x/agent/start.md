<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Dependency Graph (content_dependency_graph) — agent index

info.yml name: **Content Dependency Graph**, version **1.0.1** (version-dir 1.0.x).
Maintainer: Specbee. An admin visualization tool that renders a node and its
recursively-referenced entities (media, taxonomy terms, paragraphs, files, other nodes)
as an interactive force-directed graph. Read-only; no write/mutation endpoints, no config
form, no services, no Drush, no config schema.

- **Core:** `^10.3 || ^11`  **Depends:** `node`, `taxonomy`, `media` (core).
- **Permission:** `access content dependency graph` (defined in
  `content_dependency_graph.permissions.yml`) gates **both** routes.
- **Everything lives in one controller:** `src/Controller/GraphController.php`.

## Routes (`content_dependency_graph.routing.yml`)

- `content_dependency_graph.index` — `/admin/content/dependency-graph` →
  `GraphController::index`. Renders a `#type: table` of the 100 most recently `changed`
  nodes (columns: ID, Type, bundle label, Title, Published/Unpublished status, "View Graph"
  link). The node list is built with an entity query using `->accessCheck(TRUE)->sort('changed','DESC')->range(0,100)`.
  Also reachable via **Administration › Content › Dependency Graph** (menu link) — see
  `content_dependency_graph.links.menu.yml`.
- `content_dependency_graph.graph` — `/admin/content/dependency-graph/{node}` →
  `GraphController::view`. `{node}` is auto-upcast to a `NodeInterface`. Builds the graph
  data and hands it to the theme. Also exposed as a **Dependency Graph** local task tab on
  every node canonical page (`base_route: entity.node.canonical`, see
  `content_dependency_graph.links.task.yml`).

## How the graph is built (`GraphController::view` → `buildGraph` → `traverseEntity`)

- `traverseEntity()` recursively walks the entity graph starting at the root node. For each
  entity it records `{id: "<type>-<id>", label, group: entityTypeId, bundle, entityId,
  status, url (canonical if a link template exists), title}` and, for each outgoing
  reference, an edge `{from, to, label: field_name}`. A `$visited` set prevents cycles.
- It only follows fields of type `entity_reference` / `entity_reference_revisions`.
- **`IGNORED_FIELDS`** (never traversed): `type`, `uid`, `revision_uid`, `revision_user`,
  `roles`, `langcode`, `menu_link`, `moderation_state`, `comment`.
- **`IGNORED_ENTITY_TYPES`** (referenced targets skipped): `user`, `user_role`, `node_type`,
  `comment_type`, `workflow`, `moderation_state`.
- Views, menus, and config dependencies are **not** represented (only stored entity-reference
  fields are followed).
- The full `{nodes, edges}` array plus `rootId`, `entityDetails`, and the root's direct
  `relationships` is passed to the client via
  `#attached['drupalSettings']['contentDependencyGraph']` (JSON-encoded by Drupal).

## Front end

- Theme hook `content_dependency_graph` (`content_dependency_graph.module` →
  `hook_theme`), template `templates/content-dependency-graph.html.twig`: header card,
  toolbar (zoom in/out, fit, fullscreen), entity-type filter `<select>`, `#dependency-graph`
  mount point, legend, and a right sidebar (Entity Details + Relationships + "View This
  Entity" link). Twig auto-escapes the `node_*` variables.
- `js/graph.js` (`Drupal.behaviors.contentDependencyGraph`) renders the graph with
  **vis-network**, builds per-type circular SVG icon nodes, wires the toolbar/filter, and
  populates the sidebar on node click. Sidebar HTML strings are built with an internal
  `escapeHtml()` helper; vis-network labels are canvas text.
- **Library** (`content_dependency_graph.libraries.yml`, library `graph`): loads
  `js/graph.js`, `css/graph.css`, and vis-network from an **external CDN URL**
  (`https://unpkg.com/vis-network/standalone/umd/vis-network.min.js`, `type: external`) — the
  library is **not** bundled with the module and the URL is unversioned/no SRI.

## Color coding (authoritative source: template legend + `BG_COLORS` in `js/graph.js`)

Node `#4a90d9` (blue) · Paragraph `#27ae60` (green) · Media `#8e44ad` (purple) ·
Taxonomy term `#e67e22` (orange) · File `#e74c3c` (red) · Other/default `#95a5a6` (grey).
(The project README's color table mislabels several of these — trust the legend/JS above.)

## Notes for editing docs

- No config directory / no settings form; `configure` is null.
- Sibling human guide: `../human-docs/index.md` and `../human-docs/installation/index.md`.
- Usage one-liners: `../usage.md`.
