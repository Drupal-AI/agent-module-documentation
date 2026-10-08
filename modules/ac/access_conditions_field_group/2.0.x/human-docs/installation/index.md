# Installation

## Requirements

Access Conditions Field Group needs:

- **Drupal 8, 9 or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- **[Access Conditions](https://www.drupal.org/project/access_conditions)**
  (`access_conditions`) — provides the reusable access models the setting reads.
- **[Field Group](https://www.drupal.org/project/field_group)** (`field_group`),
  version **3.x or newer** — supplies the field groups this module extends.

Composer pulls both in as dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/access_conditions_field_group -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/access_conditions_field_group -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en access_conditions_field_group -y
```

There is no separate settings page. Once enabled, the **Visible to certain access
models** setting appears on every field group's format settings — see the
[main guide](../index.md#how-to-use-it) for how to use it.
