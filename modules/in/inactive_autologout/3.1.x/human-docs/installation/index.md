# Installation

## Requirements

Inactive Autologout needs only **Drupal 9, 10, or 11**
(`core_version_requirement: ^9 || ^10 || ^11`). It has no Composer dependencies,
no PHP extension requirements, and no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/inactive_autologout -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/inactive_autologout -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en inactive_autologout -y
```

Enabling the module does **not** start logging anyone out — the feature ships
disabled. You must turn it on and set an idle timeout on the settings form. See
[Configuration](../configuration/index.md).
