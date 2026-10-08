# Installation

## Requirements

- **Drupal 9.4+, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).

There are no module dependencies, no third-party Composer packages, and no PHP
library requirements — the module simply overrides Drupal's core maintenance-mode
service.

## Install with Composer

From the project root:

```bash
composer require drupal/maintenance_exempt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/maintenance_exempt -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en maintenance_exempt -y
```

That's all. Nothing changes until you fill in the exemptions — with empty
configuration the module behaves exactly like core Drupal.

## Next step

Set up your exemptions on the core maintenance-mode form — continue to
[Configuration](../configuration/index.md).
