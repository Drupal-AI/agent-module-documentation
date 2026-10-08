# Installation

## Requirements

- **Drupal 8, 9 or 10** (`core_version_requirement: ^8 || ^9 || ^10`).

There are no dependent modules, no submodules, and no third-party PHP or JavaScript
library requirements — the JavaScript ships with the module itself.

## Install with Composer

From the project root:

```bash
composer require drupal/same_height -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/same_height -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en same_height -y
```

Enabling the module makes the `same_height/same_height` library available — it does
nothing on its own until a template attaches that library and points it at some
elements.

## Verify it worked

There is no settings page to check. To confirm it works, attach the library in a
template over a row of items of differing content length (see the main guide's
example) and load the page: the items in each targeted group should now line up to
the same height, and stay aligned as you resize the window.
