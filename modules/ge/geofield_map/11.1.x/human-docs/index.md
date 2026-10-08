# Geofield Map — manual setup guide

**Geofield Map** (`geofield_map`) turns a Geofield field into an interactive
map, for both entering locations and displaying them. It builds on the
[Geofield](https://www.drupal.org/project/geofield) module and gives you three
things: an interactive **map input widget** for content edit forms, a **Google
Maps field formatter** for showing a stored point, and a **Google Maps Views
style** for plotting a whole list of geolocated content on one map. All of it is
driven by a single, site‑wide Google Maps API key.

On a content edit form, the widget shows a map an editor can click on to place,
find, or remove a marker — or they can type a street address and have it
geocoded (via the Google Maps Geocoder) straight into the latitude/longitude
coordinates. You can use Google Maps or Leaflet as the underlying map library,
pick zoom levels, offer a map‑type selector, and even write the geocoded address
back into a separate text field on the same entity.

For display, the **Geofield Google Map** formatter renders your stored points
with a lot of control: custom marker icons, click‑to‑open infowindows,
hover tooltips, custom map styles, gesture/zoom/pan behavior, marker clustering,
and "spiderfying" of overlapping markers so co‑located points stay clickable.
The Views style plots an entire result set on one map and adds **MapThemer**
plugins that vary marker icons by a field value, a taxonomy term, or an entity
type, plus an optional legend block. Developers can register custom MapThemers
and Leaflet base layers, and there are alter hooks for tweaking map settings in
code. The optional **Geofield Map Extras** submodule adds cheaper static‑image
and iframe‑embed Google Map formatters.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and note the Geofield dependency and the Extras submodule.
2. [Configuration](configuration/index.md) — the site‑wide settings form (Google
   Maps API key, marker storage, geocoder caching) plus how to turn on the
   widget, formatter, and Views style per display.

## Where it lives in the admin menu

The site‑wide settings form sits at **Configuration → System → Geofield Map
settings** (`/admin/config/system/geofield_map_settings`). Everything else is
configured per field: the **widget** under a content type's *Manage form
display*, the **formatter** under *Manage display*, and the **Views style** from
within a View.

## How to use it

1. Add a **Geofield** field to a content type (this comes from the Geofield
   module).
2. Enter your **Google Maps API key** on the settings form (see
   [Configuration](configuration/index.md)) so maps and geocoding can load.
3. Under the content type's **Manage form display**, set that field's widget to
   **Geofield Map** so editors get the interactive input map.
4. Under **Manage display**, set the field's formatter to **Geofield Google
   Map** to show the point on a map when the content is viewed.
5. To map many items at once, build a View of that content, choose the
   **Geofield Google Map** format, and add the geofield to the Fields list.
