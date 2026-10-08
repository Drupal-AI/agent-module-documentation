# Field storage & setting values in code

`GoogleMapFieldType` (`@FieldType id = "google_map_field"`) stores these columns / properties
per delta:

| Property | Storage type | Meaning |
|---|---|---|
| `name` | varchar(128) | Map name/label |
| `lat` | float (big) | Latitude of center (empty ⇒ field considered empty) |
| `lon` | float (big) | Longitude of center |
| `zoom` | int | Zoom level |
| `type` | varchar(32) | Map type (e.g. `roadmap`, `satellite`, `terrain`) |
| `width` | varchar(32) | Rendered width |
| `height` | varchar(32) | Rendered height |
| `marker` | int | Show marker (0/1) |
| `traffic` | int | Show Google traffic layer (0/1) |
| `marker_icon` | varchar(512) | Custom marker icon path |
| `controls` | int | Show map controls (0/1) |
| `infowindow` | text (medium) | Info-window HTML message |

`isEmpty()` returns TRUE when `lat` is NULL or `''`, so always set `lat`/`lon` when creating a
value.

## Set a value programmatically

```php
$node->set('field_map', [
  'name'   => 'HQ',
  'lat'    => 51.5074,
  'lon'    => -0.1278,
  'zoom'   => 12,
  'type'   => 'roadmap',
  'width'  => '100%',
  'height' => '400px',
  'marker' => 1,
  'controls' => 1,
  'infowindow' => '<strong>London office</strong>',
]);
$node->save();
```

Read it back: `$node->get('field_map')->first()->get('lat')->getValue();` or
`$node->field_map->lat`.

The default widget is `google_map_field_default` and default formatter is
`google_map_field_default` (declared on the field type). A Feeds target
(`src/Feeds/Target/GoogleMap.php`) maps incoming feed values onto these same properties.
