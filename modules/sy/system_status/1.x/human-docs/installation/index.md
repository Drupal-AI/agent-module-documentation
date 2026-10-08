# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- A monitoring dashboard (such as Lumturio) to register the site with, if you want
  the endpoint to be useful.
- For the payload to be encrypted on the way to the monitoring client, the server
  needs **openssl** available.
- No dependent Drupal modules or external Composer libraries are listed as required.
- This branch is a **dev** release — test before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/system_status -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/system_status -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en system_status -y
```

## Verify it worked

Visit **Configuration → System → System Status**
(`/admin/config/system/system_status`) and confirm the settings page loads and shows
your site UUID. See [Configuration](../configuration/index.md) to register the site.
