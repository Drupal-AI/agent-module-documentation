# Installation

## Requirements

- **Drupal 11.2 or later** (`core_version_requirement: ^11.2`).
- Core **System** module (part of every Drupal install).
- No third‑party PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/sql_views -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sql_views -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sql_views -y
```

## Verify it worked

SQL Views has no settings page — confirm it is enabled at **Extend**
(`/admin/modules`). From there you (or a module built on it) can use its API to
integrate native database SQL views into Drupal.
