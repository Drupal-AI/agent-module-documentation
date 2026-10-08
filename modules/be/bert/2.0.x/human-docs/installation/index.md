# Installation

## Requirements

- **Drupal core `^8 || ^9 || ^10 || ^11`**.
- Core **System** (`system`) — the only dependency, and always present.

There are no Composer library or other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/bert -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bert -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bert -y
```

There is no configuration page. Select the widget on an entity reference field
under **Manage form display** — see the [overview](../index.md#how-to-use-it).
