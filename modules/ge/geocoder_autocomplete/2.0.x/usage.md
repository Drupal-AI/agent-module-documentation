Geocoder Autocomplete adds a text-field widget whose autocomplete suggestions are real addresses returned by the Google Geocoding API, so editors type a place and pick a formatted address.

---

The module provides one field widget, `geocoder_autocomplete` (`extends StringTextfieldWidget`), selectable on any `string` field's *Manage form display* tab. When rendered for a user who holds the `access geocoder autocomplete` permission, the widget attaches Drupal's autocomplete behaviour pointed at the internal route `geocoder_autocomplete.autocomplete` (`/geocoder/autocomplete`). That route's controller passes the typed query `q` to the `geocoderautocomplete.consumer` service (`GeocoderJsonConsumer`, tagged `geo_service`), which calls Google's `https://maps.googleapis.com/maps/api/geocode/json` with the site-configured `api_key`, an optional 2-letter `region_code_bias`, and the current interface language, then returns matched `formatted_address` strings (HTML-escaped) plus lat/lng and `place_id` as JSON. A global settings form at `/admin/config/system/geocoder_autocomplete` (permission `administer geocoder autocomplete`) stores the Google API key and region bias in `geocoder_autocomplete.settings`. The widget submits the chosen address string into the plain string field (a validate handler just trims surrounding quotes); lat/lng/place_id are returned to the autocomplete UI but not persisted by the widget itself. You need a Google Cloud API key with the Geocoding API enabled and billing configured.

---

- Give an address text field Google-powered autocomplete suggestions.
- Let editors search "Eiffel Tower" and select a fully formatted street address.
- Standardise free-text address entry to Google's `formatted_address` form.
- Bias geocoding results toward a country with a 2-letter region code.
- Localise autocomplete results to the site's current interface language.
- Add address autocomplete to a custom content type's location string field.
- Populate a venue/office/branch address field from Google data.
- Reduce address typos by picking from validated suggestions.
- Restrict who can trigger geocoding lookups via the `access geocoder autocomplete` permission.
- Keep the Google API key server-side and out of page markup.
- Provide autocomplete on a profile or user-entity address field.
- Use on event, listing or store-locator content where a canonical address matters.
- Gate the autocomplete endpoint behind a permission so anonymous users cannot consume the API.
- Configure the API key and region bias centrally for all address fields.
- Swap a plain textfield widget for the geocoder widget without changing the field type.
- Attach address autocomplete to Webform/paragraph string fields (via Manage form display).
- Return place metadata (lat/lng/place_id) to front-end JS listening on the autocomplete response.
- Let content teams enter international addresses with consistent formatting.
- Trim stray quotes from selected suggestions automatically on submit.
- Centralise geocoding through one reusable `geo_service`-tagged consumer service.
