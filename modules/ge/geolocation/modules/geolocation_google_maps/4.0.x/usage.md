Geolocation - Google Maps API adds Google Maps as a map provider and geocoding backend for the Geolocation module.

---

This submodule of Geolocation registers a Google Maps map provider so geolocation fields, widgets, formatters, and Views maps can render with Google's tiles and controls. It also provides Google-based geocoders (address-to-coordinates and reverse) and per-country address formatting. You supply a Google Maps JavaScript API key on its settings page (`/admin/config/services/geolocation/google_maps`), and the module loads the Maps API with any extra libraries (e.g. Places) declared through `hook_geolocation_google_maps_parameters()`. It bundles further optional submodules for Google Places autocomplete (`geolocation_google_places_api`), static map images (`geolocation_google_static_maps`), and a demo. Requires the base `geolocation` module and a valid, billing-enabled Google Cloud API key.

---

- Render geolocation maps using Google Maps tiles and styling.
- Set the Google Maps JavaScript API key in one place for the whole site.
- Geocode a typed address into lat/lng using Google's geocoder.
- Reverse-geocode coordinates back into a formatted address.
- Use Google map widgets to place a pin when editing content.
- Show a Views CommonMap of results on a Google map.
- Enable the Places library for address autocomplete.
- Provide country-specific address formatting on geocoded results.
- Add Google Places autocomplete via geolocation_google_places_api.
- Serve lightweight static map images with geolocation_google_static_maps.
- Add custom Maps API URL parameters through the provided hook.
- Center a Google map on the fitting bounds of all markers.
- Cluster dense markers on a Google map.
- Build a store locator on Google Maps with proximity search.
- Display a contact-page map centered on an office address.
