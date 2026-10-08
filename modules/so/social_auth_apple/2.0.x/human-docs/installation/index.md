# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- **PHP 8** or newer.
- The **Social Auth** module (`drupal/social_auth ^4`) — this module is a network
  plugin for it and cannot work without it.
- The **`patrickbussmann/oauth2-apple`** PHP library (`^0.4`), which provides the
  Apple OAuth2 client. Composer installs it automatically when you require the
  module.

## Install with Composer

From the project root:

```bash
composer require drupal/social_auth_apple -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Apple OAuth2
library and update any shared dependencies (including Social Auth) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_auth_apple -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_auth_apple -y
```

Drupal enables Social Auth as a dependency at the same time.

## After enabling

The Apple button will not appear until you configure credentials. Head to
[Configuration](../configuration/index.md) to complete the Apple Developer portal
setup, drop the `.p8` key file into place, and fill in the settings form.
