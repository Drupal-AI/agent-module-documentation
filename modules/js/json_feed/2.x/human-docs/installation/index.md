# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 7.4 or newer**.
- Core's **Views** module (`views`), which Drupal enables automatically as a
  dependency.

There are no third-party Composer libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/json_feed -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/json_feed -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en json_feed -y
```

The module adds no menu items or settings pages of its own — it simply makes the
**JSON Feed** display, style, and row plugins available inside Views. Continue to
[Configuration](../configuration/index.md) to publish your first feed.
