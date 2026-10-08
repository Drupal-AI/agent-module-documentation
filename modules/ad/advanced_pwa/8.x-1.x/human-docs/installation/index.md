# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- **HTTPS.** Progressive Web Apps and web push only work on a secure connection —
  browsers refuse to register a service worker or accept push subscriptions over
  plain HTTP.
- A pair of **VAPID keys** for web push, which you enter in the module's settings
  (see [Configuration](../configuration/index.md)).

There are no other module dependencies and no third-party Composer requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/advanced_pwa -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/advanced_pwa -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advanced_pwa -y
```

Once enabled, the manifest is served at `/manifest.json` and the service worker at
its own route. Head to [Configuration](../configuration/index.md) to fill in the
manifest details and push keys.

## Optional submodule

**Advanced PWA Unregister** (`advanced_pwa_unregister`) ships alongside the main
module. Enable it only if you need its behaviour:

```bash
drush en advanced_pwa_unregister -y
```
