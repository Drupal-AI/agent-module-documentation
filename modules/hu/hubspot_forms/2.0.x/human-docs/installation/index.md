# Installation

## Requirements

- **Drupal 10.6, 11.3, or 12** (`core_version_requirement: ^10.6 || ^11.3 ||
  ^12`).
- Core's **Block** module (`block`) and **Field** module (`field`) — both are
  required dependencies and Drupal enables them automatically.
- A **HubSpot account** with either a Private App access token (plus your Portal
  ID) or a legacy API key. You enter these during configuration.

There are no third-party Composer or PHP library requirements — the only
external dependency is the HubSpot API.

## Install with Composer

From the project root:

```bash
composer require drupal/hubspot_forms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/hubspot_forms -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en hubspot_forms -y
```

The module ships no submodules. Nothing can be embedded until you connect a
HubSpot account — head to [Configuration](../configuration/index.md) next.
