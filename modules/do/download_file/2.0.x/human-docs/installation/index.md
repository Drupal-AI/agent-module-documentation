# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10.0 || ^11`).
- Core's **File** (`file`) module, which provides file fields and file entities.
  It is enabled automatically as a dependency.
- At least one **file field** to apply the formatter to.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/download_file -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/download_file -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en download_file -y
```

That is all the setup there is. There is no configuration page — to use it, set a
file field's format to **Direct Download** on the entity's **Manage display**
screen, as described in the "How to use it" section of the
[overview](../index.md).

There are no submodules.
