# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** module (always present on a standard site) — the options add fields
  to the `node` entity. The bulk action and Views integration use core's Node and
  Views modules.

There are no third-party Composer libraries to install, and no other contrib
dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_pub -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/custom_pub -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_pub -y
```

Enabling the module adds the **Custom Publishing Options** admin page but does not
create any options yet — you define those yourself. Head to
[Configuration](../configuration/index.md) to create your first publishing option and
grant the relevant permissions.
