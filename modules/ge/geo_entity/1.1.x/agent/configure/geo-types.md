# Configuring geo types (bundles) & admin surface

## Admin routes

| Route | Path | Purpose |
|---|---|---|
| `entity.geo_entity_type.collection` | `/admin/structure/geo_types` | List/manage geo types (the `configure` route) |
| `entity.geo_entity_type.add_form` | `/admin/structure/geo_types/add` | Add a geo type |
| `entity.geo_entity_type.edit_form` | `/admin/structure/geo_types/manage/{geo_entity_type}` | Edit a type; Field UI base route |
| `entity.geo_entity.collection` | `/admin/content/geo` | List geo entities |
| `entity.geo_entity.add_page` / `add_form` | `/admin/content/geo/add[/{type}]` | Create a geo |
| `entity.geo_entity.canonical` | `/admin/content/geo/{geo_entity}` | View a geo |

Menu link: *Structure › Geo types*. Action links add geo types and geos.

## The `geo_entity_type` config entity

Config prefix `geo_entity_type`; config entity id `geo_entity.geo_entity_type.<id>`. Exported keys
(schema `geo_entity.geo_entity_type.*` in `config/schema/geo_entity.entity_type.schema.yml`):

- `id` — machine name (bundle id).
- `label` — human name.
- `uuid`.
- `label_token` — a Token template string used to build each entity's `label`.

The type form (`GeoEntityTypeForm`) exposes exactly three inputs: **Bundle label**, machine **id**, and
**Default entity label** (`label_token`, a token textfield validated with `token_element_validate`,
`#token_types => ['geo_entity']`, plus a `token_tree_link`). `admin_permission` for the bundle entity is
`administer geo types`.

### How `label_token` works

On every save, `GeoEntity::preSave()` reads the bundle's `labelToken()`; if non-empty it runs
`\Drupal::token()->replace($template, ['geo_entity' => $this])`, strips HTML with
`PlainTextOutput::renderFromHtml()`, and stores the result as the entity `label`. So the `label` base
field is effectively auto-managed for bundles that set a token (its form widget is placed in the `hidden`
region). Example token: `[geo_entity:postal_address:locality], [geo_entity:postal_address:country_code]`.

Create a bundle with drush:

```php
\Drupal::entityTypeManager()->getStorage('geo_entity_type')->create([
  'id' => 'venue',
  'label' => 'Venue',
  'label_token' => '[geo_entity:field_name]',
])->save();
```

## Bundle field/display setup

Fields, form display and view display are configured through the normal Field UI on the type edit form
(`field_ui_base_route` = `entity.geo_entity_type.edit_form`). View modes `full`, `embed` and form mode
`inline` ship in the base module's `config/install`. The concrete `address` and `area` bundles (with their
`location` geofield, `postal_address`, `geo_file`, `external_id`, `accessibility` fields and displays) are
installed by the **geo_entity_address** and **geo_entity_area** submodules — not by the base module.

## Entity Browser reuse library

`config/install/entity_browser.browser.geo_entity_library.yml` + `views.view.geo_entity_library` provide a
searchable picker of existing geos. Use it on a reference field by choosing the
`entity_browser_entity_reference` widget with entity browser `geo_entity_library`; the module then attaches
the `geo_entity/geobrowser` library and, via `hook_form_..._alter`, hides the address/area selector tabs for
bundles the field does not target (`target_bundles`). This lets editors reuse one stored location across many
host entities.

## Preconfigured providers

Ships pointed at OpenStreetMap tiles (Leaflet) and the OSM/Nominatim geocoder backend; both are ordinary
Leaflet/Geocoder config and can be swapped for commercial providers at
`/admin/config/system/geocoder/geocoder-provider`.
