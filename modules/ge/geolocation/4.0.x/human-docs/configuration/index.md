# Configuration

Geolocation has no central settings form. You configure it in three places: the
**field** you add to a content type, its **form display** and **display**
settings, and — for listings and proximity search — inside **Views**. This page
walks through each. Before you start, make sure you have enabled at least one
map-provider submodule (see [Installation](../installation/index.md)); the map
widget and formatter need one to draw a map.

## 1. Add the geolocation field

1. Go to **Structure → Content types → *(your type)* → Manage fields**
   (`/admin/structure/types/manage/<bundle>/fields`).
2. Click **Add field** and choose the **Geolocation** field type.
3. Give it a label (for example *Location*) and save. The field stores a
   latitude/longitude pair for each item.

## 2. Choose the editing widget (Manage form display)

On the content type's **Manage form display** tab, pick how editors set the
coordinates:

- **Geolocation Lat/Lng** — plain numeric latitude and longitude inputs. Good
  when editors already know the exact coordinates and you don't need a map.
- **Geolocation Map** — an interactive map the editor clicks to drop a pin, with
  optional **geocoding** so a typed address is converted into coordinates. This
  widget needs an enabled map-provider submodule.

Open the widget's settings (the gear icon) to select the **map provider**, the
**map center** strategy, and any **map features** (markers, clustering, controls,
popups) you want on the editing map.

## 3. Choose the display formatter (Manage display)

On the **Manage display** tab, pick how the stored location is shown to visitors:

- **Map** — an interactive map with markers (needs a map provider).
- **Lat/Lng** — the raw decimal coordinates.
- **Sexagesimal** — degrees/minutes/seconds notation.
- **Token** — text built from tokens.
- **Image EXIF Map** — a map built from an image's GPS EXIF data.

For the **Map** formatter, the settings let you choose the provider, center
strategy, and map features, just like the widget.

## 4. Set the map-provider API key (if required)

Providers that need a key have their own settings page. The most common is
**Google Maps**: go to its settings form (`geolocation_google_maps.settings`),
paste your Google Maps API key, and save. **Leaflet** needs no key. Access to
these provider settings pages is gated by the core **Administer site
configuration** permission.

## 5. Build a map or proximity view (Views)

Geolocation ships Views plugins for mapping and "near me" search.

**Show entities as map markers (CommonMap):**

1. Create a **View** of the content type that holds your geolocation field.
2. Under **Format**, choose **Geolocation CommonMap**.
3. In its settings, select the geolocation field as the source and pick a map
   provider and map features (for example clustering for a dense map).

**Add a proximity ("stores near me") search:** in the same view, add the
geolocation field's proximity handlers:

- **Proximity filter** — restrict results to within a radius of a location.
- **Proximity sort** — order results nearest-first.
- **Proximity argument** — accept a center/radius as a contextual filter (for
  example from the URL or the visitor's location) for radius-search pages.
- **Proximity field** — show the computed distance as a column in a normal list.

A typical recipe is: add the proximity **filter** (or argument) to limit by
radius, add the proximity **sort** to order nearest-first, then set the Format to
CommonMap to plot the results — or keep a normal list and add the proximity field
as a distance column.

## Permissions

Geolocation adds one permission, **Configure Geolocation settings**
(`configure geolocation`). Viewing maps on rendered content needs no special
permission beyond access to the content itself. Provider submodule settings pages
(such as the Google Maps API key) are gated by **Administer site configuration**.

## A note on config export

All field, widget, formatter, and Views settings are stored as exportable
configuration, so you can build your maps in one environment and deploy them to
another with your normal config workflow.
