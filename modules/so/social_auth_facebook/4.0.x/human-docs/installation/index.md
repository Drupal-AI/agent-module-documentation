# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- **PHP 8.1 or newer**.
- The **Social Auth** module (`drupal/social_auth`, `^4.1`) and, transitively,
  **Social API** — these provide the shared login framework this module plugs into.
- The **`league/oauth2-facebook`** PHP library (`^2.0`) — the OAuth2 client.

Installing the module with Composer (below) pulls in Social Auth and the
`league/oauth2-facebook` library automatically, so you do not fetch them
separately.

## Install with Composer

Always install this module with Composer so its dependencies come along. From the
project root:

```bash
composer require drupal/social_auth_facebook -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_auth_facebook -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it (Drush will enable Social Auth and Social API as dependencies too):

```bash
drush en social_auth_facebook -y
```

## Next: configure it

Enabling the module is not enough on its own — the Facebook button won't work until
you create a Facebook app and enter the App ID and secret. Continue with
[Configuration](../configuration/index.md).
