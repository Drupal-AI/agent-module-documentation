# Installation

## Requirements

- **Drupal 10.1 or newer, or 11** (`core_version_requirement: ^10.1 || ^11`; the
  Composer package requires `drupal/core ^10.3 || ^11`).
- **PHP 8.1 or newer**.
- Core's **User** module (`user`), which is always present.

There are no third‑party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_bundle_permissions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_bundle_permissions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_bundle_permissions -y
```

There are no submodules.

> **Important:** the moment this module is enabled it begins restricting access —
> every role only reaches a bundle it has been granted the permission for. Right
> after enabling, go to **People → Permissions** and grant the bundle permissions
> your roles need (and/or add entity types to the exclusion list), so you don't
> accidentally block editors from their content. See
> [Configuration](../configuration/index.md).
