# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Core's **User** module (`user`) — always enabled on a standard Drupal site, and
  the module Disable user deletion hooks into.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/disable_user_deletion -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/disable_user_deletion -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en disable_user_deletion -y
```

There are no submodules. Once enabled, nothing changes until you tick at least
one method to hide on the settings form — see
[Configuration](../configuration/index.md).
