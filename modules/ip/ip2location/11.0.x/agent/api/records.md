<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reading geolocation in code

The subscriber caches a JSON record in the session on the first request; read it back anywhere:

```php
$geo = ip2location_get_records();
if ($geo) {
  $country = $geo->country_code;   // e.g. 'US'
  $city    = $geo->city_name;
  $lat     = $geo->latitude;
  $lon     = $geo->longitude;
}
```

Returned object fields include: `ip_address`, `country_code`, `country_name`, `region_name`, `city_name`, `latitude`, `longitude`, `isp`, `domain_name`, `zip_code`, `time_zone`, `net_speed`, `idd_code`, `area_code`, `weather_station_code`, `weather_station_name`, `mcc`, `mnc`, `mobile_carrier_name`, `elevation`, `usage_type`, `address_type`, `category`, `district`, `as`, `asn`. Availability of each field depends on the BIN edition (LITE vs commercial DBn).

Notes:
- The value is cached per session, so it reflects the IP of the first request that populated it.
- Returns `null`/nothing if the database is missing or the lookup failed.
