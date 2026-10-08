<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Export a Geolocation field over REST

## Steps (Views UI)

1. Have a `geolocation` field on your entity (Geolocation module) and a **REST Export** view.
2. *Add field* → choose the geolocation field's **(serializable)** variant (handler
   `field_export`, added by this submodule for `geolocation_field` handlers).
3. Set its **Formatter** to **Export** (`geolocation_latlng_formatter_export`).
4. Save.

Each value serializes as `{"lat": <float>, "lng": <float>}`; multiple values become an array of
such objects.

## Config shape

```yaml
# views.view.<id>  ->  display.<d>.display_options.fields.<field>
plugin_id: field_export                       # serializable handler (required)
type: geolocation_latlng_formatter_export     # this submodule's formatter
```

## In code

```php
use Drupal\views\Entity\View;
$view = View::load('locations_feed');
$display = $view->get('display');
$display['default']['display_options']['fields']['field_geo'] = [
  'id' => 'field_geo', 'table' => 'node__field_geo', 'field' => 'field_geo',
  'plugin_id' => 'field_export',
  'type' => 'geolocation_latlng_formatter_export',
  'entity_type' => 'node', 'entity_field' => 'field_geo',
];
$view->set('display', $display)->save();
```

The formatter (`GeolocationLatLngExportFormatter::viewElements()`) returns per delta
`['#type' => 'data', '#data' => SerializedData::create(['lat' => $item->lat, 'lng' => $item->lng])]`,
which REST Views' `DataNormalizer` serializes to a real JSON object. It only takes effect with
the `field_export` handler.
