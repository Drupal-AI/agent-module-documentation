# API — querying & using location

## `SmartIp::query()` — the entry point

`\Drupal\smart_ip\SmartIp` (static wrapper):

```php
use Drupal\smart_ip\SmartIp;
$loc = SmartIp::query();            // current visitor (request client IP)
$loc = SmartIp::query('8.8.8.8');   // a specific IP
```

Returns an **array** with keys (populated by the active data source, then normalized in
`updateFields()`):

`country`, `countryCode`, `region`, `regionCode`, `city`, `zip`, `latitude`, `longitude`,
`timeZone`, `isEuCountry`, `ipAddress`, `ipVersion`, `source`, `timestamp`.

Behaviour: returns `[]` for IPs matching `excluded_ips`; static-caches per IP for the request;
dispatches `SmartIpEvents::QUERY_IP` (source fills the data) then `DATA_ACQUIRED` (other modules
may alter it).

Other static helpers on `SmartIp`:

- `SmartIp::updateUserLocation()` — geolocate the current user and persist onto their user entity.
- `SmartIp::getSession($key, $default = NULL)` / `SmartIp::setSession($key, $value)` — the
  session-cached location store.
- `SmartIp::isUserDebugMode($uid = NULL)` — is a fixed debug IP active for this user's role.
- `SmartIp::checkAllowedPage()` — whether the current path is in `allowed_pages`.
- `SmartIp::ipAddressVersion($ip)` — 4 or 6.

## The location object — `smart_ip.smart_ip_location`

Service id **`smart_ip.smart_ip_location`**, class `SmartIpLocation`
(`SmartIpLocationInterface`):

```php
$location = \Drupal::service('smart_ip.smart_ip_location');
$country  = $location->get('country');
$all      = $location->getData();          // full array
$location->set('city', 'Berlin')->save();  // persist to session store
$location->delete();                        // clear stored location
```

- `get($key)` / `set($key, $value)` — one field.
- `getData($update = FALSE)` / `setData(array $values)` — the whole array.
- `save()` — persist to the session-backed store; `delete()` — clear it.
- Source constants: `SmartIpLocationInterface::SMART_IP` (`smart_ip`),
  `GEOCODED_SMART_IP` (`geocoded_smart_ip`), `W3C` (`w3c`).

## Automatic geolocation

`smart_ip.geolocate_user_subscriber` (`GeolocateUserSubscriber`) runs on the kernel request and
geolocates users whose role is in `roles_to_geolocate`, honoring `allowed_pages`, `excluded_ips`,
debug mode and `eu_visitor_dont_save`. So in most code you can just read
`\Drupal::service('smart_ip.smart_ip_location')->getData()` for the current visitor.

## Block / visibility by country — the condition plugin

`Drupal\smart_ip\Plugin\Condition\UserCountry` (condition id **`user_country`**) lets you
show/hide blocks (or anything using the Condition plugin system) based on the visitor's detected
country — configure it in a block's visibility settings ("User country").

## Events (for altering results) — see extend/data-source.md

`SmartIpEvents::DATA_ACQUIRED` (`smart_ip.data_acquired`) is the hook to alter a finished
location; the full event list and how data sources subscribe is in
[../extend/data-source.md](../extend/data-source.md).
