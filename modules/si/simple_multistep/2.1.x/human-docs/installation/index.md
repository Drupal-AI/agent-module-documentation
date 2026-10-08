# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The contributed **Field Group** module (`drupal/field_group`, `^3.0 || ^4.0`) —
  a hard dependency that Composer pulls in. Simple Multistep's "Form step" is a
  Field Group format.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_multistep -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Field Group.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/simple_multistep -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_multistep -y
```

Drupal will enable **Field Group** as a dependency if it isn't already on. There's
no settings page — head to an entity's **Manage form display** to build your first
wizard, as described in [Configuration](../configuration/index.md).
