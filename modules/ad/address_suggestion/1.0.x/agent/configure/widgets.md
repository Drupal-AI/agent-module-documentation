# Field widgets (configure)

All configuration lives in the **form-display widget settings** (there is no module settings page).
Pick one of these widgets on `admin/structure/types/manage/<bundle>/form-display`, choose a
`provider`, and (for keyed providers) fill `api_key`. The autocomplete is wired to the JSON route
`address_suggestion.addresses` and driven by the JS libraries `address_suggestion/address_suggestion`
(address widget) or `address_suggestion/address_suggestion_widget` (text/geofield widgets).

## Widgets

| Widget id | For field type | Class | Notes |
|---|---|---|---|
| `address_suggestion` | `address` | `AddressSuggestionWidget` (extends address `AddressDefaultWidget`) | Main widget. Swaps the address element `#type` to `address_suggestion`. |
| `address_suggestion_widget` | `text`, `string` | `AddressSuggestionWidgetField` (extends the above) | A single autocomplete textfield; the full label is stored in the field value. |
| `address_geofield_default` | `geofield` | `AddressGeofieldWidget` (extends geofield `GeofieldLatLonWidget`) | Requires the `geofield` module. Adds a suggestion textfield that fills lat/lon; optional mini OSM map via `show_map`. |
| `country_continent` | `address_country` | `CountryContinentWidget` (extends address `CountryDefaultWidget`) | Not autocomplete — limits the country select to chosen continents. Uses lib `address_suggestion/continent`. |

## Settings — `address_suggestion` and `address_suggestion_widget`

Config schema: `field.widget.settings.address_suggestion`,
`field.widget.settings.address_suggestion_widget`.

| Key | Type | Meaning |
|---|---|---|
| `provider` | string | Plugin id of the `AddressProvider` to query (e.g. `nominatim`, `photon`, `google_place`). |
| `endpoint` | string (url) | Optional custom API URL. **Overrides** the provider's built-in `api`. Empty ⇒ use the provider default. |
| `api_key` | string | API key, sent server-side by keyed providers. Shown only for providers without `nokey`. |
| `username` / `password` | string | Credentials for login providers (only `post_ch`). |
| `location_field` | string | Machine name of a `geofield`/`geolocation` field on the same bundle to receive the picked lat/lon. |
| `hide` | boolean | (`address_suggestion` only) Collapse the five address boxes to one "start typing" line; on pick, the hidden subfields are populated. |

The `address_geofield_default` widget stores `location_field`, `provider`, `api_key`, `hide`,
`show_map`, `wrapper_type` (no dedicated config schema is shipped for it). The `country_continent`
widget stores `continent` (sequence) and `multi` (boolean) — schema
`field.widget.settings.country_continent`.

## Set the widget from code

```php
\Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'article', 'default')
  ->setComponent('field_address', [
    'type' => 'address_suggestion',
    'settings' => [
      'provider' => 'nominatim',
      'endpoint' => '',        // or 'https://your-proxy.example/search'
      'api_key' => '',
      'location_field' => 'field_geo',
      'hide' => FALSE,
    ],
  ])->save();
```

## Runtime flow

1. The `address_suggestion` render element (`Element\AddressSuggestion::processAutocomplete`) attaches
   the library and sets `#autocomplete_route_name = address_suggestion.addresses` with route params
   `entity_type`/`bundle`/`field_name`. It also records the currently selected `country_code` into
   `State` (`{entity_type}|{bundle}|{field_name}`), so suggestions can be country-scoped.
2. jQuery-UI autocomplete GETs the route with `?q=<typed>&country=<code>`.
3. `Controller\AddressSuggestion::handleAutocomplete` loads the **default form-display component's
   `settings`** for that field, merges the stored country, and calls
   `getProviderResults($q, $settings)` → `plugin.manager.address_provider` → the provider's
   `processQuery()`. The provider (server-side) calls the external API and returns a JSON list of
   `{street_name, town_name, administrative_area, zip_code, country_code, location:{lat,lng}, label}`.
4. `js/address_suggestion.js` maps the picked item onto the address subfields (and the linked
   `location_field` when present).

Provider `endpoint`/`api_key` come from this stored widget config, not from the request.
