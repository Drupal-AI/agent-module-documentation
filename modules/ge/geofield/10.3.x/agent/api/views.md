# Geofield Views integration (proximity & boundary)

Adds handlers to Views for location querying (see `geofield.views.inc`).

## Proximity (distance from an origin point)
- Filter: `GeofieldProximityFilter` — items within/beyond a distance; can expose distance +
  units in the exposed form.
- Sort: `GeofieldProximitySort` — order results by distance.
- Argument: `GeofieldProximityArgument` — distance via a contextual filter.
- Field: `GeofieldProximityField` — render the computed distance as a column.

The distance **origin** is provided by a **GeofieldProximitySource** plugin, chosen in the
handler settings. Bundled sources:
- `geofield_manual_origin` — a fixed lat/lon entered in config (default).
- `geofield_client_location_origin` — the visitor's browser location.
- `geofield_context_filter` — origin from a context.
- `geofield_origin_from_proximity_filter` — reuse another proximity filter's origin.

Unit of measure is selectable (`geofield_radius_options()` — km, miles, etc.).

## Rectangular boundary (bounding box)
- Filter: `GeofieldRectBoundaryFilter` — items whose geometry falls inside a map rectangle.
- Argument: `GeofieldRectBoundaryArgument` — boundary via a contextual filter.

Reusable traits: `GeofieldProximityHandlerTrait`, `GeofieldBoundaryHandlerTrait`. To add a
new origin mode, implement a proximity-source plugin — see
[plugins/plugins.md](../plugins/plugins.md).
