# Installation

## Requirements

- **Drupal core `^9.3 || ^10 || ^11`**.
- **Better Exposed Filters** (`better_exposed_filters`) — this module extends it,
  so it must be installed and enabled.

## Install with Composer

From the project root:

```bash
composer require drupal/bef_html5_date -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Better Exposed
Filters and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bef_html5_date -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bef_html5_date -y
```

There is no configuration page. The HTML5 date option appears when you configure
an exposed date filter on a View — see the
[overview](../index.md#how-to-use-it).
