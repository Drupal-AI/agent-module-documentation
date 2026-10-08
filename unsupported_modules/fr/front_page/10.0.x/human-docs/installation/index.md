# Installation

## Requirements

Front Page is a small, config‑driven module with no third‑party libraries.

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No extra Composer or PHP library requirements, and no other contrib modules.

## Install with Composer

From the project root:

```bash
composer require drupal/front -W
```

Note the Composer package is `drupal/front` even though the module's machine name
is `front_page`.

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/front -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en front_page -y
```

There are no submodules to consider. Once enabled, nothing happens until you turn
the feature on and configure at least one role redirect — see
[Configuration](../configuration/index.md).
