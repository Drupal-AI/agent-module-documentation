# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No other module dependencies, and no third-party Composer or PHP library
  requirements.

If your site runs behind a reverse proxy or CDN, configure Drupal's trusted proxy
settings (in `settings.php`) so BotShield's IP-based rate limiting and blocking
see the real client IP rather than the proxy's address. This is not a hard
install requirement, but the module's protection is only accurate once it is in
place.

## Install with Composer

From the project root:

```bash
composer require drupal/botshield -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/botshield -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en botshield -y
```

After enabling, grant the module's permissions to your administrators and open
the [settings form](../configuration/index.md) to configure classification, rate
limits, and blocking.
