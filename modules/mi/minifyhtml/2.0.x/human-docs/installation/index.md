# Installation

## Requirements

Minify Source HTML is lightweight. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **System** module (`system`), which is always present on a Drupal site.

There are no third-party Composer packages or PHP libraries to install. To get
the most benefit you will usually also want Drupal's core **Internal Page Cache**
module enabled for anonymous traffic, but that is a recommendation, not a
dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/minifyhtml -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/minifyhtml -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en minifyhtml -y
```

Enabling the module does **not** start minifying anything — minification is off
by default. Head to [Configuration](../configuration/index.md) to turn it on.

There are no submodules.
