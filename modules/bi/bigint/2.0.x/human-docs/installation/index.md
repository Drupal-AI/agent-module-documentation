# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Field** module (`field`) enabled — the only dependency, and part of Drupal core
  (it is on by default on virtually every site).
- A database that supports a 64-bit integer column (MySQL/MariaDB and PostgreSQL both do —
  the field defines a `BIGINT`/`bigint` column).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bigint -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bigint -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bigint -y
```

Once enabled, **Number (bigint)** appears as a field type wherever you add fields. There is
no settings page — see the [main page](../index.md#how-to-use-it) for how to add and
configure a bigint field.
