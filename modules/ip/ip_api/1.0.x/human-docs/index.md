# IP API — manual setup guide

**IP API** (`ip_api`) is a thin service wrapper around the
[ip-api.com](https://ip-api.com) geolocation endpoint. It resolves the current
visitor's IP address to details like country, city, region, ISP, coordinates, and
time zone, and hands them back as a typed PHP object your code can read cleanly —
`getCountry()`, `getCountryCode()`, `getCity()`, `getLatitude()`, `getIsp()`,
`getTimezone()`, and so on.

There is no block or admin screen that shows geolocation to visitors — IP API is a
developer tool. You inject the `ip_api.geolocation` service into your own code,
call it, check that the request succeeded, and read the fields you need. Typical
uses are country‑based content or redirects, pre‑filling an address or currency
from the detected location, or logging visitor geography for analytics.

The one thing to configure is an optional API key. Leave it blank and the module
uses ip-api.com's free tier; set a key and it uses the paid `pro.ip-api.com`
host. **Important:** both hosts are contacted over plain, unencrypted `http://`,
so your key and the results travel in the clear — see the Configuration page for
what that means and how to mitigate it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the optional API key and the
   transport‑security caveat.

## Where it lives in the admin menu

The settings form is at **Configuration → System → IP API**
(`/admin/config/system/ip-api`, route `ip_api.settings_form`), gated by the
restricted *Administer ip_api configuration* permission.

## How to use it

Inject `@ip_api.geolocation` into your own service, or call it directly:

```php
/** @var \Drupal\ip_api\IpApiGeolocation $geo */
$geo = \Drupal::service('ip_api.geolocation');
$params = $geo->callIpApi();          // may be NULL on a network error
if ($params && $params->isRequestSuccessful()) {
  $country = $params->getCountry();
  $code    = $params->getCountryCode();
  $city    = $params->getCity();
}
```

Always check `isRequestSuccessful()` before trusting the fields, and handle a
`NULL` return (the service logs network errors and returns without data). Because
the lookup uses the request's client IP, configure trusted‑proxy settings when
you sit behind a proxy so the real IP is used.
