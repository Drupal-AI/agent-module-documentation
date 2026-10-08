# Google Maps setup

## API key
Settings form at `/admin/config/services/geolocation/google_maps`
(route `geolocation_google_maps.settings`, config `geolocation_google_maps.settings`, schema
`config/schema/geolocation_google_maps.schema.yml`). Enter a Google Maps JavaScript API key
(from a billing-enabled Google Cloud project). Once set, "Google Maps" appears as a selectable
map provider in geolocation field widget/formatter and Views CommonMap settings.

## What it provides
- **MapProvider**: Google Maps (`src/…/GoogleMaps.php`, base `GoogleMapsProviderBase`).
- **Geocoders**: Google-based address↔coordinate geocoding (`GoogleGeocoderBase`) and
  per-country formatting (`GoogleCountryFormattingBase`).
- Google-specific map/layer features under `config/schema/geolocation_google_maps.*`.

## Extra Maps API parameters
Add libraries/params to the Maps API URL with the hook in
`geolocation_google_maps.api.php`:
```php
function hook_geolocation_google_maps_parameters() {
  return ['libraries' => ['places']];
}
```

## Nested submodules
- `geolocation_google_places_api` — Places autocomplete input.
- `geolocation_google_static_maps` — static (image) map rendering.
- `geolocation_google_maps_demo` — examples (skip in production).
