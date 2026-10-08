# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

That's it — there are **no module dependencies** and no third-party Composer or PHP
libraries. Although it is packaged under LocalGov Drupal, it runs on any Drupal site.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_menu_link_group -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_menu_link_group -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_menu_link_group -y
```

## After enabling

Nothing changes visibly until you create a group. Head to
[Configuration](../configuration/index.md) to make your first menu link group.
