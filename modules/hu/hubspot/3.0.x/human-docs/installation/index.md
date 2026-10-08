# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- The **Webform** module (`webform`) — a hard dependency. Install
  `drupal/webform` if you don't already have it.
- The **`hubspot/hubspot-php`** library (`^5.3`) and **`psr/http-message`**
  (`^1.1 || ^2.0`), both pulled in automatically when you install with Composer.
- A **HubSpot account** with an OAuth app (you'll need its Client ID, Client
  Secret, and your Portal/Hub ID during configuration).

## Install with Composer

From the project root:

```bash
composer require drupal/hubspot -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the HubSpot PHP
client and update any shared dependencies as needed. If Webform isn't present yet,
add it too: `composer require drupal/webform -W`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/hubspot -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hubspot -y
```

Drupal enables Webform as a dependency at the same time if it isn't already on.

## Next steps

Everything else — entering your HubSpot credentials, connecting via OAuth, turning
on the tracking code, and mapping a webform — happens on the settings page and the
webform's handler screen. See [Configuration](../configuration/index.md).
