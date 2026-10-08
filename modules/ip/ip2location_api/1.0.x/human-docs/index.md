# IP2Location API — manual setup guide

**IP2Location API** (`ip2location_api`) is a lightweight wrapper that gives your
code a Drupal **service** for looking up geolocation through the hosted
[IP2Location.io](https://www.ip2location.io) API. Unlike its sibling the
[IP2Location](https://www.drupal.org/project/ip2location) module — which reads a
local BIN database you download and keep updated — this module calls
IP2Location's online API with an API key, so there is no database file to
maintain.

The service can geolocate the current request or a specific IP address you pass
it, and it includes two convenience helpers for the common cases: getting the
country code and the country name. It's built for developers — you inject the
service into your own code and call it; there is no ready‑made block or screen.

Setup has two parts you do through the UI: save your IP2Location API key as a
**Key** entity (this module depends on the Key module so your secret is never
stored in plain configuration), then select that key on the module's settings
page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Key
   dependency with Composer, then enable it.
2. [Configuration](configuration/index.md) — create your API key as a Key entity
   and select it in the module's settings.

## Where it lives in the admin menu

The settings page is at **Configuration → System → IP2Location settings**
(`/admin/config/system/ip2location-settings`), where you pick the Key that holds
your API key. See [Configuration](configuration/index.md).

## How to use it

Once configured, inject the service and call it from your own code:

```php
// With the service injected as $this->ip2LocationAPI:
$countryName = $this->ip2LocationAPI->getCountryName();
```

That returns the country name for the current request's IP. The service can also
geolocate a specific IP you supply. Note there is currently only very simple,
in‑request caching, so avoid looking up the same IP repeatedly in a single
request path.
