# IP2Location — manual setup guide

**IP2Location** (`ip2location`) works out a visitor's geographic location from
their IP address using a **local IP2Location BIN database** — a file you download
and store on the server — and caches the result in the visitor's session so other
code can reuse it. Because the lookup happens against a local database file,
there are no per‑request API calls to a third party; you supply the data file and
the module reads it.

On each request an event subscriber checks the session: if there's no cached
geolocation yet, it opens the BIN database, looks up the visitor's client IP, and
stores the full record as JSON in the session. Your own modules and themes then
read it back through the helper function `ip2location_get_records()`. Depending on
the edition of the BIN file you use (the free LITE database or a commercial DBn),
the record can contain anything from the country and city up to ISP, ASN, usage
type, time zone, coordinates, and more.

This module comes from IP2Location themselves, the official provider. It ships
*without* a database file — you download a free LITE or a commercial BIN from
their site and point the module at it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the required
   PHP library with Composer, and get a BIN database.
2. [Configuration](configuration/index.md) — point the module at your BIN file
   and choose a cache mode.

## Where it lives in the admin menu

The settings form is at **Configuration → System → IP2Location Settings**
(`/admin/config/system/ip2location`, route `ip2location.admin_settings`), gated
by the *Administer site configuration* permission.

## How to use it

Once the database path is set, read the visitor's geolocation anywhere in code:

```php
$geo = ip2location_get_records();
if ($geo) {
  $country = $geo->country_code;   // e.g. 'US'
  $city    = $geo->city_name;
  $lat     = $geo->latitude;
  $lon     = $geo->longitude;
}
```

The value is cached per session, so it reflects the IP of the first request that
populated it, and it returns nothing if the database is missing or the lookup
failed. Because the location is derived from the client IP as Drupal computes it,
make sure your reverse‑proxy / trusted‑host settings are correct when the site
sits behind a proxy or CDN, or the detected location may be wrong.
