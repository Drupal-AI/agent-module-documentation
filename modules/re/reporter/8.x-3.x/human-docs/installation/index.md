# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other modules are required.

There are no third‑party Composer or PHP library requirements.

> **Note:** This project is minimally maintained and does **not** have official
> security-advisory coverage. Because reports are raw SQL against your database,
> only trusted administrators should be allowed to create or edit them.

## Install with Composer

From the project root:

```bash
composer require drupal/reporter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/reporter -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en reporter -y
```

The module comes with a handful of **example reports** already defined, so you can
see how it works immediately.

## Verify it worked

Log in as an administrator and open the reports listing page — you should see the
canned example reports. Open the report editor to add your own, or to delete or
modify the examples. See [Configuration](../configuration/index.md) for the
details.
