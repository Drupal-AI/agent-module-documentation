# Installation

## Requirements

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- The JavaScript libraries the scanner uses — **Quagga2** and the **WebRTC
  adapter** — which are installed automatically as part of the standard Composer
  installation.

There are no module dependencies. Note this project is **not covered by Drupal's
security advisory policy**, and this release is a beta — test it before relying on
it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/scan_code -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. All required libraries are installed automatically.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/scan_code -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scan_code -y
```

## Verify it worked

Open the module's settings page (route `scan_code.admin_config`) and confirm it
loads. Then enable the scan capability on a text field and check that, when
editing that field, you can start a scan and the browser prompts for camera
access. See [Configuration](../configuration/index.md).
