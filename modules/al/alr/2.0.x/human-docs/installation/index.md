# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- No module dependencies, and no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/alr -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/alr -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en alr -y
```

Once enabled, set the redirect destinations — see
[Configuration](../configuration/index.md).
