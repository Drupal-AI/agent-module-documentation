# IPstack — manual setup guide

**IPstack** (`ipstack`) integrates the [ipstack.com](https://ipstack.com/)
IP‑geolocation API (formerly FreeGeoIP) so your site can look up where a visitor is
based on their IP address — country, region, and city. It is the plumbing other
code builds on: you geolocate an IP from your own module or feature and use the
result for geo‑targeting, analytics, or personalisation.

Setup is short. You obtain an **API access key** from ipstack.com, save it in the
module's configuration, and then use the built‑in **testing page** to confirm
lookups work. IPstack supports HTTPS and caches results so repeated lookups of the
same IP do not hit the API every time.

Two things are worth keeping in mind. First, this module **sends IP addresses to
ipstack**, a third-party service — and an IP address is personal data under some
privacy regimes, so treat this as outbound data sharing you may need to disclose.
Second, the access key is a **secret**: store it via an environment variable rather
than committing it, and always use HTTPS. Beyond its own permission, the module has
no access-control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — store the access key securely, enter
   it, and use the test page.

## Where it lives in the admin menu

The settings and the testing page live under **Configuration → System → IPstack**
(`/admin/config/system/ipstack`). The test page is at
`/admin/config/system/ipstack/test/page?ip=<IP address>`.

## How to use it

Once configured, developers call the service to geolocate an address, for example:

```php
$ipstack = \Drupal::service('ipstack');
$ipstack->setIp('134.201.250.155')->setFields('country_code')->setOutput('json');
$data = $ipstack->getData();
```

Prefer dependency injection over the static `\Drupal::service()` call in real code.
There is also a companion **IPstack Block** project if you want a ready-made block.
