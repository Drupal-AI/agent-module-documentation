# Installation

## Requirements

- **Drupal 8.8.4, 9, 10, or 11** (`core_version_requirement: ^8.8.4 || ^9 || ^10 || ^11`).
- A **Sightengine account** — register before using the module. You will need the app's
  **API user** (`client_id`) and **API secret** (`client_secret`).

There are no other Drupal module dependencies and no third-party PHP library
requirements declared.

## Install with Composer

From the project root:

```bash
composer require drupal/sightengine -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sightengine -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sightengine -y
```

## Next step

Enabling the module does nothing on its own — you must enter your Sightengine
credentials, choose which models to run, and turn moderation on for the fields you want
checked. Continue to [Configuration](../configuration/index.md).
