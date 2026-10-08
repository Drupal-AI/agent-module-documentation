# Alter hooks

Declared in `geocoder.api.php`. Implement in your `.module` file.

| Hook | When | Signature |
|---|---|---|
| `hook_geocode_address_string_alter` | Before an address string is geocoded | `(string &$address_string)` |
| `hook_geocode_address_geocode_query` | Lets you adjust the built query (locale, bounds, limit) | `(\Geocoder\Query\GeocodeQuery $address)` |
| `hook_reverse_geocode_coordinates_alter` | Before coordinates are reverse-geocoded | `(string &$latitude, string &$longitude)` |
| `hook_geocode_country_code_alter` | When `DumperPluginManager::setCountryFromGeojson` resolves a country code (e.g. filling an Address field) | `(string &$country_code, array $geojson_array)` |

```php
function mymodule_geocode_address_string_alter(string &$address_string) {
  // Normalize before geocoding.
  $address_string = trim($address_string) . ', USA';
}

function mymodule_reverse_geocode_coordinates_alter(string &$latitude, string &$longitude) {
  // Round to protect privacy.
  $latitude = number_format((float) $latitude, 3);
  $longitude = number_format((float) $longitude, 3);
}
```

Note `hook_geocode_address_geocode_query` receives the `GeocodeQuery` object (mutate it in
place via its `with*()` builder methods before it runs).
