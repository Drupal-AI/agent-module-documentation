# Installation

## Requirements

- **Drupal core `^9.4 || ^10 || ^11`**.
- **Better Exposed Filters** (`better_exposed_filters`) — this module extends it,
  so it must be installed and enabled.

## Install with Composer

From the project root:

```bash
composer require drupal/bef_entity_select_buttons -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Better Exposed
Filters and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bef_entity_select_buttons -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bef_entity_select_buttons -y
```

There is no configuration page. The button widget appears as an option when you
configure an exposed bundle/type filter on a View — see the
[overview](../index.md#how-to-use-it).
