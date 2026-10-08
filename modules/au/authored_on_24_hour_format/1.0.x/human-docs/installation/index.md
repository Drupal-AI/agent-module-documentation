# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).

The module has no other module dependencies and no third-party Composer library
requirements — it is a single module file plus one JavaScript asset.

## Install with Composer

From the project root:

```bash
composer require drupal/authored_on_24_hour_format -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/authored_on_24_hour_format -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en authored_on_24_hour_format -y
```

There is no configuration. After enabling, **clear caches** so the JavaScript
library attaches (`drush cr`), then check any node add/edit form — the *Authored
on* time widget will use a 24-hour format.
