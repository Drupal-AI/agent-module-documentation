# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).

There are no third‑party Composer or PHP library requirements. It builds on core's
node access system.

## Install with Composer

From the project root:

```bash
composer require drupal/protected_nodes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/protected_nodes -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en protected_nodes -y
```

## Verify it worked

After enabling, head to [Configuration](../configuration/index.md) to choose which
content types can be protected, grant the permissions, and add the protection control
to the node form. Until you do that, nodes are not yet protected.
