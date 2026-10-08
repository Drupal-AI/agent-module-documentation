# Views plugins

Leaflet Views registers three Views plugins (implementations of core Views plugin types):

| Plugin | Type | id | Role |
|---|---|---|---|
| `LeafletMap` | ViewsStyle | `leaflet_map` | Renders the whole result set as one Leaflet map. Style settings pick the map definition, height/zoom, the Geofield/data source, marker icon and popup source. |
| `LeafletMarker` | ViewsRow | `leaflet_marker` | Turns each result row into a map feature — choose the Geofield, popup content (rendered entity/view mode or fields), and per-row icon. |
| `LeafletAttachment` | ViewsDisplay | `leaflet_attachment` | An attachment display so a map can be attached to another display. |

## Build a map view
1. Create a View of entities that have a **Geofield**.
2. Set **Format → Show: Leaflet Map** (`leaflet_map` style) and configure its settings
   (map, Geofield/data field, height, popup).
3. Use the **Leaflet Marker** row plugin to define each marker's popup/icon.
4. Add exposed/contextual filters, sorts, pager as usual.

**AJAX popups:** popup content can be loaded lazily via route `leaflet_views.ajax_popup`
(`/leaflet-ajax-popup/{entity_type}/{entity}/{view_mode}/{langcode}`, handled by
`LeafletAjaxPopupController`) so markers don't render all popup HTML upfront. Config schema:
`config/schema/leaflet_views.style.schema.yml`.
