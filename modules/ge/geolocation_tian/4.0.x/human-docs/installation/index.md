# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Geolocation** module (`geolocation`, version `^4.0`) — Tian Maps is a
  provider plugin that plugs into Geolocation.
- A **Tianditu App ID** (map key), which you obtain for free from the Tianditu
  developer console at <https://console.tianditu.gov.cn/api/key>. You can install
  the module first and add the key afterward.

There are no third‑party Composer or PHP library requirements. Note that the map
library and tiles are loaded from Tianditu's servers in the visitor's browser.

## Install with Composer

From the project root:

```bash
composer require drupal/geolocation_tian -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Geolocation and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/geolocation_tian -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en geolocation_tian -y
```

Drupal will enable `geolocation` alongside it if it isn't already on.

## Verify it worked

Go to **Configuration → Web services → Tian Maps settings**
(`/admin/config/services/geolocation/tian_maps`). If the settings form loads, the
module is active. Until you add your Tianditu App ID, the site's status report
(`/admin/reports/status`) will warn that no key is configured — that's expected.
Add the key and select Tian Maps on a geolocation field or Views display to see a
live map. Full steps are in [Configuration](../configuration/index.md).
