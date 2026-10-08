# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No other Drupal modules or third‑party Composer libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_limit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_limit -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_limit -y
```

Or enable **Entity Limit** from *Extend* (`/admin/modules`).

There are no submodules. After enabling, grant the **Administer entity limit**
permission to the roles that should manage caps (People → Permissions), then create
your first limit at **Structure → Entity Limit** — see
[Configuration](../configuration/index.md).
