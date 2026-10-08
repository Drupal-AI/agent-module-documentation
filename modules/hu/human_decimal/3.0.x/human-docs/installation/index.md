# Installation

## Requirements

Human Decimal Formatter is tiny. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), which is part of a standard Drupal install
  and enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/human_decimal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/human_decimal -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en human_decimal -y
```

There is nothing to configure. Once enabled, go to the *Manage display* tab of any
entity with a decimal field and choose **Human decimal** as the field's format —
see the [main guide](../index.md#how-to-use-it).
