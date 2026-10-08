# Installation

## Requirements

Token Filter is small but has one contrib dependency:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- Core's **Filter** module (`filter`), part of a standard install.
- The **Token** module (`drupal/token`, `^1`) — a contrib dependency that Composer
  installs automatically. It powers entity/global token resolution and the CKEditor 5
  token browser.

There are no other third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/token_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Token module and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/token_filter -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable Token Filter (Drush will enable the Token dependency for you):

```bash
drush en token_filter -y
```

Enabling the module does **not** expand tokens anywhere yet — you must turn the
filter on for each text format where you want it. Head to
[Configuration](../configuration/index.md) to do that.
