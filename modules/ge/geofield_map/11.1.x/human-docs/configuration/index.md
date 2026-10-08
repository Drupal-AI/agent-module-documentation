# Configuration

Geofield Map has one **site‑wide settings form** for things every map shares
(the API key, where marker icons are stored, geocoder caching), and then most of
the real work happens **per field** — you turn on the widget, formatter, and
Views style on individual displays. This page covers both.

## The site‑wide settings form

1. Log in as a user with the **Configure geofield_map** permission (an
   administrator by default).
2. Go to **Configuration → System → Geofield Map settings**, or navigate
   directly to `/admin/config/system/geofield_map_settings`.

### Google Maps API key

The most important field. Paste your **Google Maps API key** here — the same key
is used for *both* map rendering and address geocoding on the client side.
Without it, Google maps and geocoding will not load.

If you have the **Key** module enabled, this field becomes a **key selector**
instead of a plain text box: create a Key entity that holds the API key value,
then pick it here so the secret is never stored in plain configuration. This is
the recommended approach.

### API localization

Chooses how the Google Maps API is loaded. Leave it on **default** for the normal
international endpoint, or pick **china** to load the variant tuned for serving
users in China.

### Marker icon storage (theming)

These settings tell the marker/theming system where your custom marker‑icon image
files live and what's allowed:

- **Storage location / security** — the stream wrapper for custom marker icons.
  Defaults to public (`public://`); a private option appears only if your site
  has a private file path configured.
- **Relative path** — the folder under that wrapper where icons are kept
  (default `geofieldmap_icons`, no leading or trailing slash).
- **Additional markers location** — an extra place to also search for marker
  icons, handy for icons versioned inside your codebase.
- **Allowed extensions** — the image types permitted for markers (default
  `gif png jpg jpeg`).
- **Maximum file size** — the size cap per marker image (default `250 KB`; you
  can write values like `512`, `80 KB`, or `50 MB`).

### Geocoder client‑side caching

Controls whether (reverse‑)geocoding results are cached in the visitor's browser
to cut down on API calls. Options are **none**, **session storage** (default —
cleared when the tab closes), or **local storage** (persists between visits).

Click **Save configuration** when done.

## Turning on the widget, formatter, and Views style

These are field and Views plugins, not admin pages — you configure them on the
displays where you want a map. You need a content type (or other entity bundle)
that has a **Geofield** field first.

### The map input widget

Go to the bundle's **Manage form display** and set the Geofield field's widget to
**Geofield Map**. Its settings let you choose:

- **Map library** — Google Maps or Leaflet.
- **Zoom levels** and a **map‑type selector**.
- **Click behavior** — click to place a marker, click to find, click to remove.
- **Google Places / address geocoding** — let editors type an address that's
  geocoded into coordinates.
- **Geoaddress field** — write the geocoded address back into another field on
  the entity.

### The Google Maps formatter

Go to **Manage display** and set the Geofield field's formatter to **Geofield
Google Map**. Its options are grouped into sections you expand as needed: map
dimensions, map center, zoom and pan, controls, marker and infowindow (icon,
which field/view mode fills the infowindow, tooltip), overlapping‑marker
spiderfier, custom map style, marker clustering, geocoder, additional libraries,
and lazy loading.

### The Views style

In a View, choose the **Geofield Google Map** format for the display and add the
Geofield to the **Fields** list. The style options mirror the formatter and add
**MapThemer** marker theming — varying icons by a List field's value, by taxonomy
term, or by entity type — along with an optional **legend** block. See the
[`agent/plugins`](../../agent/plugins/plugins.md) doc for the theming plugin
details.

## Permission

Geofield Map defines a single permission, **Configure geofield_map**, which
controls access to the settings form above.
