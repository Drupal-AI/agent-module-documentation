# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other module dependencies.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/happy_new_year -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/happy_new_year -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en happy_new_year -y
```

The decoration appears according to the module's settings — set the active time
interval and appearance options in [Configuration](../configuration/index.md).

## Verify it worked

Visit a front-end page during the module's active date range: you should see a
garland and falling snow. If nothing appears, check the active **time interval**
in the settings — the decoration only shows within the dates you set. When the
season's over, either let the interval lapse or disable the module.
