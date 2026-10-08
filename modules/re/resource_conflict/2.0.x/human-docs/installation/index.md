# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Node** and **Datetime Range** (`datetime_range`) modules — Datetime
  Range provides the Date range field the module checks. Drupal enables any missing
  dependency automatically.

There are no third‑party Composer or PHP library requirements.

> **This is a beta release.** The 2.0.x line reports a `2.0.0-beta5` version. Test it
> against your booking content before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/resource_conflict -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/resource_conflict -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en resource_conflict -y
```

## Verify it worked

Make sure a content type has a **Date range** field, then edit that content type and
open **Additional settings → Resource conflict** — you should see the option to
enable conflict checking and choose the Date range field. See the "How to use it"
section of the [overview](../index.md) for the full walkthrough.
