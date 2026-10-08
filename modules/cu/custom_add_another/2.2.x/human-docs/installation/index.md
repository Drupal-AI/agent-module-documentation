# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Field** module (`field`), which is enabled on virtually every Drupal
  site. This is the only dependency.

There are no third-party Composer or PHP library requirements, and the module adds
no permissions of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/custom_add_another -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/custom_add_another -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en custom_add_another -y
```

Once enabled, the two label options appear automatically on the edit form of any
**Unlimited**-cardinality field. There is no configuration form to complete — see
[How to use it](../index.md#how-to-use-it) in the main guide to set your first
custom button labels.
