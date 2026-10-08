<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Post-install: Google Maps API key for geocoding

The module has **no settings form** (`configure: null`). The one thing an operator normally must set
after install is the Google Maps API key used to geocode Place addresses into `field_geofield`.

## Config object

`geocoder.geocoder_provider.googlemaps` (shipped in `config/optional/`, enforced-dependency on the
module). It ships with an **empty** `apiKey`, so geocoding does nothing useful until you set one:

```yaml
id: googlemaps
plugin: googlemaps
configuration:
  throttle: { period: null, limit: null }
  apiKey: ''      # <- set this
  region: ''
```

## Set it

Via drush (`config:set`):

```bash
drush config:set geocoder.geocoder_provider.googlemaps configuration.apiKey 'YOUR_KEY' -y
```

Or in PHP:

```php
\Drupal::configFactory()
  ->getEditable('geocoder.geocoder_provider.googlemaps')
  ->set('configuration.apiKey', 'YOUR_KEY')
  ->save();
```

The provider is also editable in the UI at the Geocoder providers admin page (`geocoder` module).
`field_geofield` references this provider via its `geocoder_field` third-party settings (see
[../fields/place.md](../fields/place.md)); on node save the address is sent to Google Maps and the
resulting point stored as WKT.
