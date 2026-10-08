# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no third‑party Composer or PHP library requirements. The module
provides its own permission for controlling who may set body classes.

## Install with Composer

From the project root:

```bash
composer require drupal/body_class -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/body_class -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en body_class -y
```

After enabling, grant the Body Class permission to your trusted editor roles
under **People → Permissions**, then set a per‑node class when editing content —
see [How to use it](../index.md#how-to-use-it).
