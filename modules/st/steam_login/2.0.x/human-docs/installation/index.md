# Installation

## Requirements

Steam Login needs:

- **Drupal 11** (`core_version_requirement: ^11`).
- The **Steam API** module (`steam_api`), which provides the Steam Web API key and
  player lookups. Composer pulls it in automatically as a dependency.
- A **Steam Web API key** (configured through the Steam API module).

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root — this also fetches the Steam API dependency:

```bash
composer require drupal/steam_login -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/steam_login -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the modules

```bash
drush en steam_api steam_login -y
```

Enabling Steam Login automatically adds two fields to the user profile:
`field_steam64id` and `field_steam_username`.

## After installing

The login is not usable until you complete three setup steps: set the Steam API
key, adjust account-registration settings, and place the Steam OpenId block. See
[Configuration](../configuration/index.md).
