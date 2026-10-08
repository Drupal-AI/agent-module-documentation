# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are no third‑party Composer or PHP library requirements, and no other module
dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/prototype_select -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/prototype_select -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en prototype_select -y
```

## Verify it worked

Load a page with a `<select>` dropdown and confirm the accessible enhancements (keyboard
navigation and screen‑reader support) are in effect. There is no configuration to do —
the module works once enabled.
