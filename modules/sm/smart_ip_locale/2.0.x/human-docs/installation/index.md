# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Smart IP** module (`smart_ip`) — this provides the geolocation lookup and
  is a hard dependency. Install and configure it first (Smart IP needs a data
  source, such as a GeoIP database or web service, to resolve IPs to countries).
- **Best used with:** the **Language Cookie** module, so a resolved language is
  remembered in a cookie instead of being re-derived from the IP on every request.

There are no third-party PHP library requirements for this module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/smart_ip_locale -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Smart IP and any
other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/smart_ip_locale -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smart_ip_locale -y
```

Drush will enable Smart IP as a dependency if it is not already on.

## Next step

Enabling the module does nothing on its own — you must turn on and configure the
detection method. Continue to [Configuration](../configuration/index.md).
