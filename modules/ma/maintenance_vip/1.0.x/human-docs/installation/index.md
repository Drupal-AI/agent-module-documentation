# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`).
- No other contributed modules or external libraries — the module is
  self-contained and integrates with Drupal core's maintenance-mode service.

## Install with Composer

From the project root:

```bash
composer require drupal/maintenance_vip -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/maintenance_vip -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en maintenance_vip -y
```

No cache rebuilds or extra permissions are needed just to manage the token — the
module is ready to configure as soon as it's enabled.

## Verify it worked

Go to **Configuration → Development → Maintenance VIP**
(`/admin/config/development/maintenance-vip`) and set a secret token (see
[Configuration](../configuration/index.md)). Then put the site into maintenance
mode, visit `https://yoursite.com/vip/<your-token>` in a fresh/incognito browser,
and confirm you can browse the site while a browser *without* the token still
sees the maintenance page. Visit `/vip-logout` to confirm the bypass ends.
