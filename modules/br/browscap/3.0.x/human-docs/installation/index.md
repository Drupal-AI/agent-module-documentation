# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11**
  (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No other module dependencies.
- The site needs to be able to **download the browscap data file** from the Browser
  Capabilities Project so the module can refresh its local copy.

## Install with Composer

From the project root:

```bash
composer require drupal/browscap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/browscap -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en browscap -y
```

After enabling, visit the settings page to confirm the data source and let the
module download the browscap data — see [Configuration](../configuration/index.md).
