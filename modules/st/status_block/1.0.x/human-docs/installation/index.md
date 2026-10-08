# Installation

## Requirements

Status Block needs only **Drupal 10 or 11** (`core_version_requirement:
^10 || ^11`). There are no additional modules, third-party Composer packages, or
PHP libraries required.

## Install with Composer

From the project root:

```bash
composer require drupal/status_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/status_block -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en status_block -y
```

## After installing

The bar does not appear until you place the block and grant the viewing
permission. Go to **Structure → Block layout**, add the Status Block to a region,
configure it, and grant **view status blocks** to the relevant roles. See
[Configuration](../configuration/index.md) for the walkthrough.
