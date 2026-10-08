# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Smart IP** module (`smart_ip`) — essential, as it resolves a visitor's
  country from their IP address. Smart IP itself needs a configured data source
  (for example a GeoIP database), so plan to set that up as part of installation.

There are no third‑party Composer or PHP library requirements beyond Smart IP.

## Install with Composer

From the project root:

```bash
composer require drupal/country_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Smart IP and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/country_block -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en country_block -y
```

This also enables Smart IP if it is not already on.

## Configure Smart IP first

Before Country Block can identify anyone's country, **Smart IP must be working**.
Follow the Smart IP module's own installation and configuration instructions to set
up and keep current a GeoIP data source. It's highly recommended to keep that GeoIP
database up to date so country detection stays as accurate as possible.

## Verify it worked

With Smart IP configured, go to **Configuration → System → Country Block**
(`/admin/config/system/country-block`) and confirm the settings form appears. Then
follow [Configuration](../configuration/index.md) to add blocked countries.
