# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **SDC** (Single Directory Components) module — used to render the
  navigation and loader components.
- The contrib **PWA** module (`pwa`) — DDECK PWA builds on top of it for the
  manifest and service worker. Composer pulls this in as a dependency.

There are no additional PHP or front-end library requirements declared by the
module.

## Install with Composer

From the project root:

```bash
composer require drupal/ddeck_pwa -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the base PWA
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ddeck_pwa -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ddeck_pwa -y
```

Drupal will enable core SDC and the contrib PWA module as dependencies if they
are not already on.

## Verify it worked

1. Confirm the base **PWA** module is configured (its manifest is being served) —
   DDECK PWA relies on it.
2. Visit **Configuration → Web services → DDECK PWA**
   (`/admin/config/services/ddeck-pwa`) and confirm the settings form loads.
3. Load a page on an iOS device (or simulate an iPhone in your browser's device
   tools) and view the page source — you should see the Apple meta tags, and, if
   you've placed the assets, the splash-screen `<link>` tags.

Next, head to [Configuration](../configuration/index.md) to set the app title,
toggle the navigation bar, and add your theme's icons and splash screens.
