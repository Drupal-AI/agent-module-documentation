# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8||^9||^10||^11`).
- No other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/field_attribute -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. (To pin the 2.x branch specifically you can use
`composer require drupal/field_attribute:^2.0`.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_attribute -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_attribute -y
```

You can also enable it from the **Extend** page (`/admin/modules`).

## Verify it worked

Go to **Manage display** for any entity with a text field, open a field's formatter
settings (the gear icon), and you should see the extra attribute options that
Field Attribute adds. See the [overview](../index.md#how-to-use-it) for how to use
them.
