# Address autocomplete widget & element

## Field widget `geo_entity_address`

`Drupal\geo_entity_address\Plugin\Field\FieldWidget\AutocompleteAddress` extends Address module's
`AddressDefaultWidget`. Applies to `address` field type.

`defaultSettings()` adds:
- `providers` — map of Geocoder provider id → `{checked, weight}`.
- `geocode_geofield` — machine name of a geofield on the same bundle to populate with coordinates (or '').

`settingsForm()` renders the geocoder provider draggable table via
`ProviderPluginManager::providersPluginsTableList()` and a `geocode_geofield` select listing the bundle's
geofields. `validateProvidersSettingsForm()` requires at least one provider checked.

`formElement()` swaps the address element to `#type = 'geo_entity_address'`, sets
`#geocoders` = enabled provider ids, and passes `data-geocode-geofield` so client JS knows which geofield to
fill. `getEnabledGeocoderProviders()` loads the checked providers as `GeocoderProvider` entities sorted by
weight.

## Form element `geo_entity_address`

`Drupal\geo_entity_address\Element\AutocompleteAddress` (`@FormElement`) extends the Address element and adds a
`processAutocomplete` process callback. It:
1. Builds `$data = ['geocoder_providers' => $element['#geocoders']]`.
2. Computes `$key = Crypt::hmacBase64(serialize($data), Settings::getHashSalt())` and stores `$data` in the
   `geo_entity_address_autocomplete` key/value store under that key.
3. Points the field at `geo_entity.autocomplete/{settings_key=$key}` and only attaches the autocomplete
   behavior (`geo_entity_address/autocomplete` library + `data-autocomplete-path`) if the current user passes
   `access_manager->checkNamedRoute()` for that route.

The server side (parent module `AutocompleteController`) re-derives and `hash_equals()`-verifies the HMAC
before geocoding — so the provider list cannot be tampered with via the URL. See parent
[api/entity.md](../../../../../1.1.x/agent/api/entity.md).

## Shipped Geocoder providers

`config/install` includes `geocoder.geocoder_provider.geo_entity_osm` (OSM/Nominatim) and
`geocoder.geocoder_provider.geo_entity_demo_photon` (Photon demo). Reference these from a field's `providers`
setting or replace them.

## Also ships

`GeofieldHidden` widget (`src/Plugin/Field/FieldWidget/GeofieldHidden.php`) for storing the geocoded
coordinates in a hidden geofield, plus `js/autocomplete.js` behavior.
