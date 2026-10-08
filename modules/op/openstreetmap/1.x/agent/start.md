<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OpenStreetMap (openstreetmap) — agent index

Provides a revisionable/translatable content entity **`osm_node`** that mirrors an OpenStreetMap
node or way, fetched on save from a configured **Overpass API** interpreter. Stores the element's
`name`, geometry as WKT in a **Geofield** (`geodata`), and any OSM tag matching a bundle field.
Package: none declared. Depends on **`geofield`**. Core `^8.7.7 || ^9 || ^10 || ^11`. License
GPL-2.0-or-later. Version dir `1.x` (installed 1.0.4). Ships **no map renderer** of its own —
display the Geofield with Leaflet/Views. It does provide two submodules (documented separately):
`openstreetmap_queries` (saved Overpass queries) and `openstreetmap_views` (a dependency shim
pulling in Leaflet).

- **OSM Settings + the Overpass endpoint config** → [config/settings.md](config/settings.md)
- **The `osm_node` entity, bundles, tag→field mapping, sync/import flows, permissions** →
  [entities/osm_node.md](entities/osm_node.md)
- **The `overpass` service (external HTTP to the interpreter)** → [api/overpass.md](api/overpass.md)

## What it actually is (from source)

- **Entity** `osm_node` (`src/Entity/OSMNode.php`, `@ContentEntityType`): base_table `osm_node`,
  revisionable, translatable, `bundle = type` (bundle entity `osm_node_type`,
  `src/Entity/OSMNodeType.php`), label = `name`, `admin_permission = administer osm_node entities`,
  `permission_granularity = bundle`. Base fields: `osm_id` (string, unique, required),
  `way` (boolean "Is Way"), `name`, `geodata` (geofield), computed link fields `osm_edit_link` /
  `osm_view_link`, `status`, `user_id`, `created`, `changed`, `revision_log` (added by
  `openstreetmap_update_8001`).
- **Service** `overpass` (`Drupal\openstreetmap\Overpass`, `openstreetmap.services.yml`): wraps
  Guzzle GET to `openstreetmap.settings:endpoint` with the Overpass query as `data`.
- **Config form** `OSMSettingsForm` at route `osm.settings` (`/admin/config/osm`), one field
  `endpoint`, config object `openstreetmap.settings`. **No config schema ships.**
- **Forms** `OSMImportForm` (`osm.import`, `/admin/content/osm_node/import`) and `OSMSyncForm`
  (`entity.osm_node.sync_all`, `/admin/content/osm_node/sync`).
- **Controller** `OSMNodeController` (`src/Controller/`): `sync()`, `osmData()`, plus revision
  overview/show. `OSMNodeViewController` renders the canonical page.

## Routes & permissions

- `osm.settings`, `osm.import` → `_permission: administer osm_node`.
- `entity.osm_node.sync`, `entity.osm_node.sync_all`, `entity.osm_node.osm_data` →
  `_permission: edit osm_node entities`.
- Entity CRUD routes provided by `OSMNodeHtmlRouteProvider`; access via
  `OSMNodeAccessControlHandler`. Permissions in `openstreetmap.permissions.yml` plus per-bundle
  permissions from `OSMNodeTypePermissions::generatePermissions`
  (`add/edit/delete/view … osm_node entities`, revision perms, `administer osm_node entities`).

## Hooks

- Provides: `hook_openstreetmap_sync` (invoked after sync-all), `hook_openstreetmap_sync_batch_alter`
  (alter the sync batch). Implements `hook_osm_node_presave_alter` itself to map `addr:*` OSM tags
  onto a core Address field. `hook_theme` registers the `osm_node` template.

## Data flow (grounded)

OSM ID entered/imported → `overpass` service GETs the interpreter → `OSMNode::setFieldsFromTags()`
copies each tag onto a matching field (`$key` or `field_$key`, never onto core base fields except
`name`) → geometry converted to WKT via `geofield.wkt_generator` → entity saved (new revision when
values change). Bulk paths use `OSMNode::saveFromElement()` in a Drupal batch.
