# Configuration

Leaflet Layers has no single settings form. Instead you work with two configuration
entities under **Structure → Leaflet Layers** (`/admin/structure/leaflet_layers`):
**Map layers** (individual custom layers) and **Map bundles** (ordered groups of
layers that become selectable maps). Both are gated by the **Administer site
configuration** permission.

## Map layers — define a single custom layer

Go to **Structure → Leaflet Layers → Map layer** and click **Add** to create a
custom tile or WMS layer. Each Map layer has:

- **Label** and **Description** — a name and optional note for the layer.
- **Layer type** — whether this layer is a **base** layer (a background map) or an
  **overlay** (drawn on top).
- **Plugin type** — pick **Tile layer** for a standard XYZ tile source, or **WMS**
  for a WMS service. This choice determines which settings fields appear.

### Tile layer settings

- **URL template** — the tile URL, including the `{x}`, `{y}`, and `{z}`
  placeholders (for example `https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png`).
- **Attribution** — the attribution HTML a tile provider requires you to display.
- **Min zoom / Max zoom / Zoom offset** — the layer's zoom range and offset.
- **Opacity** — how transparent the layer is drawn.
- **Subdomains** — a list such as `mt1,mt2,mt3` to spread tile requests across
  hosts.
- **Error tile URL**, **TMS**, **Zoom reverse**, **Detect retina** — additional
  Leaflet TileLayer options for TMS tiling, reversed zoom numbering, and high‑DPI
  displays.

### WMS settings

A WMS layer adds the tile‑layer fields (with the URL relabeled "WMS Url") plus:

- **Layers** — the WMS layer names to request.
- **Styles**, **Format** (default `image/jpeg`), **Transparent**, **Version**
  (default `1.1.1`), and **Uppercase** — standard WMS request parameters.

Each Map layer is stored as `leaflet_layers.map_layer.<id>`.

## Map bundles — group layers into a selectable map

Go to **Structure → Leaflet Layers → Map bundle** and click **Add**. A Map bundle
lists **every** layer available on the site — those provided by other Leaflet
modules *and* all of your custom Map layers — split into two drag‑and‑drop tables:
**Base layers** and **Overlay layers**. For each row you can set:

- **Custom label** — the name shown in Leaflet's layer‑switcher control.
- **Enabled** — whether this layer is included in the bundle (unchecked rows are
  dropped when you save).
- **On by default** — for overlays, whether the overlay is toggled on when the map
  first loads.
- **Weight** — drag to reorder; base layers are always emitted before overlays.

Below the layer tables, the bundle carries a set of **map behavior toggles** (all on
by default) that control how the Leaflet map behaves:

- **dragging**, **touchZoom**, **scrollWheelZoom**, **doubleClickZoom** — panning
  and the various zoom interactions.
- **zoomControl**, **attributionControl**, **layerControl** — whether the zoom
  buttons, the attribution box, and the layer switcher are shown.
- **trackResize**, **fadeAnimation**, **zoomAnimation**, **closePopupOnClick** —
  resize tracking, animations, and popup behavior.

Each bundle is stored as `leaflet_layers.map_bundle.<id>`.

## Using a bundle on a map

Saving a Map layer or Map bundle refreshes Leaflet's list of available maps. Every
saved bundle then appears as a selectable **map** wherever the Leaflet module offers
one — on a Geofield/Leaflet field formatter or a Views Leaflet display. Just choose
your bundle as the map, and its layers and behavior toggles are applied.

## Managing configuration in code

Because both are configuration entities, you can export and deploy them as
`leaflet_layers.map_layer.*` and `leaflet_layers.map_bundle.*` config, or create
them programmatically — for example a custom OSM tile layer:

```php
\Drupal::entityTypeManager()->getStorage('map_layer')->create([
  'id' => 'osm_custom', 'label' => 'OSM Custom',
  'settings' => [
    'plugin_type' => 'tilelayer', 'layer_type' => 'base',
    'urlTemplate' => 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
    'attribution' => '© OpenStreetMap', 'minZoom' => 0, 'maxZoom' => 19, 'opacity' => 1,
  ],
])->save();
```
