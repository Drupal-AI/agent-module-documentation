<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OpenStreetMap Query Tools (openstreetmap_queries) — agent index

Submodule of **openstreetmap**. Adds the **`osm_query`** content entity: a saved Overpass query
(title + Overpass QL body + enabled flag + target OSM Node Type) that can be executed to
batch-import/upsert OSM Nodes, or tested to count results. Also hooks the parent's "Sync All" so
every saved query is re-run. Depends on **`openstreetmap`**. Core `^8.7.7 || ^9 || ^10`. License
GPL-2.0-or-later. Version dir `1.x` (installed 1.0.4). All external HTTP is delegated to the
parent's `overpass` service. **No config schema ships.**

- **The `osm_query` entity, its fields, execute/test flow, routes & permissions** →
  [entities/osm_query.md](entities/osm_query.md)

## What it actually is (from source)

- **Entity** `osm_query` (`src/Entity/OSMQuery.php`, `@ContentEntityType`): base_table `osm_query`,
  `admin_permission = administer openstreetmap queries`, label = `title`, route provider
  `AdminHtmlRouteProvider`, access `OSMQueryAccessControlHandler`, list `OSMQueryListBuilder`,
  view builder `OSMQueryViewBuilder`, `field_ui_base_route = entity.osm_query.settings`.
  Base fields: `title` (string, required), `status` (boolean, default enabled), `code`
  (text_long, the Overpass QL, `no_filter` format), `bundle` (list_string, allowed values from
  `openstreetmap_query_bundle_option_callback` = the OSM Node types), `created`, `changed`.
- **`OSMQuery::execute()`** → `\Drupal::service('overpass')->nodesFromQuery($code, $bundle)` inside
  try/catch (errors go to messenger). Delegates the HTTP + batch to the parent service.
- **Forms**: `OSMQueryForm` (add/edit content-entity form), core `ContentEntityDeleteForm`,
  `OSMQueryExecuteForm` (route `entity.osm_query.execute`), `OSMQuerySettingsForm`
  (route `entity.osm_query.settings`, a near-empty placeholder settings form).

## Routes & permissions

- Entity CRUD routes from `AdminHtmlRouteProvider` under `/admin/structure/osm_query`, access via
  `OSMQueryAccessControlHandler` (view/create/update/delete each map to the matching permission
  OR `administer openstreetmap queries`).
- `entity.osm_query.settings` (`/admin/structure/osm_query/settings`) →
  `_permission: administer openstreetmap queries` (restricted).
- `entity.osm_query.execute` (`/admin/structure/osm_query/{osm_query}/execute`) →
  `_permission: edit openstreetmap queries`.
- Permissions (`openstreetmap_queries.permissions.yml`): `administer openstreetmap queries`
  (restricted), `access openstreetmap queries overview`, `create/view/edit/delete openstreetmap
  queries`.

## Hooks (`openstreetmap_queries.module`)

- `hook_openstreetmap_sync` → runs `execute()` on every saved query (so parent Sync All refreshes
  them).
- `hook_openstreetmap_sync_batch_alter` → **clears** the parent's per-node batch ops (query
  execution replaces them).
- `hook_form_openstreetmap_sync_form_alter` → adds a query count + warning to the Sync form.
- `openstreetmap_query_bundle_option_callback()` → allowed-values callback listing OSM Node types.
