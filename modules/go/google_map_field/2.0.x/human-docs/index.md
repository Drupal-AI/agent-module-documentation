# Google Map Field — manual setup guide

**Google Map Field** (`google_map_field`) adds a field type that stores an
**interactive map** on each entity — its center point, zoom level, map type, a
marker, and an optional info-window bubble. Editors set the map visually (drag a
marker, choose the zoom and view), and the stored map is rendered on the entity's
display. It's a lightweight way to give each node, term, or other entity its own
map without pulling in a full geofield/GIS stack — perfect for store locators,
event venues, and directory listings.

Editors work with one of two **widgets**: a Google Maps picker
(`google_map_field_default`) or an OpenLayers picker (`olmap_field`) that needs no
API key to author with. The stored value is shown by one of three **formatters**:
an interactive Google map, a Google Maps Embed "place" iframe, or an OpenLayers
map. You can use different formatters on different view modes — a roadmap in the
full view, a satellite embed elsewhere — all from the same stored value.

The module has a small **global settings form** for your Google Maps API key,
which the Google-based widgets and formatters need to load map tiles. You can
supply either a standard **API Key** or a **Google Maps API for Work** client ID.
The OpenLayers widget and formatter work **without** any Google key, which is handy
for authoring or for sites that would rather not use a Google key at all. Google
Map Field depends on core's **Field** module, has no third-party Composer or PHP
requirements or submodules, and includes a Feeds target so map values can be
populated during imports.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — including the field storage
columns and setting values in code — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the global API key, then attach a
   map field and pick its widget and formatter.

## Where it lives in the admin menu

The global API-key settings form sits at **Configuration → Web services → Google
Map Field settings** (`/admin/config/services/gmap-field-settings`). The field
itself is added and configured on the usual *Manage fields*, *Manage form display*,
and *Manage display* screens of whatever entity you add it to.

## How to use it

First set your Google Maps API key on the settings form (unless you'll only use the
OpenLayers, no-key variants). Then add a **Google Map Field** to a bundle, choose a
widget so editors can place the map, and choose a formatter so the map renders on
the display. The step-by-step is in [Configuration](configuration/index.md).
