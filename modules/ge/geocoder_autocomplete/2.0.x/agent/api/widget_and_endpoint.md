# Widget, endpoint & consumer service

## Widget — `src/Plugin/Field/FieldWidget/GeocoderAutocomplete.php`

`@FieldWidget(id = "geocoder_autocomplete", field_types = {"string"})`, extends core
`StringTextfieldWidget`. In `formElement()` it renders the standard string textfield, then —
**only if** the current user has `access geocoder autocomplete` — adds
`#autocomplete_route_name = geocoder_autocomplete.autocomplete`, `#size`, `#placeholder`,
`#maxlength = 255`, and an `#element_validate` handler. `validateFormElement()` just trims
surrounding double-quotes from the submitted value. The widget stores the chosen **address
string** into the plain string field; lat/lng/place_id from the response are not persisted here.

## Route / controller — `geocoder_autocomplete.autocomplete`

`GET /geocoder/autocomplete`, requirement `_permission: 'access geocoder autocomplete'`,
controller `GeocoderController::geocoderAutocomplete()`. It reads `?q=` and returns
`new JsonResponse($this->geocoderService->getAddress($q))`.

## Service — `GeocoderJsonConsumer` (`geocoderautocomplete.consumer`)

Defined in `geocoder_autocomplete.services.yml` (args `@http_client`, `@language_manager`;
tagged `geo_service`). `getAddress($text)`:

```php
$query = [
  'address'  => $text,                                   // the typed query
  'language' => <current interface language, default 'en'>,
  'sensor'   => 'false',
  'region'   => $config->get('region_code_bias'),
  'key'      => $config->get('api_key'),
];
$response = $http_client->request('GET', 'https://maps.googleapis.com/maps/api/geocode/json', ['query' => $query]);
```

The request URL is a **fixed constant** — only Google's geocode endpoint is ever called; the
user query is a `?address=` parameter, not part of the host/path (no SSRF). On `status == 'OK'`,
each result yields:

```php
['value' => Html::escape($formatted_address),
 'label' => Html::escape($formatted_address),
 'lat' => …, 'lng' => …, 'place_id' => …]
```

`value`/`label` are HTML-escaped before being returned in the JSON response. Any transport error
or non-OK status yields an empty match array.

## Reuse

Call the service directly for server-side geocoding:

```php
$matches = \Drupal::service('geocoderautocomplete.consumer')->getAddress('1600 Amphitheatre Pkwy');
```
