# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- No modules outside Drupal core are required, and there are no third‑party PHP
  library requirements.

This is the 2.0.5 release, covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/config_suite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_suite -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_suite -y
```

## Verify it worked

Log in as an administrator with the `administer config suite` permission and open
**Configuration → Config Suite** (`/admin/config/config_suite/admin_settings`). The
settings screen should load. To confirm the automation, change and save a
configuration form, then check your config sync folder — the corresponding file
should have been updated automatically.

Next, review [Configuration](../configuration/index.md) to understand how the
automatic import and export behaviour is controlled.
