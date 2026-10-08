# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Filter** module (`filter`), which is part of a standard Drupal
  install. Drupal enables it automatically as a dependency if it is not already
  on.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/auto_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/auto_link -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en auto_link -y
```

That is all it takes. There is no configuration screen — to start using it, pick
the **Auto Link** formatter on a field's **Manage display** screen as described
on the [overview page](../index.md).
