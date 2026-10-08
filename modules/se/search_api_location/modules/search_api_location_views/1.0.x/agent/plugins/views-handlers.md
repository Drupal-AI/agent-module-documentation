<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views handlers

`search_api_location_views_views_data_alter(&$data)` loops over every Search API index and every
field with `getType() === 'location'`, then rewrites that field's entry in the index's Views
table (`search_api_index_<index_id>`).

## Handlers added (on the location field)
| Views handler | id | Purpose |
|---|---|---|
| filter | `search_api_location` | Exposed proximity filter (centre point + radius). |
| argument | `search_api_location_point` | Contextual filter to pass the search point. |

## Handlers added (on the `<field>__distance` pseudo-field)
| Views handler | id | Purpose |
|---|---|---|
| sort | `search_api_location_distance` | Order results by distance. |
| argument | `search_api_location_radius` | Contextual radius on the distance pseudo-field. |

The distance pseudo-field alias is `"<field_id>__distance"`. **It only exists if the backend
defines it** (e.g. Solr's `getBackendDefinedFields()`); the module appends `__distance` to the
field id as a best-effort alias. On backends that don't expose it (or a serverless/DB index),
the sort/radius-argument handlers are not attached. The module also `unset()`s the
pseudo-field's `filter` (the location field's filter covers it).

## Plugin classes
- `Plugin/views/filter/SearchApiFilterLocation.php` → `@ViewsFilter("search_api_location")`,
  injects `plugin.manager.search_api_location.location_input` and renders the chosen Location
  Input plugin's form as the exposed widget (value = `value` + `distance.from`/`.to`).
- `Plugin/views/argument/SearchApiLocationPoint.php` → `@ViewsArgument("search_api_location_point")`.
- `Plugin/views/argument/SearchApiLocationRadius.php` → `@ViewsArgument("search_api_location_radius")`.
- `Plugin/views/sort/SearchApiSortLocationDistance.php` → `@ViewsSort("search_api_location_distance")`.

## Using it
1. Give a Search API index a field of data type `location` (see the parent module).
2. Create a **Search API view** on that index.
3. Add the **filter** (the field appears with the proximity filter) — choose a Location Input
   plugin (raw / map / geocode) as the exposed widget and configure radius options.
4. Optionally add the distance **sort** (Solr) and/or the point/radius **contextual filters**.

Config schema: `views.filter.search_api_location` (keys: `plugin` = Location Input id, per-plugin
`plugin-raw`/`plugin-geocode`/`plugin-geocode_map` settings, `radius_type`, `radius_options`,
`radius_units`, and `value` = `{value, distance:{from,to}}`).
