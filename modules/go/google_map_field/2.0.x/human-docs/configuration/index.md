# Configuration

Configuring Google Map Field is two jobs: set the global Google Maps API key once,
then attach a map field to whichever entities need one and choose its widget and
formatter.

## Set the global API key

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default) — the module adds no permission of its own.
2. Go to **Configuration → Web services → Google Map Field settings**, or navigate
   directly to `/admin/config/services/gmap-field-settings`.

The form lets you choose an **authentication method** and enter the matching
credential:

- **API Key** — the standard choice. Paste your Google Maps JavaScript API key into
  the **API key** field.
- **Google Maps API for Work** — for organizations using a client ID instead. Enter
  the **client ID** in that field.

The Google-based widget and formatters need a valid key here to load map tiles. If
you only ever use the **OpenLayers** widget (`olmap_field`) and formatter
(*OpenLayers map*), you can skip this — they render without a Google key.

Click **Save configuration** when done.

## Attach a map field to a bundle

1. Go to the **Manage fields** screen of the entity/bundle you want a map on (for
   example **Structure → Content types → Location → Manage fields → Add field**).
2. Choose **Google Map Field** as the field type and give it a label (such as
   "Map").

## Choose the widget (Manage form display)

On the bundle's **Manage form display** screen, pick how editors set the map:

- **Google Maps picker** (`google_map_field_default`) — an interactive Google map
  where the editor drags the marker and sets the zoom and map type. Needs the API
  key.
- **OpenLayers picker** (`olmap_field`) — the same job using OpenLayers, so editors
  can place coordinates **without** a Google key.

Either way the editor sets the map's center, zoom, map type, marker, optional
custom marker icon, traffic layer, controls, and an info-window message, plus the
rendered width and height.

## Choose the formatter (Manage display)

On the bundle's **Manage display** screen, pick how the stored map renders:

- **Interactive Google map** (`google_map_field_default`) — the default; a live,
  pannable Google map. Needs the API key.
- **Google Maps Embed** (`google_map_field_embed`) — a Google Maps Embed "place"
  iframe.
- **OpenLayers map** (`google_map_field_open_layers`) — an OpenLayers map, no
  Google key required.

Because the formatter is set per view mode, you can show the same stored map
differently in different displays — for example an interactive map in the full view
and a simple embed in a teaser.

## Multi-value maps and imports

The field supports multiple values, so a single entity can carry several maps. The
module also provides a Feeds target, letting map fields be populated during a Feeds
import.
