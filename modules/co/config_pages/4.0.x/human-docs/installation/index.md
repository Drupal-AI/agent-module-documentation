# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
  Version 4.0 drops Drupal 8/9 support and adds Drupal 12.
- Core's **Text** module (`text`), enabled automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_pages -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/config_pages -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_pages -y
```

The module ships **no submodules**. It also provides Drush commands for reading
and writing field values from the command line (`drush cpgfv` to get a value,
`drush cpsfv` to set one).

## Verify it worked

Log in as an administrator and go to **Structure → Config pages**
(`/admin/structure/config_pages`). You should see the (initially empty) Config
pages library with an **Add config page** button. Creating your first type is the
next step — see [Configuration](../configuration/index.md).
