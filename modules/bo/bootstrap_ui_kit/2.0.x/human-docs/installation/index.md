# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A **theme that exposes its design values** as CSS custom properties or
  Bootstrap SCSS variables, so the kit's components can inherit them. A theme that
  hard-codes colours in compiled CSS leaves the kit nothing to inherit from.

There are no third-party Composer or PHP library requirements, and no other module
dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/bootstrap_ui_kit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bootstrap_ui_kit -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bootstrap_ui_kit -y
```

After enabling, open the kit's settings form to review its options — see
[Configuration](../configuration/index.md).
