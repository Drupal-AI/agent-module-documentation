# Installation

## Requirements

Reference Blocked Users is deliberately tiny. It needs:

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **User** module, which is always enabled on a standard Drupal site.

There are no third‑party Composer packages, PHP library requirements, or contrib
dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/reference_blocked_users -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/reference_blocked_users -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en reference_blocked_users -y
```

There are no submodules. After enabling, grant the **Reference blocked users**
permission to the roles that need it — see
[How to use it](../index.md#how-to-use-it).
