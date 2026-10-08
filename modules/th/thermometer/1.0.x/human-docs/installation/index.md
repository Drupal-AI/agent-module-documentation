# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other modules, PHP extensions, or third-party libraries are required — the
  thermometer is drawn with plain CSS and JavaScript.

## Install with Composer

From the project root:

```bash
composer require drupal/thermometer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/thermometer -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en thermometer -y
```

## Verify it worked

Go to **Structure → Block layout** (`/admin/structure/block`) and place the
**Thermometer** block in a region. Set a target and a current value in the block
configuration, save, and visit a page in that region — you should see the
thermometer filled to reflect the current amount against the goal.
