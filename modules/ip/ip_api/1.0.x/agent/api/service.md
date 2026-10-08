<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IP API — service usage

Service id: `ip_api.geolocation` — class `Drupal\ip_api\IpApiGeolocation`.

```php
/** @var \Drupal\ip_api\IpApiGeolocation $geo */
$geo = \Drupal::service('ip_api.geolocation');
$params = $geo->callIpApi();          // \Drupal\ip_api\IpApiParameters | NULL
if ($params && $params->isRequestSuccessful()) {
  $country = $params->getCountry();
  $code    = $params->getCountryCode();
  $city    = $params->getCity();
  $lat     = $params->getLatitude();
  $lon     = $params->getLongitude();
  $tz      = $params->getTimezone();
}
```

`IpApiParameters` getters: `getStatus`, `getCountry`, `getCity`, `getCountryCode`,
`getRegion`, `getIsp`, `getLatitude`, `getLongitude`, `getOrganization`, `getIp`,
`getZip`, `getTimezone`, `isRequestSuccessful`.

Endpoint selection (`IpApiGeolocation::setUrl()`):
- key set  → `http://pro.ip-api.com/json/{clientIp}?key={key}`
- key empty → `http://ip-api.com/json/{clientIp}`

`callIpApi()` catches `ClientException` (returns the error body wrapped) and other
exceptions (logs, returns NULL). Both hosts are contacted over unencrypted HTTP —
do not rely on transport confidentiality for the key or the response.
