<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SynMap displays a small, single-location map block (Yandex Maps, Google Maps or OpenStreetMap) attached to a page.

---

SynMap is a lightweight, client-side location-map module from the Synapse family. It renders one marked point (an office, shop or point of interest) as a compact map that is injected into a page next to a configurable CSS selector. A single admin form (`synmap.settings`, at `/admin/config/synmap`, requiring `administer site configuration`) sets the provider (Yandex "standart" or Google), the latitude/longitude, zoom, marker label, center offset, insertion selector/method and the provider API keys. A `hook_page_attachments()` implementation (service `synmap.page_attachments`) decides on which pages the map appears — whole site (excluding `/admin/`), front page only, a single contact/path page, or everywhere except that path — and passes the settings to the browser via `drupalSettings`. When the interface language is not Russian and the provider is "standart", it additionally loads an OpenStreetMap/Leaflet map. The map itself is drawn by JavaScript that lazy-loads the Yandex, Google or Leaflet library as the user scrolls near it.

Use it to add a simple "where we are" map to a contact or landing page without a heavy geolocation stack. It is a content-display feature and enforces no access control of its own; the only gated surface is the admin settings form.

---

- Show a small single-location map on a page.
- Display an office or shop location.
- Use Yandex Maps as the provider.
- Use Google Maps as the provider.
- Use OpenStreetMap / Leaflet as the provider.
- Show the map on the whole site (excluding admin pages).
- Show the map on the front page only.
- Show the map on a single contact/path page only.
- Show the map everywhere except one path.
- Configure everything at `/admin/config/synmap`.
- Set the map latitude and longitude.
- Set the map zoom level.
- Set the marker label / company name shown on click.
- Attach the map next to a chosen CSS selector.
- Choose the insert method (before, after, append, prepend).
- Nudge the map center with an X/Y offset.
- Provide a Yandex Maps API key.
- Provide a Google Maps API key.
- Lazy-load the map library on scroll for performance.
- Translate the map settings via config translation.
- Alter map display from a custom module via `hook_synmap_display_alter()`.
- Override the map data client-side via `drupalSettings.synmapReplace`.
- Add a compact "where we are" block to a contact page.
- Show a point of interest on a landing page.
