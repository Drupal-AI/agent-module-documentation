# Installation

## Requirements

Physical Multi Field needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** module (`field`), which is part of a standard Drupal install.
- The **[Physical](https://www.drupal.org/project/physical)** module
  (`physical`), which provides the weight and volume unit definitions and the
  conversion maths this module builds on. Composer pulls it in as a dependency.

There are no other third‑party library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/physical_multi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it also brings in the required Physical module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/physical_multi -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en physical_multi -y
```

Enabling `physical_multi` also enables its **Physical** dependency if it isn't
already on.

## Verify it worked

Go to any content type's **Manage fields**, click **Add field**, and confirm that
**Quantity (weight, volume, count, or size)** appears in the field‑type list.
Add it, choose which measurement types to allow on its storage settings form, and
try entering a value — see "How to use it" in the [overview](../index.md) for the
full field, widget, and formatter walk‑through.
