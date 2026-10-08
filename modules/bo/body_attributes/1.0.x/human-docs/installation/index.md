# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).

There are no third‑party Composer or PHP library requirements. The module
provides an `administer body attributes` permission for controlling access to
its settings.

## Install with Composer

From the project root:

```bash
composer require drupal/body_attributes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/body_attributes -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en body_attributes -y
```

After enabling, grant the **`administer body attributes`** permission to a
trusted role under **People → Permissions**, then enter the classes and
attributes you want — see [How to use it](../index.md#how-to-use-it).
