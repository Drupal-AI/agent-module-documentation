# Configuration

Most of Leaflet More Maps needs no configuration at all — the extra styles appear
in Leaflet's map-style dropdowns the moment you enable the module. You only visit
the settings form to (a) enter API keys for the providers that require them, or
(b) assemble a custom combined map.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Leaflet More Maps**, or navigate directly to
   `/admin/config/system/leaflet-more-maps`.

## Provider API keys

Several map providers need a key or token before their tiles will load. Enter the
ones you need; leave the rest blank.

| Field | Which styles it unlocks | What happens without it |
|-------|-------------------------|-------------------------|
| **Thunderforest API key** | The nine Thunderforest / OSM styles (Cycle, Transport, Landscape, Outdoors, Transport Dark, Spinal Map, Pioneer, Mobile Atlas, Neighbourhood) | Tiles still load but carry a "missing API key" watermark |
| **HERE API key** | HERE Base map | The map shows nothing (blank tiles) |
| **Mapbox access token** | The four Mapbox styles (Dark, Light, Satellite-Streets, Streets) | Falls back to a bundled public demo token — fine for trying it out, but use your own for production |
| **Mapy.cz API key** | The four Mapy.cz styles (Basic, Outdoor, Winter, Aerial) | Tiles won't load |
| **Navionics API key** + **authorized domain** | Navionics nautical, sonar, and ski layers | Both are required; without them the map is blank |

A note on the **Stamen** styles (Toner, Terrain, Watercolor, etc.): these use
domain-based authentication rather than a key, so there's no field for them here.
Instead you register your site's domain (for example `*.ddev.site` for a DDEV site)
directly with Stadia Maps.

Click **Save configuration**, then clear caches (`drush cr`) so the updated tile
URLs take effect.

## Custom maps

The form also has three **Custom map** sections, each letting you combine several
layers from the built-in catalogue into a single map with an automatic layer
switcher — no code needed. For each custom map:

- **Map key / name** — the label shown in the map-style dropdown.
- **Layers** — a set of checkboxes, one per layer across every built-in map. Tick
  the layers you want to include (for example an Esri World Imagery base layer plus
  an OSM label overlay).
- **Reverse order** — flips the layer switcher order, which changes which layer is
  shown by default.

Leave a custom map's name blank (or tick no layers) and that slot is cleared on
save. A custom map with more than one layer automatically gets a layer-switcher
control on the map.

Use custom maps to offer editors a curated short list of styles instead of the
whole 40-plus catalogue, or to overlay labels onto imagery.

## Using a style on a map

Once styles are available (and any keys entered), choose one wherever Leaflet
offers a map-style dropdown:

- On a Geofield's **Manage display** tab, set the field's format to a Leaflet map
  and pick your style from the **map** dropdown.
- In a View using the **Leaflet** display/style, pick the style in the style
  settings.

## Remember to clear caches

Leaflet caches its combined list of map styles. After any change on this settings
form — a new key, a new custom map — run `drush cr` (or clear caches from
**Configuration → Development → Performance**) before the change shows up in the
dropdowns and on rendered maps.
