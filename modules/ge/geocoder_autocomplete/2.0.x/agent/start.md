# Geocoder Autocomplete — agent index

A `string`-field widget (`geocoder_autocomplete`) that provides address autocomplete via the
**Google Geocoding API**. Settings UI at `/admin/config/system/geocoder_autocomplete`
(`configure: geocoder_autocomplete.adminSettings`). No module dependencies; provides a config
schema and two permissions. No Drush.

- **API key, region bias, the settings form, config keys** →
  [configure/settings.md](configure/settings.md)
- **The two permissions and what they gate** →
  [permissions/permissions.md](permissions/permissions.md)
- **The widget, the `/geocoder/autocomplete` route/controller, and the `GeocoderJsonConsumer`
  service** → [api/widget_and_endpoint.md](api/widget_and_endpoint.md)

Key facts:
- Widget id `geocoder_autocomplete`, field type `string`, on *Manage form display* (extends
  core `StringTextfieldWidget`); the autocomplete is only wired for users with
  `access geocoder autocomplete`.
- Config object `geocoder_autocomplete.settings`: `api_key`, `region_code_bias` (2 letters).
- Lookups hit the **fixed** URL `https://maps.googleapis.com/maps/api/geocode/json`; the query
  target is not user-controllable (no SSRF surface).
- Results are `Html::escape`d before being returned as JSON.
