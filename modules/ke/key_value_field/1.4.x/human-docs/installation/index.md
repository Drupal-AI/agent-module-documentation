# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core's **Text** module (`text`) — it is the base for the *Key / Value (long)*
  field type, and Drupal enables it automatically as a dependency when you turn on
  Key/Value Field.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/key_value_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/key_value_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en key_value_field -y
```

Once enabled, the two **Key / Value** field types appear in the field list when
you add a field to any bundle. See the *How to use it* section on the
[overview page](../index.md) to add and configure one.
