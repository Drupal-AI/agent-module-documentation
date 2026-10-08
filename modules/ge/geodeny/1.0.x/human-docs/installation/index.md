# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- The **ip2country** module (`ip2country`), which supplies the IP‑to‑country
  geolocation database and lookup service GeoDeny relies on. You'll need to
  populate its database after enabling it (see below).
- A correct **reverse‑proxy / trusted‑proxy** configuration in `settings.php` if
  your site sits behind a proxy or CDN — otherwise the client IP GeoDeny reads may
  be the proxy's, not the visitor's, and blocking will be inaccurate.

## Install with Composer

From the project root:

```bash
composer require drupal/geodeny -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in `ip2country` and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/geodeny -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en geodeny -y
```

Drupal will enable `ip2country` alongside it if it isn't already on.

## Set up the geolocation database

GeoDeny can only block accurately once **ip2country** has data to look up. After
enabling, configure ip2country (at its own settings page under **Configuration →
People → IP-based determination of country**) and import/update its database so
that IP addresses resolve to countries. Without this, lookups fail and — because
GeoDeny fails open — visitors are not blocked.

## Verify it worked

Go to **Configuration → Web services → GeoDeny**
(`/admin/config/services/geodeny`). If the settings form loads, the module is
active. Add a country to the block list (see [Configuration](../configuration/index.md)),
then confirm that a request from that country receives an HTTP 400 while other
traffic is unaffected. Remember that geolocation is approximate and can be evaded
with a VPN — this is a coarse deterrent, not a hard boundary.
