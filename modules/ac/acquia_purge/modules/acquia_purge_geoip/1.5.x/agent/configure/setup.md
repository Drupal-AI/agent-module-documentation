# Setup — Acquia Purge GeoIP

No configuration, no admin UI, no permissions, no config schema. `configure` route is `null`.

## Enable

```
drush en acquia_purge_geoip --yes
```

## What it does

Registers one service, `acquia_purge_geoip_subscriber`
(`Drupal\acquia_purge_geoip\EventSubscriber\SetVaryHeader`), tagged `event_subscriber`. On the
kernel `RESPONSE` event its `onRespond()` sets:

```
Vary: X-Geo-Country
```

`X-Geo-Country` is populated by Acquia Cloud's edge GeoIP layer, so declaring it in `Vary` makes
Varnish (and the Platform CDN) cache a separate variant per visitor country. Enable only when
your site actually differs by country — varying the cache reduces the hit rate.

There is nothing else to set; uninstall the submodule to remove the header.
