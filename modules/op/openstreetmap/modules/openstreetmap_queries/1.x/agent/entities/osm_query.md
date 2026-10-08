<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `osm_query` entity — saved Overpass queries

## Install & enable

```bash
drush en openstreetmap_queries -y   # requires openstreetmap enabled first
```

Depends only on the parent **`openstreetmap`**. Uses the parent's `overpass` service and its
admin-configured interpreter endpoint (`openstreetmap.settings:endpoint`).

## The entity

`Drupal\openstreetmap_queries\Entity\OSMQuery` (`@ContentEntityType id = "osm_query"`,
`src/Entity/OSMQuery.php`):

- `base_table osm_query`, label = `title`, `admin_permission = administer openstreetmap queries`.
- Handlers: view builder `OSMQueryViewBuilder` (strips `#theme`, no entity template), list builder
  `OSMQueryListBuilder`, access `OSMQueryAccessControlHandler`, views data core
  `EntityViewsData`, route provider core `AdminHtmlRouteProvider`, forms `OSMQueryForm`
  (add/edit) + core `ContentEntityDeleteForm`.
- Links under `/admin/structure/osm_query` (`collection`, `add-form`, `canonical`, `edit-form`,
  `delete-form`). `field_ui_base_route = entity.osm_query.settings`.

### Base fields (`OSMQuery::baseFieldDefinitions()`)

| Field | Type | Notes |
|---|---|---|
| `title` | string(255) | Required, the entity label. |
| `status` | boolean | Default TRUE ("Enabled"); Sync All only re-runs enabled queries logic via `execute()` on all loaded queries. |
| `code` | text_long | The Overpass QL body; form widget uses the `no_filter` format. |
| `bundle` | list_string | Required; allowed values from `openstreetmap_query_bundle_option_callback` (the `osm_node_type` bundles). Target bundle for imported nodes. |
| `created`, `changed` | created/changed | Timestamps shown in the list builder. |

## Execute vs Test (`OSMQueryExecuteForm`)

Route `entity.osm_query.execute` (`/admin/structure/osm_query/{osm_query}/execute`, perm
`edit openstreetmap queries`). The form shows the stored `code` and two submit buttons:

- **Execute** → `OSMQuery::execute()` → `overpass->nodesFromQuery($code, $bundle)` — decodes the
  Overpass response and sets a Drupal **batch** that upserts an `osm_node` per element into the
  query's bundle (`OSMNode::saveFromElement`). Errors are caught and shown via messenger.
- **Test** → `overpass->query($code)` then reports `count(json_decode($json)->elements)` — a dry-run
  count, no import.

## Sync integration (`openstreetmap_queries.module`)

- `hook_openstreetmap_sync()` loads all `osm_query` entities and calls `execute()` on each, so the
  parent's **Sync All** (`/admin/content/osm_node/sync`) refreshes everything the queries track.
- `hook_openstreetmap_sync_batch_alter()` empties the parent's per-node batch operations, letting
  query execution replace them.
- `hook_form_openstreetmap_sync_form_alter()` adds "There are currently N queries tracking OSM
  data." plus a slowness warning to the Sync form.

## Access & permissions

`OSMQueryAccessControlHandler::checkAccess()` maps: `view` → `view openstreetmap queries`;
`update` → `edit openstreetmap queries` OR `administer openstreetmap queries`; `delete` →
`delete openstreetmap queries` OR `administer …`; create → `create openstreetmap queries` OR
`administer …`. Permissions declared in `openstreetmap_queries.permissions.yml`
(`administer openstreetmap queries` is `restrict access: true`). The settings route
`entity.osm_query.settings` requires `administer openstreetmap queries`; `OSMQuerySettingsForm`
is a placeholder (no stored config, no schema).

## Operating it

1. Configure the parent's Overpass endpoint (OSM Settings) and create at least one OSM Node Type.
2. *Structure → Overpass Queries → Add Query*: set title, paste Overpass QL, pick the target bundle,
   save.
3. Open the query's **Execute** tab; **Test** to count, **Execute** to import.
4. Re-run everything later with the parent's **Sync All**.
