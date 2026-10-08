# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Field** module (`field`), which is part of a standard install and is
  enabled automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/heading -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require drupal/heading -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en heading -y
```

## Verify it worked

- On a content type's **Manage fields** page, click **Add field** and confirm
  **Heading** appears as a field type.
- On a **Manage display** page, confirm that **string** and **text** fields offer a
  **Heading** format.

See the [overview](../index.md#how-to-use-it) for how to configure the field's
allowed sizes and the `heading_text` formatter's size. There is no other setup.
