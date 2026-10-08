<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Mapkit Google Maps registers a Google Maps map-provider (with a symbol marker plugin and Places autocomplete) for the Mapkit framework and loads the Google Maps JavaScript API using an admin-configured API key.
---
The settings form at `/admin/config/services/mapkit/providers/gmap` stores an `api_key`, an optional `region` code and a set of optional Google JS libraries (`drawing`, `geometry`, `places`, `visualization`) in `mapkit_gmap.settings`. `hook_library_info_alter()` builds the `//maps.googleapis.com/maps/api/js?...` loader URL from that config (key, region, `loading=async`, `callback=Mapkit.loader.gmap.init`, and the selected libraries) and attaches it as an external, deferred script to the `loader` library. Saving the form clears the library-discovery cache so the new URL takes effect.

The Google Maps **JavaScript API key is a client-side key** — it is emitted in the rendered page markup by design, so it must be an HTTP-referrer-restricted browser key (restrict it in the Google Cloud console), not a server/secret key. The config form is gated by the `administer mapkit providers` permission from the base Mapkit module; there are no other routes. Setup: enable Mapkit + this module, obtain a Google Maps JS API key, enter it on the settings form, and select the Places library if you need autocomplete.
---
- Provide Google Maps rendering to Mapkit maps.
- Enter a Google Maps JavaScript API key.
- Restrict the key by HTTP referrer in Google Cloud (recommended).
- Set a region code to bias map/geocoding results.
- Enable the Places library for address autocomplete.
- Enable the Drawing library for polygons/circles/markers.
- Enable the Geometry library for scalar geo calculations.
- Enable the Visualization library for heatmaps.
- Use Google Places autocomplete as a Mapkit location input.
- Render a Mapkit map field with Google Maps as the provider.
- Use the Google symbol marker plugin for map markers.
- Rotate/replace the API key via the settings form.
- Clear the asset library cache automatically on save.
- Configure Google Maps as the provider from the Mapkit provider list.
- Grant `administer mapkit providers` to manage the key.
- Load the Maps JS API asynchronously (async loader + callback).
