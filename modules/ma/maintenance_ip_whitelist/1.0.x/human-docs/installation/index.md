# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No other contributed modules — it decorates Drupal core's maintenance-mode
  service.

## Install with Composer

From the project root:

```bash
composer require drupal/maintenance_ip_whitelist -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/maintenance_ip_whitelist -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en maintenance_ip_whitelist -y
```

## Verify it worked

Go to **Configuration → Development → Maintenance mode**
(`/admin/config/development/maintenance`). You should see a new **IP whitelist**
textarea on the form. See [Configuration](../configuration/index.md) to add your
allowed addresses, then test by putting the site in maintenance mode and
confirming a whitelisted IP can still browse anonymously while others cannot.
