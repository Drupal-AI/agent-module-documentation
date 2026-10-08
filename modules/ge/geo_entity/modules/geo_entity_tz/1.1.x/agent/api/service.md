# GeoNames time zone service

Service id `geo_entity_tz.geonames_timezone` → `Drupal\geo_entity_tz\GeonamesTimezone` implements
`GeonamesTimezoneInterface`. Constructor args: `@http_client`, `@config.factory`.

Endpoint: `https://secure.geonames.org/timezoneJSON` (GET).

## Methods

```php
public function getTimezone(float $lat, float $lng, int $radius = NULL): string;
public function timezoneRequest(float $lat, float $lng, int $radius = NULL,
                                string $lang = NULL, string $date = NULL): array;
```

- `getTimezone()` returns just the `timezoneId` (IANA id) from the response.
- `timezoneRequest()` returns the full decoded response array.
- Both require `geo_entity_tz.settings:username`; if empty they throw
  `GeonamesException('Geonames username is required.', 1)`.
- Query params sent: `username`, `lat`, `lng`, and optionally `token`, `radius`, `lang`, `date`.
- A Guzzle transport error becomes `GeonamesException('Error retrieving data', 0, $e)`.
- If GeoNames returns a `status` object (e.g. quota/invalid user), it is rethrown as `GeonamesException`
  with that message and code.

## Example

```php
$tz = \Drupal::service('geo_entity_tz.geonames_timezone')->getTimezone(51.5074, -0.1278);
// 'Europe/London'
```

## Presave integration

`geo_entity_tz_geo_entity_presave(GeoEntityInterface $geo)` (in `geo_entity_tz.module`) drives this service
automatically for every `tzfield` linked to a geofield via the `geo_entity_tz.geofield` third-party setting —
see [configure/settings.md](../configure/settings.md). `GeonamesException` is caught per-item so a failed
lookup never blocks the save; a warning is shown only to users with `administer geo_entity_tz configuration`
when the username is missing.
