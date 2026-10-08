# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other contributed modules — it builds on Drupal core's maintenance mode.

## Install with Composer

From the project root:

```bash
composer require drupal/maintenance_mode_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/maintenance_mode_redirect -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.
>
> Install a stable release for production — do not use development versions on
> live sites.

## Enable the module

```bash
drush en maintenance_mode_redirect -y
```

## Verify it worked

Go to **Configuration → Development → Maintenance mode**
(`/admin/config/development/maintenance`). You should see a new checkbox to
enable the redirect and a **Redirect URL** field. See
[Configuration](../configuration/index.md) to set them, then test by turning on
maintenance mode and visiting the site as an anonymous user — you should be sent
to your configured URL.
