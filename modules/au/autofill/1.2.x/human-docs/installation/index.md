# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- No contrib dependencies — Autofill uses only Drupal core.

## Install with Composer

From the project root:

```bash
composer require drupal/autofill -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/autofill -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en autofill -y
```

There is no configuration form. Autofill does nothing until you enable it on a
specific field — see [Configuration](../configuration/index.md).
