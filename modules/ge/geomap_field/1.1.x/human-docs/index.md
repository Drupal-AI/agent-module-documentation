# Geomap Field — manual setup guide

**Geomap Field** (`geomap_field`) provides a single, self‑contained **Address**
field type that stores a postal address *and* its geographic coordinates
together in one field. When editors fill in the address (address name, street,
postal code, city, country, and an extra address‑information line) a map is shown
right beside the form, and a button lets them look the address up so the
**Latitude** and **Longitude** are filled in automatically. Those coordinates can
also be overridden by hand when you need exact positioning.

Because the coordinates are stored in the database at save time, anything that
later needs to place the content on a map already has the precise point — there's
no need to geocode the address again on every page load, which is a real
performance win for map‑heavy sites. The module also ships a **field formatter**
that displays the stored field as a map on the rendered page.

It is deliberately small — "a simple module for a simple purpose to avoid the
heavier modules." It leans on two companion modules to do the geocoding and the
map rendering: **Geolocation Provider** (which supplies geocoders such as
Nominatim or Bano) and **Map Provider** (which supplies map backends such as
OpenStreetMap).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm the provider modules came along.

There is **no configuration page** for this module — it has no settings form.
Everything happens when you add the field to a content type and set up its widget
and display, described in "How to use it" below.

## Where it lives in the admin menu

Geomap Field adds no admin settings page of its own. You use it entirely from the
**Field UI** — **Structure → Content types → *(your type)* → Manage fields** to
add the field, and **Manage form display** / **Manage display** to configure the
widget and the map formatter.

## How to use it

1. Go to **Structure → Content types → *(your content type)* → Manage fields**
   and click **Add field**.
2. Choose the **Geomap** field type and give it a label. Save through the field
   settings.
3. On **Manage form display**, the Geomap widget shows the address inputs next to
   a map with a "locate" button. Editors type the address, click the button, and
   the latitude/longitude are filled in automatically (they can still override
   them for precise coordinates).
4. On **Manage display**, choose the **map** formatter to render the stored
   address as a map on the page. This is where you pick your **map provider**
   (for example OpenStreetMap) and your **geolocation provider** (for example
   Nominatim or Bano).

Now editors can add content with a real address and an on‑the‑spot map, and your
templates and Views can rely on the stored coordinates.
