# Configuration

Geofield has **no central settings form**. You configure it per field, in three
places on the entity bundle you're adding it to: the field itself, the **form
display** (how editors enter data), and the **view display** (how the value
renders). This page walks through each.

## 1. Add a Geofield to a content type

1. Log in as a user who can administer fields (an administrator by default).
2. Go to **Structure → Content types → *(your type)* → Manage fields**
   (`/admin/structure/types/manage/<bundle>/fields`). Fields also exist on users,
   taxonomy terms, and other entity types — the steps are the same.
3. Click **Add field** and choose the **Geofield** field type.
4. Give it a label (e.g. "Location") and save.

Behind the scenes each Geofield stores nine columns derived from the geometry:
the WKT `value`, `geo_type`, centroid `lat`/`lon`, bounding box
`top`/`bottom`/`left`/`right`, and `geohash` — plus a computed `latlon` pair.
You don't manage these directly; they're populated for you.

## 2. Choose the storage backend (field storage setting)

On the field's **storage settings** you can pick which **backend** stores the
geometry:

- **`geofield_backend_default`** *(default)* — stores geometry as WKB. This is the
  right choice for almost every site.
- **`geofield_backend_postgis`** — stores geometry in a PostGIS column, for sites
  running PostgreSQL with PostGIS that want native spatial storage.

## 3. Pick how editors enter data (Manage form display)

Under **Manage form display** for the bundle, choose one of Geofield's widgets for
your field:

- **Raw WKT** (`geofield_default`) — a textarea for typing or pasting Well-Known
  Text geometry directly. Its **geometry validation** option turns on validation
  of what's entered.
- **Latitude/Longitude** (`geofield_latlon`) — a simple pair of numeric inputs.
  Its **HTML5 geolocation** option lets the widget pre-fill from the visitor's
  browser location.
- **Degrees/Minutes/Seconds** (`geofield_dms`) — inputs for coordinates in DMS
  format.
- **Bounding box** (`geofield_bounds`) — four inputs (top/right/bottom/left) that
  store a rectangular area as the value.

For an interactive map-based widget (click or drag a point on a map), install a
contrib module such as Geofield Map or Leaflet and choose its widget here instead.

## 4. Pick how the value renders (Manage display)

Under **Manage display** for each view mode, choose a formatter:

- **Geometry** (`geofield_default`) — outputs the stored geometry. Its **output
  format** setting controls the representation (for example `wkt` or `json`), and
  **output escape** controls whether the output is escaped.
- **Latitude/Longitude** (`geofield_latlon`) — outputs the centroid as a lat/lon
  pair, with the same **output format** and **output escape** settings.

Both built-in formatters render **text**. To display an actual map, choose a
formatter provided by a mapping contrib module instead.

## Proximity and boundary searches in Views

Geofield's real power in listings comes through Views. When you build a View of
entities that have a Geofield, you gain proximity handlers — **distance**
filters, sorts, arguments, and fields (for "within X km/miles of a point" and
"sort by distance") — plus rectangular **boundary** filters and arguments. The
origin point those queries measure from is supplied by a pluggable proximity
source: a manually entered origin, the visitor's browser location, context, or
another exposed filter. You can also expose a distance-unit selector on a
proximity filter and show a computed distance column in the results.

## Where settings are stored

There is no exported "geofield settings" object — field storage settings live with
the field, and widget/formatter settings live in the entity form and view display
config, so they export and deploy like any other field configuration. The config
schema lives in `config/schema/geofield.schema.yml`.
