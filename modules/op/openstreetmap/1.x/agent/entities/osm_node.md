<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `osm_node` entity — bundles, tag→field mapping, sync & import

## What it is

`Drupal\openstreetmap\Entity\OSMNode` (`@ContentEntityType id = "osm_node"`), a **revisionable,
translatable** content entity keyed by an OpenStreetMap element:

- `base_table osm_node`, `data_table osm_node_field_data`, `revision_table osm_node_revision`.
- `bundle = type`; bundle config entity **`osm_node_type`** (`src/Entity/OSMNodeType.php`,
  add at `/admin/structure/osm_node_type`). `field_ui_base_route = entity.osm_node_type.edit_form`
  so bundles are fieldable via Field UI.
- `admin_permission = administer osm_node entities`, `permission_granularity = bundle`.
- Handlers: storage `OSMNodeStorage`, access `OSMNodeAccessControlHandler`, list `OSMNodeListBuilder`,
  translation `OSMNodeTranslationHandler`, route provider `OSMNodeHtmlRouteProvider`,
  views data `OSMNodeViewsData`.

### Base fields (`OSMNode::baseFieldDefinitions()`)

| Field | Type | Notes |
|---|---|---|
| `osm_id` | string | Required, `UniqueField` constraint, the OSM element ID. |
| `way` | boolean | "Is Way" — true = the ID is a way (polygon), false = a single node. |
| `name` | string(50) | Entity label; the only core field tags may overwrite. |
| `geodata` | geofield | WKT geometry, set from OSM on save (point or polygon). |
| `osm_edit_link` | link (computed) | `OSMEditLink` → `https://www.openstreetmap.org/edit?…`. |
| `osm_view_link` | link (computed) | `OSMViewLink` → `https://www.openstreetmap.org/<type>/<id>`. |
| `status`, `user_id`, `created`, `changed`, `revision_log` | core | `revision_log` added by `openstreetmap_update_8001`. |

`toUrl()` is overridden to expose external `osm.edit` / `osm.view` URLs (target=_blank) and an
`osm.sync` route link.

## Sync / fetch mechanics (from source)

`OSMNode::save($pull_from_osm = TRUE)` (note the **non-standard signature** — saving pulls from OSM
by default):

1. If `way`, calls `overpass->way(osm_id)` and builds a **polygon** WKT via
   `geofield.wkt_generator->wktBuildPolygon()` from the geometry; else `overpass->node(osm_id)` and
   `wktBuildPoint([lon, lat])`.
2. Sets `geodata`, then `setFieldsFromTags($data->tags)`.
3. `parent::save()`.

`setFieldsFromTags($tags)`: for each OSM tag `key => value`, if the entity `hasField($key)` and
`$key` is not a core base field (except `name`), sets it; else if `hasField("field_$key")`, sets
that. Changing a value calls `setNewRevision()`. **So you mirror an OSM tag by naming a field after
the tag key** (with or without `field_` prefix). Add fields on the bundle via Field UI.

`hook_osm_node_presave_alter` (in `openstreetmap.module`) additionally maps `addr:*` tags onto the
first **core Address field** on the bundle (`addr:city → locality`, `addr:country → country_code`,
`addr:housenumber`+`addr:street → address_line1`, `addr:postcode → postal_code`,
`addr:state → administrative_area`).

Static batch helpers: `fromElement()` (upsert by looking up existing `osm_id` via a **parameterized**
`SELECT … WHERE osm_id = :osm_id`), `saveFromElement()`, `saveFromNodeId()`, `saveFromWayId()`,
`saveInPlace($id)` (load + `save()` — used by Sync All).

## Ways to get data in

- **Single node UI**: OSM Node List (`/admin/content/osm_node`) → *Add OSM Node* → enter `osm_id`,
  tick *Is way* for ways → save → tags/geometry fetched.
- **Ad-hoc Overpass import** (`OSMImportForm`, route `osm.import`, `/admin/content/osm_node/import`,
  perm `administer osm_node`): paste an Overpass query, pick a target bundle. *Import* runs
  `overpass->nodesFromQuery()` (batch upsert); *Run Query* just dumps the raw response. The form
  auto-prepends `[out:json];` and appends `out geom;` if missing.
- **Sync All** (`OSMSyncForm`, route `entity.osm_node.sync_all`, `/admin/content/osm_node/sync`,
  perm `edit osm_node entities`): batches `OSMNode::saveInPlace()` over every node, invokes
  `hook_openstreetmap_sync` and `hook_openstreetmap_sync_batch_alter`. With the queries submodule
  installed, Sync All instead runs the saved queries (the submodule empties the node batch and
  hooks in query execution).
- **Per-node sync** (`OSMNodeController::sync()`, route `entity.osm_node.sync`,
  `/admin/content/osm_node/{osm_node}/sync`, perm `edit osm_node entities`): re-fetches one node.
- **OSM Data tab** (`OSMNodeController::osmData()`, route `entity.osm_node.osm_data`): shows the raw
  OSM payload and view/edit-on-OSM links.

## Permissions (`openstreetmap.permissions.yml` + `OSMNodeTypePermissions`)

`add osm_node entities`, `edit osm_node entities`, `delete osm_node entities`,
`view published osm_node entities`, `view unpublished osm_node entities`,
`view all osm_node revisions`, `revert all osm_node revisions`, `delete all osm_node revisions`,
`administer osm_node entities` (restricted). `OSMNodeTypePermissions::generatePermissions` adds the
per-bundle variants. Route access as summarized in [../start.md](../start.md).

## Display on a map

The module stores geometry but renders no map. Enable **Leaflet** (+ Leaflet Views), build a View of
`osm_node`, add the `geodata` Geofield, and configure the Leaflet view type to read it — see the
project README FAQ. The `openstreetmap_views` submodule only declares the Leaflet dependency.
