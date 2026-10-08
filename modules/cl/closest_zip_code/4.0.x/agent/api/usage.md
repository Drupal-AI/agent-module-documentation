<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Closest Zip Code — programmatic use

No routes or services; call the App singleton directly.

```php
$result = \Drupal\closest_zip_code\ClosestZipCode\App::instance()
  ->closestZipCode('00720', ['00723', '00725', '00727']);
```

Return shape:
```
[
  'errors' => [],            // strings for any zip that could not be resolved
  'zip'    => '00720',
  'lat'    => 18.217946,
  'lon'    => -66.428076,
  'zips'   => [              // ordered nearest-first
    '00727' => ['km' => 37.44, 'miles' => 23.26, 'lat' => …, 'lon' => …],
    …
  ],
  'duration-seconds' => 0.014,
]
```

Notes:
- **Always pass zips as strings** (leading zeros matter).
- Input is validated numeric and bounded 500–99999; out-of-range/non-numeric throws (captured into `errors`).
- Data source is the bundled `data/zipcodes.csv` (US + territories) — **no external API call**, so results are limited to that dataset and offline-safe.
- Drush one-liner: `drush ev 'print_r(\Drupal\closest_zip_code\ClosestZipCode\App::instance()->closestZipCode("00720", ["00723","00725"]));'`
- There is no built-in access control — wrap it in your own permission-checked code before exposing to end users.
